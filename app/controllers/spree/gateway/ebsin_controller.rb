require 'base64'
require 'digest/md5'
require 'spree_ebsin/rc4'

module Spree
  class Gateway::EbsinController < Spree::StoreController
    helper 'spree/orders'
    skip_before_filter :verify_authenticity_token, :only => [:comeback]

    # Show form EBS for payment
    def show
      load_order
      @order.payments.destroy_all
      @hash = Digest::MD5.hexdigest([@gateway.preferred_secret_key, @gateway.preferred_account_id, @order.total.to_s, @order.number, [gateway_ebsin_comeback_url(@order),'DR={DR}'].join('?'), @gateway.preferred_mode].join('|'))
      payment = @order.payments.create!(:amount => 0,  :payment_method_id => @gateway.id)

      if @order.blank? || @gateway.blank?
        flash[:error] = Spree.t(:invalid_arguments)
        redirect_to :back
      else
        @bill_address, @ship_address =  @order.bill_address, (@order.ship_address || @order.bill_address)
        render :action => :show
      end
    end

    # Comback from EBS
    def comeback
      load_order
      @data = ebsin_decode(params[:DR], @gateway.preferred_secret_key)
      if  (@data) &&
          (@data["ResponseMessage"] == "Transaction Successful") &&
          (@data["ResponseCode"] == "0") &&
          (@data["MerchantRefNo"] == @order.number.to_s) &&
          (@data["Amount"].to_f == @order.outstanding_balance.to_f)

        ebsin_payment_success
        
        redirect_to order_url(@order, {:checkout_complete => true, :token => @order.token}), :notice => Spree.t(:payment_success)
      else
        flash[:error] = Spree.t(:ebsin_payment_response_error, {:error_message => @data["ResponseMessage"]})
        redirect_to (@order.blank? ? root_url : edit_order_url(@order, {:token => @order.token}))
      end

    end

    private
      def load_order
        @order   = current_order || Spree::Order.find_by_number(params[:id])
        @gateway = params[:gateway_id].blank? ? @order.payments.last.payment_method : @order.available_payment_methods.find{|x| x.id == params[:gateway_id].to_i }
      end

      # processing geteway's comback data
      def ebsin_decode(data, key)
        rc4 = SpreeEbsin::RC4.new(key)
        (Hash[rc4.encrypt(Base64.decode64(data.gsub(/ /,'+'))).split('&').map{ |x| x.split("=") }]).slice(* Spree::Ebsinfo::NECESSARY )
      end

      # save the payment record and complete the order
      def ebsin_payment_success
        source = Spree::Ebsinfo.create(:first_name => @order.bill_address.firstname, :last_name => @order.bill_address.lastname, :transaction_id => @data["TransactionID"], :payment_id => @data["PaymentID"], :amount => @data["Amount"], :order_id => @order.id)

        ebs_payment_method = Spree::PaymentMethod::Ebsin.last
        payment = @order.payments.where(:payment_method_id => ebs_payment_method.id).first
        payment = @order.payments.create!(:amount => 0,  :payment_method_id => ebs_payment_method.id) if payment.blank?
        payment.source = source
        payment.amount = source.amount
        payment.save
        payment.complete!

        @order.reload
        @order.next
        @order.state = 'complete'
        @order.save
        
        session[:order_id] = nil
        
        @order.finalize!
      end
    end
end
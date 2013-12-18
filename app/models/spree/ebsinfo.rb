module Spree  
  class Ebsinfo < ActiveRecord::Base
    # attr_accessible :first_name, :last_name, :transaction_id, :payment_id, :amount, :order_id

    belongs_to :order, :class_name => 'Spree::Order'

    NECESSARY = %w(Mode PaymentID DateCreated MerchantRefNo Amount TransactionID ResponseCode ResponseMessage).freeze

    def actions
      %w(mark_as_captured void)
    end
    
    # Indicates whether it's possible to capture the payment
    def can_mark_as_captured?(payment)
      ['checkout', 'pending'].include?(payment.state)
    end
    
    # Indicates whether it's possible to void the payment.
    def can_void?(payment)
      payment.state != 'void'
    end
    
    def mark_as_captured(payment)
      payment.update_attribute(:state, 'pending') if payment.state == 'checkout'
      payment.complete
      true
    end
    
    def void(payment)
      payment.update_attribute(:state, 'pending') if payment.state == 'checkout'
      payment.void
      true
    end
  end
end
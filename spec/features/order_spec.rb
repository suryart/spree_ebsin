require 'spec_helper'

describe 'Orders' do
  let!(:product) { create(:product, :available_on => 1.day.ago) }
  let!(:zone) { Spree::Zone.find_by_name("GlobalZone") || create(:global_zone) }
  let!(:shipping_method) { create(:shipping_method, :zones => [zone]) }
  let!(:country) { FactoryGirl.create(:country) }
  let!(:state) { country.states.first || FactoryGirl.create(:state, :country => country) }

  # let(:order) { OrderWalkthrough.up_to(:payment) }
  # let(:user) { create(:user) }

  # before do
  #   order.stub(:available_payment_methods => [create(:ebs_payment_method, :environment => 'test') ])
  #   order.update_attribute(:user_id, user.id)
  #   Spree::OrdersController.any_instance.stub(:try_spree_current_user => user)
  # end

  # stub_authorization!

  context 'User makes a payment using ebs' do
    before(:each) do
      create(:ebs_payment_method)

      @user = create(:user, :email => "email@person.com", :password => "secret", :password_confirmation => "secret")

      visit spree.root_path

      click_link 'Login'
      
      fill_in 'spree_user_email', :with => @user.email
      fill_in 'spree_user_password', :with => @user.password

      click_button "Login"

      click_link product.name
      click_button 'Add To Cart'
      click_button 'Checkout'

      fill_in 'order_bill_address_attributes_firstname', :with => 'Test'
      fill_in 'order_bill_address_attributes_lastname', :with => 'User'
      fill_in 'order_bill_address_attributes_address1', :with => 'Testing Address1'
      fill_in 'order_bill_address_attributes_address2', :with => 'Testing Street Address2'
      fill_in 'order_bill_address_attributes_city', :with => 'Test City'
      select state.name, :from => 'order_bill_address_attributes_state_id'

      fill_in 'order_bill_address_attributes_zipcode', :with => '35004'
      fill_in 'order_bill_address_attributes_phone', :with => '8888888888'

      click_button 'Save and Continue'
      click_button 'Save and Continue'
      click_button 'Save and Continue'
      
      sleep(20)

      fill_in 'frm_name_on_card', :with => 'Test User'
    end

    it "should be able to make an order with complete state", :js => true do
      fill_in 'number_1', :with => '4111'
      fill_in 'number_2', :with => '1111'
      fill_in 'number_3', :with => '1111'
      fill_in 'number_4', :with => '1111'
      select "07 (Jul)", :from => 'frm_exp_month'
      select "2016", :from => 'frm_exp_year'
      fill_in 'frm_cvv', :with => '123'

      click_button "Pay"

      sleep(10)

      page.should have_content(Spree.t(:payment_success))
      expect(@user.orders.complete.last.state).to eq("complete")
    end

    it "should be able to fail an order with payment state", :js => true do
      fill_in 'number_1', :with => '4111'
      fill_in 'number_2', :with => '1111'
      fill_in 'number_3', :with => '1111'
      fill_in 'number_4', :with => '1111'
      select "07 (Jul)", :from => 'frm_exp_month'
      select "2017", :from => 'frm_exp_year'
      fill_in 'frm_cvv', :with => '123'

      click_button "Pay"
      click_link "Merchant Website"

      page.should have_content("Transaction Failed. Payment was not successful.")
      expect(@user.orders.last.state).to eq("payment")
    end
  end
  
end

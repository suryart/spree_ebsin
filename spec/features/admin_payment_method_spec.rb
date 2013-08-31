require 'spec_helper'

describe 'Orders' do
  stub_authorization!
  
  context "admin creating and update a new payment method" do
    it 'should be able to create a new payment method for Ebs and update preferences' do
      visit spree.admin_path
      click_link "Configuration"

      click_link "Payment Methods"
      click_link "admin_new_payment_methods_link"

      fill_in "payment_method_name", :with => "Credit Card / Debit Card / Net Banking"
      fill_in "payment_method_description", :with => "Testing Credit Card / Debit Card / Net Banking Payment using EBS"

      select "PaymentMethod::Ebsin", :from => "gtwy-type"
      select Rails.env.to_s.humanize, :from => "gtwy-env"

      click_button "Create"
      page.should have_content("successfully created!")

      expect(find_field('payment_method_ebsin_preferred_url').value).to eq("https://secure.ebs.in/pg/ma/sale/pay/")

      fill_in 'payment_method_ebsin_preferred_account_id', :with => "5880"
      fill_in 'payment_method_ebsin_preferred_secret_key', :with => "ebskey"
      fill_in 'payment_method_ebsin_preferred_mode', :with => "TEST"
      fill_in 'payment_method_ebsin_preferred_currency_code', :with => "INR"
      select 'Both', :from => "payment_method_display_on"

      click_button "Update"
      page.should have_content("successfully updated!")

      find_field("payment_method_name").value.should == "Credit Card / Debit Card / Net Banking"
    end
  end
end
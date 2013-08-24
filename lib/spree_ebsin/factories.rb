FactoryGirl.define do
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_ebsin/factories'

  factory :ebs_payment_method, :class => Spree::PaymentMethod::Ebsin do
    name 'Credit Card / Debit Card / Net Banking'
    environment 'test'
    
    after(:create) do |payment_method|
      payment_method.preferred_currency_code = "INR"
      payment_method.preferred_secret_key = "ebskey"
      payment_method.preferred_url = "https://secure.ebs.in/pg/ma/sale/pay/"
      payment_method.preferred_account_id = "5880"
      payment_method.preferred_mode = "TEST"
    end
  end
end

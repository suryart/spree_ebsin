module Spree
  class PaymentMethod::Ebsin < PaymentMethod

    preference :account_id,    :string
    preference :url,           :string, :default =>  "https://secure.ebs.in/pg/ma/payment/request"
    preference :secret_key,    :string
    preference :mode,          :string
    preference :currency_code, :string

    def payment_profiles_supported?
      false
    end
  end
end
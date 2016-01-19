module Spree
  class PaymentMethod::Ebsin < PaymentMethod

    preference :account_id,    :string
    preference :url,           :string, :default =>  "https://secure.ebs.in/pg/ma/payment/request"
    preference :secret_key,    :string
    preference :mode,          :string
    preference :currency_code, :string
    preference :channel,       :integer, :default => 0

    validate :preferred_channel_value

    def payment_profiles_supported?
      false
    end

    private
    def preferred_channel_value
      unless [0, 1, 2].include?(preferred_channel)
        errors.add(:preferred_channel, :should_have_valid_channel_values)
      end
    end
  end
end
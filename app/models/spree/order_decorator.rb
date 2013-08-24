module Spree
  Order.class_eval do
    has_one :ebsinfo, :class_name => 'Spree::Ebsinfo'
  end
end
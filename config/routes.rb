Spree::Core::Engine.routes.draw do
  namespace :gateway do
    match '/:gateway_id/ebsin/:id' => 'ebsin#show',     :as => :ebsin
    match '/ebsin/:id/comeback'    => 'ebsin#comeback', :as => :ebsin_comeback
  end
end

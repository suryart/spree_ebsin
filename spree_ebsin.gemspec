# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_ebsin'
  s.version     = '2.0.1'
  s.summary     = 'Adds Ebsin as a Payment Method to Spree store'
  s.description = 'Adds Ebsin Payment Method option in admin, which can be enabled for payments using Ebsin(http://www.ebs.in/) on your Spree store.'
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'Surya Tripathi'
  s.email     = 'raj.surya19@gmail.com'
  s.homepage  = 'https://github.com/suryart/spree_ebsin'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.0.0'

  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner', '1.0.1'
  s.add_development_dependency 'factory_girl', '~> 4.2'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.13'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end

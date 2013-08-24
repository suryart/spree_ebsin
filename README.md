[![Code Climate](https://codeclimate.com/github/suryart/spree_ebsin.png)](https://codeclimate.com/github/suryart/spree_ebsin)
[![Build Status](https://travis-ci.org/suryart/spree_ebsin.png?branch=master)](https://travis-ci.org/suryart/spree_ebsin)
[![Coverage Status](https://coveralls.io/repos/suryart/spree_ebsin/badge.png)](https://coveralls.io/r/suryart/spree_ebsin)

# Welcome to Spree Ebsin

This is [EBS](http://www.ebs.in) Payment Gateway Extension for Spree. It has been extended to support Spree's Billing Integrations which allows users to configure the Ebs Payment gateway via the Admin UI.

Installation
------------

Add spree_ebsin to your Gemfile:

```ruby
gem 'spree_ebsin'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_ebsin:install
```

## TODOs

* Enhance the admin interface for refund and capture options.

## Testing

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_ebsin/factories'
```

Also, here is the link to: [Credit Card Payment Credentials for Testing](https://support.ebs.in/app/index.php?/default_import/Knowledgebase/Article/View/339/0/what-is-the-test-credentials-for-testing-the-credit-payment-option)


## Contributing

1. [Fork](https://help.github.com/articles/fork-a-repo) the project
2. Make one or more well commented and clean commits to the repository. You can make a new branch here if you are modifying more than one part or feature.
3. Add tests for it. This is important so I don’t break it in a future version unintentionally.
4. Perform a [pull request](https://help.github.com/articles/using-pull-requests) in github's web interface.

## NOTE

The current version supports Spree 2.0.0 or above. Older versions of Spree are unlikely to work, so attempt at your own risk.

Copyright (c) 2013 Surya Tripathi, released under the New BSD License

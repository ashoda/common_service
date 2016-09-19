# Common Service

Simple service object implementation with support for input validation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'common_service'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install common_service

## Basic Usage

```ruby
class AccountCreator < CommonService::ActionObject
  attr_reader :result, :meta

  def call
    account = Account.new(form_object.to_h)
    account.save!

    @result, @meta = account, { meta: 'data' }
  end
end

class AccountsController < ApplicationController
  def create
    account_creator = AccountCreator.call(params)
    account = account_creator.result
    meta = account_creator.meta

    render json: { data: account, meta: meta }
  end
end
```

## Usage with inline form and validation

```ruby
class AccountCreator < CommonService::ActionObject
  form do
    attribute :first_name, String
    attribute :last_name, String
    attribute :age, Integer

    validates :first_name, presence: true
    validates :age, presence: true
  end

  attr_reader :result, :meta

  def call
    form_object.validate!
    account = Account.new(form_object.to_h)
    account.save!

    @result, @meta = account, { meta: 'data' }
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/common_service. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

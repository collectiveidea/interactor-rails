# Interactor Rails

[![Gem](https://img.shields.io/gem/v/interactor-rails.svg?style=flat-square)](http://rubygems.org/gems/interactor-rails)
[![Build](https://github.com/collectiveidea/interactor-rails/actions/workflows/tests.yml/badge.svg)](https://github.com/collectiveidea/interactor-rails/actions/workflows/tests.yml)
[![Coverage](https://img.shields.io/codeclimate/coverage-letter/collectiveidea/interactor-rails.svg?style=flat-square)](https://codeclimate.com/github/collectiveidea/interactor-rails)
[![Maintainability](https://img.shields.io/codeclimate/maintainability/collectiveidea/interactor-rails.svg?style=flat-square)](https://codeclimate.com/github/collectiveidea/interactor-rails)

Interactor Rails provides Rails support for the
[Interactor](https://github.com/collectiveidea/interactor) gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "interactor-rails", "~> 2.0"
```

Interactor Rails is tested against Ruby 3.1 and newer on Rails 7.0 or newer.
For older versions of Ruby and Rails use version 2.2.1.

## Usage

Interactor Rails ensures that `app/interactors` is included in your autoload
paths, and provides generators for your convenience.

```bash
rails generate interactor authenticate_user
```

adds to `app/interactors/authenticate_user.rb`:

```ruby
class AuthenticateUser
  include Interactor

  def call
    # TODO
  end
end
```

There is also a generator for organizers.

```bash
rails generate interactor:organizer place_order charge_card send_thank_you fulfill_order
```

adds to `app/interactors/place_order.rb`:

```ruby
class PlaceOrder
  include Interactor::Organizer

  organize ChargeCard, SendThankYou, FulfillOrder
end
```

## Contributions

Interactor Rails is open source and contributions from the community are
encouraged! No contribution is too small.

See Interactor Rails'
[contribution guidelines](CONTRIBUTING.md) for more information.

## Thank You!

A very special thank you to [Attila Domokos](https://github.com/adomokos) for
his fantastic work on [LightService](https://github.com/adomokos/light-service).
Interactor is inspired heavily by the concepts put to code by Attila.

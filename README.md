# Interactor Rails

[![Gem Version](https://badge.fury.io/rb/interactor-rails.png)](http://badge.fury.io/rb/interactor-rails)
[![Build Status](https://travis-ci.org/collectiveidea/interactor-rails.png?branch=master)](https://travis-ci.org/collectiveidea/interactor-rails)
[![Code Climate](https://codeclimate.com/github/collectiveidea/interactor-rails.png)](https://codeclimate.com/github/collectiveidea/interactor-rails)
[![Coverage Status](https://coveralls.io/repos/collectiveidea/interactor-rails/badge.png?branch=master)](https://coveralls.io/r/collectiveidea/interactor-rails?branch=master)
[![Dependency Status](https://gemnasium.com/collectiveidea/interactor-rails.png)](https://gemnasium.com/collectiveidea/interactor-rails)

Interactor Rails provides Rails support for the
[Interactor](https://github.com/collectiveidea/interactor) gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "interactor-rails", "~> 1.0"
```

Interactor Rails is compatible with Ruby 1.9 or 2.0 on Rails 3 or 4.

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

  def perform
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

## Contributing

Interactor is open source and contributions from the community are encouraged!
No contribution is too small. Please consider:

* adding an awesome feature
* fixing a terrible bug
* updating documentation
* fixing a not-so-bad bug
* fixing typos

For the best chance of having your changes merged, please:

1. Ask us! We'd love to hear what you're up to.
2. Fork the project.
3. Commit your changes and tests (if applicable (they're applicable)).
4. Submit a pull request with a thorough explanation and at least one animated GIF.

## Thanks

A very special thank you to [Attila Domokos](https://github.com/adomokos) for
his fantastic work on [LightService](https://github.com/adomokos/light-service).
Interactor is inspired heavily by the concepts put to code by Attila.

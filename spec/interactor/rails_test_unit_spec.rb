module Interactor
  describe "Rails using Test::Unit" do
    def last_command_started
      # Account for older versions of Aruba as required by Rails 3.0
      Aruba::Api.method_defined?(:last_command_started) ? super : last_command
    end

    before do
      run_command_and_stop <<-CMD
        bundle exec rails new example \
          --skip-yarn \
          --skip-gemfile \
          --skip-git \
          --skip-keeps \
          --skip-action-mailer \
          --skip-active-record \
          --skip-puma \
          --skip-action-cable \
          --skip-sprockets \
          --skip-spring \
          --skip-listen \
          --skip-coffee \
          --skip-javascript \
          --skip-turbolinks \
          --skip-system-test \
          --skip-bundle \
          --skip-bootsnap \
          --quiet
        CMD
      cd "example"
      write_file "Gemfile", <<-EOF
        gem "rails"
        gem "interactor-rails", path: "#{ROOT}"
        EOF
      run_command_and_stop "bundle install"
    end

    it "generates test instead of spec" do
      run_command_and_stop "bundle exec rails generate interactor invoice/place_order"

      path = "spec/interactors/invoice/place_order_spec.rb"
      expect(path).not_to be_an_existing_file

      path = "test/interactors/invoice/place_order_test.rb"
      expect(path).to be_an_existing_file

      expect(path).to have_file_content(<<-EOF)
require 'test_helper'

class Invoice::PlaceOrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
EOF
    end
  end
end



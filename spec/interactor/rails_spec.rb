require "spec_helper"

module Interactor
  describe Rails do
    before do
      run_simple <<-CMD
        bundle exec rails new example \
          --skip-gemfile \
          --skip-bundle \
          --skip-git \
          --skip-keeps \
          --skip-active-record \
          --skip-sprockets \
          --skip-javascript \
          --skip-test-unit \
          --quiet
        CMD
      cd "example"
      write_file "Gemfile", <<-EOF
        gem "rails"
        gem "interactor-rails", path: "#{ROOT}"
        EOF
      run_simple "bundle install"
    end

    context "rails generate" do
      context "interactor" do
        it "generates an interactor" do
          run_simple "bundle exec rails generate interactor place_order"

          path = "app/interactors/place_order.rb"
          check_file_presence([path], true)
          check_exact_file_content(path, <<-EOF)
class PlaceOrder
  include Interactor

  def perform
    # TODO
  end
end
EOF
        end

        it "requires a name" do
          run_simple "bundle exec rails generate interactor"

          check_file_presence(["app/interactors/place_order.rb"], false)
          assert_partial_output("rails generate interactor NAME", all_stdout)
        end
      end

      context "interactor:organizer" do
        it "generates an organizer" do
          run_simple <<-CMD
            bundle exec rails generate interactor:organizer place_order
            CMD

          path = "app/interactors/place_order.rb"
          check_file_presence([path], true)
          check_exact_file_content(path, <<-EOF)
class PlaceOrder
  include Interactor::Organizer

  # organize Interactor1, Interactor2
end
EOF
        end

        it "generates an organizer with interactors" do
          run_simple <<-CMD
            bundle exec rails generate interactor:organizer place_order \
              charge_card fulfill_order
            CMD

          path = "app/interactors/place_order.rb"
          check_file_presence([path], true)
          check_exact_file_content(path, <<-EOF)
class PlaceOrder
  include Interactor::Organizer

  organize ChargeCard, FulfillOrder
end
EOF
        end

        it "requires a name" do
          run_simple "bundle exec rails generate interactor:organizer"

          check_file_presence(["app/interactors/place_order.rb"], false)
          assert_partial_output("rails generate interactor:organizer NAME", all_stdout)
        end
      end
    end

    it "adds app/interactors to autoload_paths"
  end
end

module Interactor
  describe "Rails" do
    before do
      run_command_and_stop <<~CMD
        bundle exec rails new example \
          --skip-git \
          --skip-keeps \
          --skip-action-mailer \
          --skip-action-mailbox \
          --skip-action-text \
          --skip-action-cable \
          --skip-active-record \
          --skip-active-job \
          --skip-active-storage \
          --skip-asset-pipeline \
          --skip-spring \
          --skip-listen \
          --skip-coffee \
          --skip-javascript \
          --skip-turbolinks \
          --skip-test-unit \
          --skip-test \
          --skip-system-test \
          --skip-bundle \
          --skip-bootsnap \
          --quiet
      CMD

      cd "example"
      write_file "Gemfile", <<~FILE
        gem "rails"
        gem "interactor-rails", path: "#{ROOT}"
      FILE

      run_command_and_stop "bundle install"
    end

    context "rails generate" do
      context "interactor" do
        it "generates an interactor and spec" do
          run_command_and_stop "bundle exec rails generate interactor place_order"

          path = "app/interactors/place_order.rb"
          expect(path).to be_an_existing_file
          expect(path).to have_file_content(<<~FILE)
            class PlaceOrder
              include Interactor

              def call
                # TODO
              end
            end
          FILE

          path = "spec/interactors/place_order_spec.rb"
          expect(path).to be_an_existing_file
          expect(path).to have_file_content(<<~FILE)
            require "spec_helper"

            RSpec.describe PlaceOrder, type: :interactor do
              describe '.call' do
                pending "add some examples to (or delete) \#{__FILE__}"
              end
            end
          FILE
        end

        it "requires a name" do
          run_command_and_stop "bundle exec rails generate interactor"

          expect("app/interactors/place_order.rb").not_to be_an_existing_file
          expect(last_command_started.stdout).to include("rails generate interactor NAME")
        end

        it "handles namespacing" do
          run_command_and_stop "bundle exec rails generate interactor invoice/place_order"

          path = "app/interactors/invoice/place_order.rb"
          expect(path).to be_an_existing_file
          expect(path).to have_file_content(<<~FILE)
            class Invoice::PlaceOrder
              include Interactor

              def call
                # TODO
              end
            end
          FILE

          path = "spec/interactors/invoice/place_order_spec.rb"
          expect(path).to be_an_existing_file
          expect(path).to have_file_content(<<~FILE)
            require "spec_helper"

            RSpec.describe Invoice::PlaceOrder, type: :interactor do
              describe '.call' do
                pending "add some examples to (or delete) \#{__FILE__}"
              end
            end
          FILE
        end
      end

      context "interactor:organizer" do
        it "generates an organizer" do
          run_command_and_stop <<~CMD
            bundle exec rails generate interactor:organizer place_order
          CMD

          path = "app/interactors/place_order.rb"
          expect(path).to be_an_existing_file
          expect(path).to have_file_content(<<~FILE)
            class PlaceOrder
              include Interactor::Organizer

              # organize Interactor1, Interactor2
            end
          FILE

          path = "spec/interactors/place_order_spec.rb"
          expect(path).to be_an_existing_file
          expect(path).to have_file_content(<<~FILE)
            require "spec_helper"

            RSpec.describe PlaceOrder, type: :interactor do
              describe '.call' do
                pending "add some examples to (or delete) \#{__FILE__}"
              end
            end
          FILE
        end

        it "generates an organizer with interactors" do
          run_command_and_stop <<~CMD
            bundle exec rails generate interactor:organizer place_order \
              charge_card fulfill_order
          CMD

          path = "app/interactors/place_order.rb"
          expect(path).to be_an_existing_file
          expect(path).to have_file_content(<<~FILE)
            class PlaceOrder
              include Interactor::Organizer

              organize ChargeCard, FulfillOrder
            end
          FILE
        end

        it "requires a name" do
          run_command_and_stop "bundle exec rails generate interactor:organizer"

          expect("app/interactors/place_order.rb").not_to be_an_existing_file
          expect(last_command_started.stdout).to include("rails generate interactor:organizer NAME")
        end

        it "handles namespacing" do
          run_command_and_stop "bundle exec rails generate interactor:organizer invoice/place_order"

          path = "app/interactors/invoice/place_order.rb"
          expect(path).to be_an_existing_file
          expect(path).to have_file_content(<<~FILE)
            class Invoice::PlaceOrder
              include Interactor::Organizer

              # organize Interactor1, Interactor2
            end
          FILE

          path = "spec/interactors/invoice/place_order_spec.rb"
          expect(path).to be_an_existing_file
          expect(path).to have_file_content(<<~FILE)
            require "spec_helper"

            RSpec.describe Invoice::PlaceOrder, type: :interactor do
              describe '.call' do
                pending "add some examples to (or delete) \#{__FILE__}"
              end
            end
          FILE
        end
      end

      it "prefers rails_helper if available" do
        write_file "spec/rails_helper.rb", <<~FILE
          require "spec_helper"
        FILE

        run_command_and_stop "bundle exec rails generate interactor place_order"

        path = "spec/interactors/place_order_spec.rb"
        expect(path).to be_an_existing_file
        expect(path).to have_file_content(<<~FILE)
          require "rails_helper"

          RSpec.describe PlaceOrder, type: :interactor do
            describe '.call' do
              pending "add some examples to (or delete) \#{__FILE__}"
            end
          end
        FILE
      ensure
        remove("spec/rails_helper.rb")
      end
    end

    it "support test unit instead of rspec" do
      # Enable test-unit support since it is skipped while generating the app.
      write_file "config/initializers/test_unit.rb", <<~FILE
        require "rails/test_unit/railtie"
      FILE

      run_command_and_stop "bundle exec rails generate interactor invoice/place_order"

      path = "spec/interactors/invoice/place_order_spec.rb"
      expect(path).not_to be_an_existing_file

      path = "test/interactors/invoice/place_order_test.rb"
      expect(path).to be_an_existing_file

      expect(path).to have_file_content(<<~FILE)
        require "test_helper"

        class Invoice::PlaceOrderTest < ActiveSupport::TestCase
          # test "the truth" do
          #   assert true
          # end
        end
      FILE
    ensure
      remove("config/initializers/test_unit.rb")
    end

    it "auto-loads interactors" do
      run_command_and_stop "bundle exec rails generate interactor place_order"
      run_command_and_stop "bundle exec rails runner PlaceOrder"
    end

    it "auto-loads organizers" do
      run_command_and_stop "bundle exec rails generate interactor:organizer place_order"
      run_command_and_stop "bundle exec rails runner PlaceOrder"
    end
  end
end

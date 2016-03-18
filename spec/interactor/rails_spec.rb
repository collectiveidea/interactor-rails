module Interactor
  describe "Rails" do
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
          expect(path).to be_an_existing_file
          expect(path).to have_file_content(<<-EOF)
class PlaceOrder
  include Interactor

  def call
    # TODO
  end
end
EOF
        end

        it "requires a name" do
          run_simple "bundle exec rails generate interactor"

          expect("app/interactors/place_order.rb").not_to be_an_existing_file
          expect(last_command_started).to have_output_on_stdout(/rails generate interactor NAME/)
        end

        it "handles namespacing" do
          run_simple "bundle exec rails generate interactor invoice/place_order"

          path = "app/interactors/invoice/place_order.rb"
          expect(path).to be_an_existing_file
          expect(path).to have_file_content(<<-EOF)
class Invoice::PlaceOrder
  include Interactor

  def call
    # TODO
  end
end
EOF
        end
      end

      context "interactor:organizer" do
        it "generates an organizer" do
          run_simple <<-CMD
            bundle exec rails generate interactor:organizer place_order
            CMD

          path = "app/interactors/place_order.rb"
          expect(path).to be_an_existing_file
          expect(path).to have_file_content(<<-EOF)
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
          expect(path).to be_an_existing_file
          expect(path).to have_file_content(<<-EOF)
class PlaceOrder
  include Interactor::Organizer

  organize ChargeCard, FulfillOrder
end
EOF
        end

        it "requires a name" do
          run_simple "bundle exec rails generate interactor:organizer"

          expect("app/interactors/place_order.rb").not_to be_an_existing_file
          expect(last_command_started).to have_output_on_stdout(/rails generate interactor:organizer NAME/)
        end

        it "handles namespacing" do
          run_simple "bundle exec rails generate interactor:organizer invoice/place_order"

          path = "app/interactors/invoice/place_order.rb"
          expect(path).to be_an_existing_file
          expect(path).to have_file_content(<<-EOF)
class Invoice::PlaceOrder
  include Interactor::Organizer

  # organize Interactor1, Interactor2
end
EOF
        end
      end
    end

    it "auto-loads interactors" do
      run_simple "bundle exec rails generate interactor place_order"

      run_simple "bundle exec rails runner PlaceOrder"
    end

    it "auto-loads organizers" do
      run_simple "bundle exec rails generate interactor:organizer place_order"

      run_simple "bundle exec rails runner PlaceOrder"
    end
  end
end

module Interactor
  class Generator < ::Rails::Generators::NamedBase
    def self.source_root
      File.expand_path("templates", __dir__)
    end

    def generate
      template "#{self.class.generator_name}.erb", File.join("app/interactors", class_path, "#{file_name}.rb")
      template "spec.erb", File.join("spec/interactors", class_path, "#{file_name}_spec.rb")
    end

    def rspec_helper_file
      if File.exist?("spec/rails_helper.rb")
        "rails_helper"
      else
        "spec_helper"
      end
    end
  end
end

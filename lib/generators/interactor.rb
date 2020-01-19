module Interactor
  class Generator < ::Rails::Generators::NamedBase
    def self.source_root
      File.expand_path("../templates", __FILE__)
    end

    def generate
      template "#{self.class.generator_name}.erb", File.join("app/interactors", class_path, "#{file_name}.rb")

      if use_test_unit?
        template "test.erb", File.join("test/interactors", class_path, "#{file_name}_test.rb")
      else
        template "spec.erb", File.join("spec/interactors", class_path, "#{file_name}_spec.rb")
      end
    end

    def use_test_unit?
      ::Rails.application.config.generators.options[:rails][:test_framework] == :test_unit
    end
  end
end

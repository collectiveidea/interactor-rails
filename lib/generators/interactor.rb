module Interactor
  class Generator < ::Rails::Generators::NamedBase
    def self.source_root
      File.expand_path("../templates", __FILE__)
    end

    def generate
      template "#{self.class.generator_name}.erb", File.join("app/interactors", class_path, "#{file_name}.rb")
      template "spec.erb", File.join("spec/interactors", class_path, "#{file_name}_spec.rb")
    end
  end
end

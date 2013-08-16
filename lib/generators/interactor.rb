module Interactor
  class Generator < ::Rails::Generators::NamedBase
    def self.source_root
      File.expand_path("../templates", __FILE__)
    end

    def generate
      template "#{self.class.generator_name}.erb", "app/interactors/#{file_name}.rb"
    end
  end
end

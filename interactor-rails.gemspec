# encoding: utf-8

Gem::Specification.new do |spec|
  spec.name    = "interactor-rails"
  spec.version = "1.0.2"

  spec.author      = "Collective Idea"
  spec.email       = "info@collectiveidea.com"
  spec.description = "Interactor Rails provides Rails support for the Interactor gem."
  spec.summary     = "Rails support for Interactor"
  spec.homepage    = "https://github.com/collectiveidea/interactor-rails"
  spec.license     = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(/^spec/)
  spec.require_paths = ["lib"]

  spec.add_dependency "interactor", "< 4"
  spec.add_dependency "rails", ">= 3", "< 5"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.1"
end

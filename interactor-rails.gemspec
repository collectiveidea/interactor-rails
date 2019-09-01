# encoding: utf-8

Gem::Specification.new do |spec|
  spec.name    = "interactor-rails"
  spec.version = "2.2.0"

  spec.author      = "Collective Idea"
  spec.email       = "info@collectiveidea.com"
  spec.description = "Interactor Rails provides Rails support for the Interactor gem."
  spec.summary     = "Rails support for Interactor"
  spec.homepage    = "https://github.com/collectiveidea/interactor-rails"
  spec.license     = "MIT"

  spec.files      = `git ls-files`.split($/)
  spec.test_files = spec.files.grep(/^spec/)

  spec.add_dependency "interactor", "~> 3.0"
  spec.add_dependency "rails", ">= 4.2"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end

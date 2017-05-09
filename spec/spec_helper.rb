if ENV["CODECLIMATE_REPO_TOKEN"]
  require "simplecov"
  SimpleCov.start
end

require "interactor/rails"

require "bundler"
Bundler.require(:test)

ROOT = File.expand_path("../..", __FILE__)

Dir[File.expand_path("../support/*.rb", __FILE__)].each { |f| require f }

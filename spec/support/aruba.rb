require "aruba/api"

RSpec.configure do |config|
  config.include(Aruba::Api)

  config.before do
    @aruba_timeout_seconds = 60
    FileUtils.rm_rf(current_dir)
    unset_bundler_env_vars
  end
end

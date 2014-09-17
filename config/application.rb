require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module AltmetricOrcidProfile
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
  end
end

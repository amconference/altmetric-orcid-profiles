require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module AltmetricOrcidProfile
  class Application < Rails::Application
  end
end

require_relative "boot"
require "rails/all"
Bundler.require(*Rails.groups)

module Daisyui
  class Application < Rails::Application
    config.load_defaults 7.0

    # I18n configuration
    config.i18n.default_locale = :es
    config.i18n.available_locales = [:en, :es]
    config.i18n.fallbacks = true
    config.i18n.enforce_available_locales = true
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]

    config.autoload_paths << Rails.root.join('lib')
  end
end

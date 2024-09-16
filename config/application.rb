require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EventsApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.hosts << "30f1-2001-8f8-1b2f-c001-a8ab-1d45-62a-1d3d.ngrok-free.app"
    # config.hosts << "3c85-2001-8f8-1b2f-c001-a8ab-1d45-62a-1d3d.ngrok-free.app"
    config.hosts << "suitably-growing-ox.ngrok-free.app"
  end
end

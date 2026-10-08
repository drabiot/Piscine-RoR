require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CheatSheet
  # Main Rails application class, responsible for configuration
  # and initialization of the CheatSheet app.
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end

LOG_FILE = Rails.root.join('entry_log.txt').to_s

def log_book; end   # affiche juste la vue

def log_book_create
  text = params[:entry].to_s.strip.gsub(/\s*\n\s*/, ' ')
  unless text.empty?
    File.open(LOG_FILE, 'a') { |f| f.puts "#{Time.now.strftime('%d/%m/%Y %H:%M:%S')} : #{text}" }
  end
  head :ok
end

def log_book_entries
  lines = File.exist?(LOG_FILE) ? File.readlines(LOG_FILE).map(&:chomp).reverse : []
  render json: lines
end

Weber::Application.configure do
  config.force_ssl = true

  # Code is not reloaded between requests
  config.cache_classes = true

  config.eager_load = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = true
  config.assets.compress = true
  config.assets.debug = false
end

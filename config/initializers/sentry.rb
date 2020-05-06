Raven.configure do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.attr = 'value'
end

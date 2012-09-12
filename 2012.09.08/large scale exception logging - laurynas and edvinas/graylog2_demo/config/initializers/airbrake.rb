Airbrake.configure do |config|
  config.host = 'graylog.night.lt'

  config.graylog2_facility = "my_unbreakable_app"
  config.graylog2_extra_args[:workshop] = '20120908'
end
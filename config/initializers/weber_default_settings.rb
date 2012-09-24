Weber::Application.configure do
  config.system_active = true
  config.default_max_reservation_period = 2.days
  config.reservation_min_lead_time = 3.days
  config.reservation_max_lead_time = 2.weeks
  config.reservation_absolute_max_lead_time = 3.months
end

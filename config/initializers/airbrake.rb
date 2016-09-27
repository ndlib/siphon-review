Airbrake.configure do |config|
  # config.project_id = true
  config.api_key = Rails.application.secrets.airbrake_key
  config.host    = "errbit.library.nd.edu"
  config.port    = 443
  config.secure  = config.port == 443
  config.user_attributes = [:id, :username, :name]
end

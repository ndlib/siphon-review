Airbrake.configure do |config|
  # config.project_id = true
  config.api_key = 'f548c80b6107730e9da0017b20761d96'
  config.host    = "errbit.library.nd.edu"
  config.port    = 443
  config.secure  = config.port == 443
  config.user_attributes = [:id, :username, :name]
end

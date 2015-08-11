class APIController < Faalis::APIController

  # Including `Setting::Loader` cause a before_filter method
  # executed on each request with will load the user settings data.
end

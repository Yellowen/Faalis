Rails.application.routes.draw do

  mount Faalis::Engine => '/'
  Faalis::Routes.define_api_routes do
    # Define your API routes here . . .
  end
  api_routes do
    # Your API routes goes here.
  end
  in_dashboard do
    # Your dashboard routes goes here.
  end
end

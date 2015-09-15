Rails.application.routes.draw do

  mount Faalis::Engine => '/'

  api_routes do
    # Your API routes goes here.
  end
  
  in_dashboard do
    # Your dashboard routes goes here.
  end

end

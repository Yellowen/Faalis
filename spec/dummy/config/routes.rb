Rails.application.routes.draw do

  mount Faalis::Engine => '/'

  in_dashboard do

  end

  api_routes do

  end

end

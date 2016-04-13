class Faalis::AssetsController < ApplicationController

  def finder
    module_path = ActionController::Base.helpers.path_to_asset(params[:asset])
    puts "<<<<<<<<<<<<<<<<<<<<<<<", module_path, params[:asset]
    redirect_to module_path
  end

end

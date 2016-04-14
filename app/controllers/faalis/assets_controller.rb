class Faalis::AssetsController < ApplicationController

  before_action :authenticate_user!

  def finder
    path = "#{params[:asset]}.amd"
    # It's important that the arg passed to asset_path already
    # be in precompile list
    module_path = ActionController::Base.helpers.asset_path(path,
                                                            type: :javascript)
    redirect_to module_path
  end

end

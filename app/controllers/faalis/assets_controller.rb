class Faalis::AssetsController < ApplicationController

  def finder
    # It's important that the arg passed to asset_path already
    # be in precompile list
    module_path = ActionController::Base.helpers.asset_path(params[:asset])
    redirect_to module_path
  end

end

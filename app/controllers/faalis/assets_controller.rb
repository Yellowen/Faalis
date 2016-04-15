class Faalis::AssetsController < ApplicationController

  include ::AMD::ControllerHelper
  before_action :authenticate_user!

end

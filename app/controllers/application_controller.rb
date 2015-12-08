class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_coordinates(id)
    [APP_BOARD_COORDINATES[id.to_i]['x'], APP_BOARD_COORDINATES[id.to_i]['y']]
  end
end

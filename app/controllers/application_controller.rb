class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # get coordinates mapping between front end array and board's Matrix object (initializer)
  def get_coordinates(id)
    [APP_BOARD_COORDINATES[id.to_i]['x'], APP_BOARD_COORDINATES[id.to_i]['y']]
  end
end

class GameController < ApplicationController
  def new
    render 'new'
  end

  def init
    @board = Board.new
    @players = PlayerList.new(params[:x], params[:o])
    @current_player = @players.current
    render 'init'
  end

  def over
    render 'over'
  end

  def turn
    coordinates = get_coordinates(params[:id])
    @board.mark(*coordinates, @current_player.symbol)
    redirect_to over if @board.finished? @current_player.symbol
    @players.next!

    respond_to do |format|
      format.json { render json: { board: @board.to_a } }
    end
  end
end

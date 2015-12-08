class GameController < ApplicationController
  def new
    render 'new'
  end

  def init
    session['board'] = @board = Board.new.matrix
    @players = PlayerList.new(params[:x], params[:o])
    session['players'] = @players.players
    session['current_player'] = @current_player = @players.current_player
  end

  def over
    render 'over'
  end

  def turn
    board = Board.new session['board']
    players = PlayerList.new session['players'][0]['name'], session['players'][1]['name'], session['current_player']
    coordinates = get_coordinates(params[:id]) #if id != nil or ""

    symbol = players.players[session['current_player'].to_i].symbol
    board.mark(coordinates[0], coordinates[1], symbol)
    finished = board.finished? symbol
    players.next!

    session['board'] = board.matrix
    session['players'] = players.players
    session['current_player'] = players.current_player

    respond_to do |format|
      format.json { render json: { board: board, players: players, current_player: players.current, finished: finished } }
    end
  end
end

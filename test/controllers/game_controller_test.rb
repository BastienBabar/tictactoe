require "test_helper"

class GameControllerTest < ActionController::TestCase
  
  tests GameController

  should 'render new action' do
    get :new
    assert_equal '200', response.code
  end

  should 'render init action' do
    post :init, { x: "Player x" ,o: "Player O" }

    board = Board.new
    players = PlayerList.new("Player x", "Player O")
    assert_equal 200, response.status
    assert_equal "Player x", players.players[0].name
    assert_equal "Player O", players.players[1].name
    assert_equal board.matrix, Matrix[["_", "_", "_"], ["_", "_", "_"], ["_", "_", "_"]]
    assert_equal board.matrix, request.session["board"]
    assert_equal players.players, request.session["players"]
    assert_equal players.current_player, request.session["current_player"]
  end

  should 'render turn action' do
    get :new, { params: { id: "1" } }

    players = PlayerList.new("Player X", "Player O", 0)
    request.session["board"] = Board.new.matrix.to_a
    request.session["players"] = players.players
    request.session["current_player"] = "0"

    post :turn, params: { id: "1" }, format: "json"

    assert_equal 200, response.status
    assert_equal 'x', assigns(:symbol)
    assert_equal [0, 1], assigns(:coordinates)
    assert_equal false, assigns(:finished)
    assert_equal 1, request.session["current_player"]
  end
end

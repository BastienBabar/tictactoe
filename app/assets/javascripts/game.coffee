# click on a square event to play
$ ->
  $('.square').on 'click', (e) ->
    $.ajax
      type: "POST"
      url: "/game/turn"
      data: ({id: e.toElement.id})
      context: e
    .done (data) ->
      turn data, this.toElement.id
  $('.new-game').on 'click', (e) ->
    location.href = "/"

# turn function that is handling frontend changes after ajax request successed
turn = (data, id) ->
  sq = $('.square#'+id)
  sq.toggleClass("square-" + data.symbol)
  sq.css("pointerEvents", "none")
  if data.finished
    finish_game(data)
  else
    $('#player').html(data.players.players[data.players.current_player].name)
    $('#symbol').html(data.players.players[data.players.current_player].symbol)

# finish function that is closing the game
finish_game = (data) ->
  $('.modal').modal('toggle')
  $("#board").toggleClass("board-full")
  $('.new-game').show().removeClass('hide')
  if(data.finished=="full")
    $('#game-result td.result').html('Tie...')
    $('#game-result tr.player').toggleClass('info')
    $('td.result').toggleClass('show').removeClass('hide')
    $('#over-message').html("It's a tie!")
  else
    $('#game-result tr.player').toggleClass('danger')
    $('td.result').toggleClass('show').removeClass('hide')
    current = $('#p' + data.players.current_player)
    current.toggleClass('success').removeClass('danger')
    $('#p' + data.players.current_player + ' td.result').html('Winner!')
    $('#over-message').html(data.name + " won the game!")

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.square').on 'click', (e) ->
    $.ajax
      type: "POST"
      url: "/game/turn"
      data: ({id: e.toElement.id})
      context: e
    .done (data) ->
      turn data, this.toElement.id

turn = (data, id) ->
  sq = $('.square#'+id)
  sq.toggleClass("square_" + data.symbol)
  sq.css("pointerEvents", "none")
  if data.finished
    finish_game(data)
  else
    $('#player').html(data.players.players[data.players.current_player].name)
    $('#symbol').html(data.players.players[data.players.current_player].symbol)

finish_game = (data) ->
  $("#board").toggleClass("board-full")
  switch(data.finished)
    when 'full'
      alert "It's a tie!"
    else
      alert data.name + " won!"


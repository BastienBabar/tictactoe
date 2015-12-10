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
  $('.new-game').on 'click', (e) ->
    location.href = "/"

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
  $('.modal').modal('toggle')
  $("#board").toggleClass("board-full")
  $('.new-game').show().removeClass('hide')
  switch(data.finished)
    when 'full'
      $('#game-result td.result').html('Tie...')
      $('#game-result tr.player').toggleClass('info')
      $('td.result').toggleClass('show').removeClass('hide')
      $('#over-message').html("It's a tie!")
    else
      $('#game-result tr.player').toggleClass('danger')
      $('td.result').toggleClass('show').removeClass('hide')
      $('#p' + data.players.current_player).toggleClass('success').removeClass('danger')
      $('#p' + data.players.current_player + ' td.result').html('Winner!')
      $('#over-message').html(data.name + " won the game!")

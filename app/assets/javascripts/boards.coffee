# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'page:change', ->
  # Grid weight: 0 for initial state, 1 for player one and 4 for player two
  COURT_VALUE = [0, 1, 4]

  # Store player names for view processing.
  players_name = [$('.grid').data('player_1_name'), $('.grid').data('player_2_name')]

  grid_initialization = ->
    this_grid = $('.grid')
    this_grid.each (index) ->
      current_player = $(this).data('current_player')
      if(current_player == COURT_VALUE[2])
        $(this).html('<i class="fa fa-check"></i>')
      else if(current_player == COURT_VALUE[1])
        $(this).html('<i class="fa fa-times"></i>')

    show_level_complete_popup(this_grid.data('board-status'), players_name)

  show_level_complete_popup = (status, players_name) ->
    if status == 'player_1_won'
      $('.grid').unbind('click') # Make sure after board has been finish, user can't able to click on grid
      $('#level-popup').show()
      $('#level-popup #message').text('The Board Is Win By ' + players_name[0])
    else if status == 'player_2_won'
      $('.grid').unbind('click')
      $('#level-popup').show()
      $('#level-popup #message').text('The Board Is Won By ' + players_name[1])
    else if status == 'drawn'
      $('.grid').unbind('click')
      $('#level-popup').show()
      $('#level-popup #message').text('The Board is ' + status)

  change_player_turn = (current_player, players) ->
    if(current_player == 1)
      $('#player-turn #player-name').html(players[0])
    else
      $('#player-turn #player-name').html(players[1])


  mark_grid = (grid, current_player) ->
    if(current_player == 1)
      grid.html('<i class="fa fa-check"></i>')
    else if current_player == 2
      grid.html('<i class="fa fa-times"></i>')

  $('.grid').unbind('click').click ->
    grid = $(this)
    row = grid.data('row-no')
    col = grid.data('col-no')

    $.ajax({
      data: {row: row, col: col}
      url: grid.data('next-move-url')
      dataType: 'json'
      type: 'POST'
      data: { row: row, col: col }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log(errorThrown)
      success: (data, textStatus, jqXHR) ->
        mark_grid(grid, data.current_player)
        show_level_complete_popup(data.status, players_name)
        change_player_turn(data.current_player, players_name);
    })

  # To generate the grid if it was previously played.
  grid_initialization()
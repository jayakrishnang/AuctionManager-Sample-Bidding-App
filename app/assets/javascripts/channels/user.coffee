App.user = App.cable.subscriptions.create "UserChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log('inside recieved')
    $('#bid_partial').append(data['bid_log'])

  call_bid: (amount, player_id, user_id)->
    @perform 'call_bid', amount:amount, player_id:player_id

  close_bid: (player_id)->
    @perform 'call_bid', player_id:player_id

$(document).ready ->
  $('#message-form').on "submit", (event)  ->
    amount = $(this).find('#bid_log_amount').val()
    player_id = $(this).find('#bid_log_player_id').val()
    console.log('inside form')
    App.user.call_bid amount, player_id
    event.target.value = ""

  $('#admin-message-form').on "submit", (event)  ->
    player_id = $(this).find('#bid_log_player_id').val()
    console.log('inside admin form')
    App.user.close_bid player_id
    event.target.value = ""

$ ->
  # Initiate date picker
  $("#datepicker").datepicker({dateFormat: "dd-mm-yy", changeMonth: true, changeYear: true, showOn: "button", buttonImage: "<%= asset_path('calendar.png') %>", buttonImageOnly: true});
  # Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

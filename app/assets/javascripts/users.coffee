# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	new AvatarCropper()

class AvatarCropper
	constructor: ->
	  $('#cropbox').Jcrop
	 	  aspectRatio: 1
	 	  setSelect: [0, 0, 400, 400]
	 	  onSelect: @update
	 	  onChange: @update
	update: (coords) =>
		$('#user_crop_x').val(coords.x)
		$('#user_crop_y').val(coords.y)
		$('#user_crop_w').val(coords.w)
		$('#user_crop_h').val(coords.h)
		
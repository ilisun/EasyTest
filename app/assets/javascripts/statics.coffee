ready = ->
  $('#slider > .sl').hide()
  $('#slider > .sl:nth-child(1)').show()
  counter = 0
  images = $('#slider > .sl').length

  $('#next').click (e) ->
    counter++
    x = counter % images
    if x == 0
      $('#slider > .sl:nth-child(2)').hide()
      $('#slider > .sl:first-child').show()
      $('#slider > .sl:nth-child(3)').fadeOut()
    if x == 2 or x == -1
      $('#slider > .sl:nth-child(3)').fadeIn()
    if x ==1 or x == -2
      $('#slider > .sl:nth-child(2)').fadeIn()

  $('#prev').click (e) ->
    counter--
    x = counter % images
    if x == 0
      $('#slider > .sl:nth-child(2)').fadeOut()
    if x == 1 or x == -2
      $('#slider > .sl:nth-child(2)').show()
      $('#slider > .sl:nth-child(3)').fadeOut()
    if x == 2 or x == -1
      $('#slider > .sl:nth-child(3)').fadeIn()

$ ->
  ready()

$(document).on "page:update", ->
  ready()

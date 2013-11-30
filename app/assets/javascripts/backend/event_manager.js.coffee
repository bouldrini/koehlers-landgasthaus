jQuery ($) ->
  $('.area_control').change (event) ->
    target = $(this).val()
    if target == 'Collage'
      $('.flyer_control').hide()
      $('#event_image').val('')
      $('.collage_control').show()
    else if target == 'Flyer'
      $('.collage_control').hide()
      $('#event_subtitle').val('')
      $('#event_body').val('')
      $('.flyer_control').show()
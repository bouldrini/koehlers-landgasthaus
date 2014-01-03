jQuery ($) ->

  $(document).ready (event) ->
    if $('.system_message_area').length > 0
      window.setTimeout( () ->
        $('.system_message_area').fadeOut(500)
      ,3000)

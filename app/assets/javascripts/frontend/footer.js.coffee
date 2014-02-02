jQuery ($) ->
  $(document).ready (event) ->
    window_height = window.innerHeight
    documen_height = document.body.offsetHeight

    if documen_height < window_height
      $('.footer').css('position', 'absolute').css('bottom', 0)

jQuery ($) ->
  $(document).ready (event) ->
    window_height = window.innerHeight
    documen_height = document.body.offsetHeight
    if documen_height < window_height
      console.log 'hit'
      $('.footer').css('position', 'absolute').css('bottom', 0)

jQuery ($) ->
  $(document).ready (event) ->
    window_height = window.innerHeight
    documen_height = document.body.offsetHeight
    console.log documen_height
    console.log window_height
    if documen_height < window_height
      console.log 'im absolute'
      $('.footer').css('position', 'absolute').css('bottom', 0)

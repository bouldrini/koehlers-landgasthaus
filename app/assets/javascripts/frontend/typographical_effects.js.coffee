@typographical_effects = (banner) ->
  $(window).scrollStopped () ->
    scrollTop = $(document).scrollTop()
    if banner
      if scrollTop > $(window).height() - 55 + 300
        pos = scrollTop - ($(window).height() - 55) - 180
      else
        pos = 0
    else
      if scrollTop <= 300
        pos = 0
      else
        pos = scrollTop - 300
    $('.yield-nav').animate({
      marginTop: pos
    },1000)

  # $(window).scroll (event) ->
  #   boxes = $('.hidden')
  #   $.each(boxes, (idx, obj) ->
  #     scrollTop = $(document).scrollTop()
  #     pos = $(obj).offset().top
  #     if (scrollTop > (pos - 400)) && (scrollTop <= pos)
  #       img_pos = scrollTop - (pos - 400)
  #       $(obj).children('.paragraph_slide_down').css('height', img_pos)
  #   )

jQuery ($) ->
  nav =
    scroll_in: () ->
      $(".close-nav-touch").hide()
      $('body').removeClass('noscroll')
      $(".nav-container").data('open', 'false')
      $(".nav-container").animate(
        {left: "-=102%"},
        500, () ->
      )
    scroll_out: () ->
      $('body').addClass('noscroll')
      $(".nav-container").data('open', 'true')
      $(".nav-container").animate(
        {left: "+=102%"},
        500, () ->
          $(".close-nav-touch").show()
      )
  $(document).on('click', '.open-nav-slider', (event) ->
    nav.scroll_out()
  )

  $(document).on('click', '.close-nav-slider', (event) ->
    nav.scroll_in()
  )

  # $(document).ready (event) ->
  #   name =  window.location.pathname
  #   tab = $('a[href="' + name + '"]')
  #   tab.addClass('active')
  #   screen_width = $(window).innerWidth()
  #   unless screen_width < 1200 && screen_width > 500
  #     tab.parents('.dropdown').show()
  #     $.each(tab.parents('.dropdown').siblings('.dropdown-toogle'), (index, obj) ->
  #       $(obj).addClass('active')
  #       $(obj).attr('data-open', 'true')
  #     )

  $('.main-nav').on('click', '.dropdown-toogle', (event) ->
    id = $(this).attr('id')
    open = $(this).attr('data-open')
    if open == 'true'
      $('.dropdown[id="' + id + '"]').slideUp('fast')
      $(this).attr('data-open', 'false')
      $(this).removeClass('active')
    else
      $('.dropdown[id="' + id + '"]').slideDown('fast')
      $(this).attr('data-open', 'true')
      $(this).addClass('active')
  )
  $('.nav-container').on('click', '.close-nav-touch', (event) ->
    nav.scroll_in()
  )

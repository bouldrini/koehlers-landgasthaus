@typographical_effects = (events) ->
  buffer = 200
  box = $('.event_box')
  space = $(document).height() / events.length
  $.each(events, (index, obj) ->
    obj['pos'] = index * space
  )

  $(window).scroll (e) ->
    width = $(this).innerWidth()
    if width > 1200
      pos = ($(window).scrollTop() - buffer)
      # console.log pos
      ar = []
      $.each(events, (index, obj) ->
        if (pos > obj.pos) && !(pos > (obj.pos + 600))
          ar.push(obj)
      )
      el = ar[ar.length - 1]
      if el
        if el.image
          box.children('.event_image').find('img').attr('src', el.image)
        else
          box.children('.event_image').find('img').attr('src', '')
        box.children('.event_title').html(el.title)
        box.children('.event_subtitle').html(el.subtitle)
        box.find('.event_start_at').html(el.start_at)
        box.find('.event_end_at').html(el.end_at)
        box.children('.event_body').html(el.body)
        unless box.hasClass('open')
          box.addClass('open')
          box.animate({
            right: '0'
          })
      else
        if box.hasClass('open')
          box.removeClass('open')
          box.animate({
            right: '-100%'
          })

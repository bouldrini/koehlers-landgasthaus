@calendar = (events) ->
  modal = $('#event_modal')
  $('#calendar').fullCalendar(
    events: events
    monthNames: ['Januar', 'Februar', 'März', 'April', 'Mai', 'Juni', 'Juli',
     'August', 'September', 'Oktober', 'November', 'Dezember'],
    dayNamesShort: ['Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag', 'Sonntag'],
    eventClick: (event, jsEvent, view) ->
      modal.find('.modal-title').html(event.title + "&nbsp;&nbsp;" + event.formatted_start)
      body = $("<img src='" + event.image + "' style='width:100%'></img><p/><h5>" + event.subtitle + "</h5><p/>" + event.body + "<br/>")
      modal.find('.modal-body').html(body)
      $('body').addClass('noscroll')
      modal.modal()
  )

  modal.on('hidden.bs.modal', () ->
    $('body').removeClass('noscroll')
  )

@plugins = () ->
  textareas = $('.html_editor')
  $.each(textareas, (index, obj) ->
    $(obj).wysihtml5();
  )

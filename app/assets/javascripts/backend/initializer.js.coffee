jQuery ($) ->
  textareas = $('.html_editor')
  $.each(textareas, (index, obj) ->
    $(obj).wysihtml5();
  )

  chosen = $('.chosen')
  $.each(chosen, (index, obj) ->
    $(obj).chosen(
      width: '100%'
    )
  )

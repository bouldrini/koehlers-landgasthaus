jQuery ($) ->
  $.each($('.ha'), (idx, obj) ->
    height = $(obj).parents('.hp').height()
    $(obj).css('height', height + 'px')
  )

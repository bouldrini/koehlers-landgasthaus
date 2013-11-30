jQuery ($) ->
  btn = $('.gallery_image_present_toogle')
  delete_btn = $('.delete_image')

  btn.click (event) ->
    active = $(this).attr('data-active')
    if active == 'false'
      $('.gallery_image_present').slideDown('slow')
      status = 'true'
      tag = "icon-chevron-up"
    else if active == 'true'
      $('.gallery_image_present').slideUp('slow')
      status = 'false'
      tag = 'icon-chevron-down'
    $(this).attr('data-active', status)
    $(this).html('Gallerie: <i class="' + tag + '"></i>')

  delete_btn.click (event) ->
    url = $(this).data('url')
    id = $(this).attr('id')
    $.ajax(url, {
      type: 'DELETE',
      success: (data) ->
        $('.gallery_image_box[id="' + id + '"]').remove()
    })

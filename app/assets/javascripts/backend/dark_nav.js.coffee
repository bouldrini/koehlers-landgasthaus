jQuery ($) ->
  $(document).ready (event) ->
    form = $('.dark_nav_sub_btn').parents('form')
    $('.dark_nav_sub_btn').appendTo('.dark_nav')
    $('.dark_nav_sub_btn').click (event) ->
      form.submit()
//= require_self
//= require bootstrap-wysihtml5
jQuery(function($){
  textareas = $('.html_editor')
  $.each(textareas, function(index, obj){
    $(obj).wysihtml5();
  });
});

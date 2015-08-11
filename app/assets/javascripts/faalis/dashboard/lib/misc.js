function fade_out_and_remove(selector) {
  $(selector).fadeOut(500, function(){
    $(this).remove();
  });
}

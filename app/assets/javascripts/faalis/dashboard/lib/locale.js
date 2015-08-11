/*
 * Check for page direction
 */
function is_ltr(){
  return $("html").attr("dir") == "ltr" ? true : false;
}


/*
 * Return current language of page
 */
function current_language(){
  return $("html").attr("lang");
}

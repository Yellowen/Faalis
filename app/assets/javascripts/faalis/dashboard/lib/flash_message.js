/*
 * Show a flash message on dashboard UI.
 *
 * Note: To create a theme for faalis dashboard
 *       you probably need to override this func
 *       in your theme assets.
 *
 * @OVERRIDE
 */
function show_flash_message(msg, klass) {
  var icon = "";

  if (klass == "success") {
    icon = "check";
  }
  else if (klass == "error") {
    icon = "ban";
    klass = 'danger';
  }
  else if (klass == 'warning') {
    icon = 'warning';
  }
  else if (klass == 'info') {
    icon = 'info';
  }

  $("#flash-alert").removeClass().addClass("alert alert-dismissable alert-" + klass);
  $("#flash-icon").removeClass().addClass("fa fa-" + icon);
  $("#flash-msg").html(msg);
  $("#flash-alert").fadeIn(700).delay(5000).fadeOut(500);
}

/*
 * Hide the flash area
 * @OVERRIDE
 */
function hide_flash() {
  $("#flash-alert").hide();
}

//TODO: Use a js template engine in here
/*
 * Render the form errors in a flash message and
 * highlight the problematic form controls
 *
 * Note: This function will highligh those elements with
 */
function form_error(data) {
  $('.has-error').removeClass('has-error');

  var msg = data.title + "<br/><ul>";
  delete data.title;

  Object.keys(data, function(k, v){
    msg += "<li><strong>" + k + "</strong> " + v + "</li>";
    $('input[name="' + k + '"], [data-name="' + k + '"]').addClass('has-error');
  });

  msg += "</ul>";

  error_message(msg);
}

function success_message(msg){ show_flash_message(msg, "success"); }
function warning_message(msg){ show_flash_message(msg, "warning"); }
function error_message(msg){ show_flash_message(msg, "error"); }


$(function(){
  $("#flash").on("click", hide_flash);
});

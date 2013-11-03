function show_flash_message(msg, klass) {
    var flash = $("#flash");
    $(flash).find("div").html(msg);
    $(flash).removeClass().addClass("row").addClass(klass).fadeIn(700).delay(5000).fadeOut(500);
}

function hide_flash() { $("#flash").hide(); }
function success_message(msg){ show_flash_message(msg, "success"); }
function warning_message(msg){ show_flash_message(msg, "warning"); }
function error_message(msg){ show_flash_message(msg, "error"); }

$(function(){
    $("#flash").on("click", hide_flash);
});

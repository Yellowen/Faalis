var guess_module = function() {
  var action_module = $("body").data('action');
  require([action_module], function(action_module){
    action_module.initialize();
  });
};

$(function(){
  guess_module();
});

$(document).on("page:changed", function(){
  guess_module();
});

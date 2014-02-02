
<<<<<<< HEAD
=======

>>>>>>> 660a14d5a0f6d73a18cf15200f1fe0e55cd33521

//= require faalis/dashboard/functions

// Get all the modules syncly
$.ajax({method: 'GET', type: 'json', async: false,
        url: DashboardURL + '/modules.json'})
    .success(function(data, status, headers, config){
        DModules = data.modules;

        DModules.forEach(function(module){
            dashboard_dependencies.push(camelCase(module.resource));
        });
    })
    .fail(function(data){
        ErrorQueue.push(_('Can not connect to remote, please try again'));
        return null;
    }).always(function(){
        $("#mainloader").hide();
        $("#content").show();
    });

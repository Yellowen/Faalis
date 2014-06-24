//= require faalis/dashboard/functions
//= require faalis/dashboard/objects
// Get all the modules syncly
$.ajax({method: 'GET', type: 'json', async: false,
        url: DashboardURL + '.json'})
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

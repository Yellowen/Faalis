var Logs = angular.module("Logs", ["ui.router"]);

Logs.config(["$stateProvider", function($stateProvider){

    $stateProvider.
        state("logs", {
            url: "/logs/",
            templateUrl: template("logs/index"),
            controller: "LogsController"
        });
}]);

Logs.controller("LogsController", ["$scope", "Restangular","$sce",
                                    function($scope, API, $sce){

    API.all("logs").getList().then(function(data){
        var content = data.content;
        content = content.replace(/\n/gm, "<br />");
        content = content.replace(/\t/gm, "&nbsp;");
        content = content.replace(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]/gm, "");
        $scope.logs = $sce.trustAsHtml(content);
    });

}]);

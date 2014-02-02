
<<<<<<< HEAD
=======
 ----------------------------------------------------------------------------- */
>>>>>>> 660a14d5a0f6d73a18cf15200f1fe0e55cd33521
var Conversation = angular.module("Conversation",["ListView", "Errors"]);


Conversation.config(["$routeProvider", function($routeProvider){
    $routeProvider.
        when("/conversations/:id/show",{
            templateUrl: template("conversations/show"),
            controller: "ConversationControllerIndex"
        }).
        when("/conversations/new",{
            templateUrl: template("conversations/new"),
            controller: "ConversationControllerNew"
        }).
        when("/conversations/:id/reply",{
            templateUrl: template("conversations/new"),
            controller: "ConversationControllerNew"
        }).
        when("/conversations/:type",{
            templateUrl: template("conversations/index"),
            controller: "ConversationControllerIndex"
        });
}]);

Conversation.controller("ConversationControllerIndex",["$scope", "Restangular", "gettext", "catch_error", "$routeParams","$location", function($scope, API, gettext, catch_error, $routeParams, $location){
    if ($routeParams.id){
        $scope.id = $routeParams.id;
        $scope.details_template = template("conversations/show_details");
        API.all("conversations").get($routeParams.id).then(function(data){
            $scope.conversations = data.messages;
        });
    }else{
            $scope.details_template = template("conversations/details");
        var type;
        switch ($routeParams.type){
        case "inbox":
            type = "inbox";
            break;
        case "sentbox":
            type = "sentbox";
            break;
        case "trash":
            type = "trash";
            break;
        default:
            $location.path("conversations/inbox/box");
        }
        API.all("conversations").all(type).all("box").getList().then(function(data){
            $scope.conversations = data;

        });
    }
    $scope.buttons = [
        {
            title: gettext("New"),
            icon: "fa fa-plus",
            classes: "btn tiny green",
            route: "#conversations/new"
        },
        {
            title: gettext("Sent box"),
            icon: "fa fa-plus",
            classes: "btn tiny green",
            route: "#/conversations/sentbox"
        },
        {
            title: gettext("Trash box"),
            icon: "fa fa-plus",
            classes: "btn tiny green",
            route: "#/conversations/trash"
        }
    ];

    $scope.message_title = function(conversation){
        return conversation.subject;
    };
    $scope.on_trash = function(conversations){
        var query = [];
        conversations.forEach(function(conversation){
            query.push(conversation.id);
        });
        API.all("conversations").all("trash").post({id: query.join(",")})
            .then(function(data) {

                $scope.conversations = _.filter($scope.Conversations, function(x){
                    return !(query.indexOf(x.id) != -1);
                });
                success_message(data.msg);
            })
            .catch(catch_error);

    };

    $scope.on_untrash = function(conversations){
        var query = [];
        conversations.forEach(function(conversation){
            query.push(conversation.id);
        });

        API.all("conversations",query.join(",")).post()
            .then(function(data) {

                $scope.conversations = _.filter($scope.Conversations, function(x){
                    return !(query.indexOf(x.id) != -1);
                });
                success_message(data.msg);
            })
            .catch(catch_error);
    };


}]);


Conversation.controller("ConversationControllerNew", ["$scope", "Restangular", "gettext", "catch_error", "$routeParams", "$location", function($scope, API, gettext, catch_error, $routeParams, $location){
    $scope.obj_id = null;
    if("id" in $routeParams){
        $scope.obj_id = $routeParams.id;
        var obj = API.all("conversations").get($routeParams.id)
                .then(function(data){
                    var recipients= [];
                    data.recipients.forEach(function(entry){
                        if( $.inArray(entry.email,recipients) == -1 )
                            recipients.push(entry.email);
                    });
                    $scope.recipients = recipients;
                    $scope.subject = "Re: " + data.subject;
                    $scope.body = "\n\n_____________\n"+data.body;
                });
    }

    $scope.save = function() {
        var conversation = {message:{
            recipients: $scope.recipients,
            subject: $scope.subject,
            body: $scope.body
        }};
        if ($scope.obj_id){
            API.all("conversations").one($scope.obj_id).one("reply").customPOST(conversation,"",{}).then(function(){
                success_message(gettext("Message sent successfully."));
                $location.path("conversations/inbox");
            });
        }else{
            API.all("conversations").post(conversation).then(function(){
                success_message(gettext("Message sent Successfully"));
                $location.path("conversations/inbox");
            }).catch(catch_error);
        }
    };

    $scope.cancel = function(){
        $(".form input").val("");
        $location.path("conversations/index");
    };


}]);

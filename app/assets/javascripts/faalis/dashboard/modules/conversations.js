/* -----------------------------------------------------------------------------
    Red Base - Basic website skel engine
    Copyright (C) 2012-2013 Yellowen

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
----------------------------------------------------------------------------- */
var Conversation = angular.module("Conversation",["ListView", "Errors"]);


Conversation.config(["$routeProvider", function($routeProvider){
    $routeProvider.
        when("/conversations/:id/show",{
            templateUrl: template("conversations/show"),
            controller: "ConversationControllerShow"
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
        $location.path("/");
    }
    API.all("conversations").all(type).getList().then(function(data){
        $scope.conversations = data;

    });

    $scope.buttons = [
        {
            title: gettext("New"),
            icon: "fa fa-plus",
            classes: "btn tiny green",
            route: "#/conversations/new"
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
}]);

Conversation.controller("ConversationControllerNew", ["$scope", "Restangular", "gettext", "catch_error", function($scope, API, gettext, catch_error){
    $scope.obj_id = null;
    if("id" in $routeParams){
        $scope.obj_id = $routeParams.id;
        var obj = API.one("conversations", $scope.obj_id).get()
                .then(function(data){
                    $scope.recipients = data.recipients;
                    $scope.subject = data.subject;
                    $scope.body = data.body;
                });
    }

    $scope.save = function() {
        var conversation = {
            recipients: $scope.recipients,
            subject: $scope.subject,
            body: $scope.body
        };

        if ($scope.obj_id){
            API.one("conversations",$scope.obj_id).post(conversations).then(function(){
                success_message(gettext("Message sent successfully."));
                $location.path("/conversations");
                });
        }else{
            API.all("conversations").post(conversations).then(function(){
                success_message(gettext("Message sent Successfully"));
                $location.path("/conversations");
            }).catch(catch_error);
        }
    };

    $scope.cancel = function(){
        $(".form input").val("");
        $location.path("conversations");
    };


    $scope.on_trash = function(conversations){
        var query = [];
        conversations.forEach(function(conversation){
            query.push(conversation.id);
        });

        API.all("conversations").customDELETE(query.join(","))
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

        API.all("conversations").customDELETE(query.join(","))
            .then(function(data) {

                $scope.conversations = _.filter($scope.Conversations, function(x){
                    return !(query.indexOf(x.id) != -1);
                });
                success_message(data.msg);
            })
            .catch(catch_error);

    };

}]);

var Image_ = angular.module("ImageField",[]);

/*
 * <image-field></image-field>
*/

Image_.directive('imageField',["gettext",function(gettext){
    function link(scope, element, attrs,ngModelController){
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";

        function updateModel(event){
          if(event.target && event.target.files){
            var file = event.target.files[0];
            var reader = new FileReader();
            reader.onload = function(e){
                scope.image = e.target.result;
            };
            reader.readAsDataURL(file);
          }
        }

        element.on('change',updateModel)

    }
    return {
        templateUrl: template("fields/image/image"),
        //getting deprecated
        //replace: true,
        restrict: "E",
        require: '?ngModel', // get a hold of NgModelController
        //transclude: true,

        link: link
    };

}]);




/*-------------
var Image_ = angular.module("DatetimeField", ['flow']);

/*
 * <image-field></image-field>
*/
/*---------
Image_.directive('imageField',["gettext", function(gettext){
    function link(scope, element, attrs){
        var ltr = is_ltr();
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";

        scope.fileChanged = function(){
            console.log("funckrun");
            //if (scope.internal_model){
            scope.$watch("model", function(newv, oldv, $scope) {

                f = document.getElementById(scope.element_id).files[0],
                r = new FileReader();
                r.onloadend = function(e){
                    console.log("dsfdsffdsfdsfsD");
                    scope.data = e.target.result;
                    //image: 'data:image/png;base64,'+btoa($scope.image.data),
                };
                r.readAsBinaryString(f);
            }, true);
        };
            // Watch event changes

                // TODO: maybe we should pass locals to $eval
               /* if (scope.on_change !== undefined) {
                    scope.$parent.$eval(scope.on_change);
                }
                scope.debug_ = scope.model;
                if (scope.internal_model){
                    f = document.getElementById(scope.element_id).files[0],
                    r = new FileReader();
                    r.onloadend = function(e){
                        var data = e.target.result;
                    }
                    r.readAsBinaryString(f);
                }
                */
/*------------------


    }
    return {
        templateUrl: template("fields/image/image"),
        replace: true,
        restrict: "E",
        transclude: true,
        scope: {

            cssClasses: '=cssClass',
            // A call back to pass to field ng-change directive
            on_change: "@onChange",
            // fieldname
            field: "=fieldName",
            required: "=",
            // Actual Angularjs ng-model
            model: '=',
            // image source
            src: '=',

            data: '='

        },
        link: link
    };

}]);
*/

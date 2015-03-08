var Image_ = angular.module("ImageField",[]);

/*
 * <image-field></image-field>
*/

Image_.directive('imageField',["gettext",function(gettext){
    function link(scope, element, attrs,ngModelController){
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";

        function updateModel(event){
            console.log("<<<");
          if(event.target && event.target.files){
            var file = event.target.files[0];
            var reader = new FileReader();
            reader.onload = function(e){
                scope.image = e.target.result;
                console.log("<<<<<<<<<<<<<<<<");
                console.log(scope.image);
            };
            reader.readAsDataURL(file);
          }
        }

        console.log(',,,,,,,,');
        $('#' + scope.element_id).bind('change',updateModel);

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

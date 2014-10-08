var Image_ = angular.module("ImageField",[]);

/*
 * <image-field></image-field>
*/

Image_.directive('imageField', ['$parse', function ($parse) {
    return {
        restrict: 'A',
        link: function(scope, element, attrs) {
            var model = $parse(attrs.imageField);
            var modelSetter = model.assign;

            element.bind('change', function(){
                scope.$apply(function(){
                    modelSetter(scope, element[0].files[0]);
                });
            });
        }
    };
}]);

//Image_.directive('imageField',["gettext",function(gettext){
//    function link(scope, element, attrs,ngModelController){
//        scope.element_id = "id_" + scope.field;
//        scope.msg_element_id = "id_" + scope.field + "_msg";
//
//        function updateModel(event){
//          if(event.target && event.target.files){
//            var file = event.target.files[0];
//            var reader = new FileReader();
//            reader.onload = function(e){
//                //scope.image = e.target.result;
//                var URL = window.URL || window.webkitURL;
//
//                scope.image = URL.createObjectURL(event.target.files);
//            };
//            reader.readAsDataURL(file);
//          }
//        }
//
//        element.on('change',updateModel)
//
//    }
//    return {
//        templateUrl: template("fields/image/image"),
//        //getting deprecated
//        //replace: true,
//        restrict: "E",
//        require: '?ngModel', // get a hold of NgModelController
//        //transclude: true,
//
//        link: link
//    };
//
//}]);

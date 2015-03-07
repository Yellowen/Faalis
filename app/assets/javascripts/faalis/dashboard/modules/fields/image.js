var Image_ = angular.module("ImageField",[]);

/*
 * <image-field></image-field>
*/

Image_.directive('imageField',["gettext", "$parse", function(gettext, $parse){
    function link(scope, element, attrs, ngctrl){
        console.group("ImageField");
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";

        function updateModel(event){
            if(event.target && event.target.files){
              var file = event.target.files[0];
              var reader = new FileReader();
              reader.onload = function(e){
                  var image = e.target.result;
                  console.log("IMAGE DATA: %s", image);
                  ngctrl.$setViewValue({filename: file.name,
                                        image_data: image,
                                        content_type: file.type});
                  ngctrl.$render();

              };
                reader.readAsDataURL(file);
            }
        }

        element.on('change',updateModel);

        console.groupEnd();
    }
    return {
        templateUrl: template("fields/image/image"),
        //getting deprecated
        //replace: true,
        restrict: "E",
        require: 'ngModel', // get a hold of NgModelController
        //transclude: true,
        link: link
    };

}]);

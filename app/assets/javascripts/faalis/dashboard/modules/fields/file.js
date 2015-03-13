var File_ = angular.module("FileField",[]);

/*
 * <file-field></file-field>
*/

File_.directive('fileField',["gettext", "$parse", function(gettext, $parse){
    function link(scope, element, attrs, ngctrl){
        console.group("FileField");
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";

        function updateModel(event){
            if(event.target && event.target.files){
              var file = event.target.files[0];
              var reader = new FileReader();
              reader.onload = function(e){
                  var data_ = e.target.result;
                  console.log("FILE DATA: %s", data_);
                  ngctrl.$setViewValue({filename: file.name,
                                        data: data_,
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
        templateUrl: template_url("fields/file/file_upload"),
        //getting deprecated
        //replace: true,
        restrict: "E",
        require: 'ngModel', // get a hold of NgModelController
        //transclude: true,
        link: link
    };

}]);

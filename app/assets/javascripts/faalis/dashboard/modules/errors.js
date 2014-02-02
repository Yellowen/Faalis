
<<<<<<< HEAD
=======
 ----------------------------------------------------------------------------- */
>>>>>>> 660a14d5a0f6d73a18cf15200f1fe0e55cd33521
var Errors = angular.module("Errors", []);

Errors.factory('catch_error', ["gettext", function(gettext) {
    return function(error) {

        if ("data" in error) {
            if ((typeof(error.data) == "object") && ("fields" in error.data)) {
                _.each(error.data.fields, function(value, key) {
                    $("#id_" + key).addClass("input-error");
                    _.each(value, function(x){
                        $("#id_" + key + "_msg").append(value);
                        $("#id_" + key + "_msg").addClass("error");

                    });
                });
                error_message(gettext("Validation error. Fixup errors first."));
                return;
            }
            if ((typeof(error.data) == "object") && ("error" in error.data)) {
                console.log(error.data.error);
                error_message(error.data.error);
                return;
            }
        }
        console.log(error);
        error_message(gettext("Unkown error: please try again or contact to administrator."));

    };
}]);

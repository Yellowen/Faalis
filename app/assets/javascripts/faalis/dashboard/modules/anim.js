
<<<<<<< HEAD
=======

>>>>>>> 660a14d5a0f6d73a18cf15200f1fe0e55cd33521

var Anim = angular.module("Anim", ["ngAnimate"]);

Anim.animation(".fade_anim", function(){
    return {
        leave: function(elem, done){
            $(elem).fadeOut(500, done);
        },
        enter: function(elem, done){
            $(elem).fadeIn(500, done);
            return function(cancelled){};
        }
    };
});

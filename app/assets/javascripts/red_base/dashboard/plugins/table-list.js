$(function(){
    /*$(".table-list ul li").on("dblclick", function(event) {
        var details = $(this).find(".details");
        $(".table-list ul li .details").not($(details)).slideUp();
        $(".table-list ul li i").not($(this).find(".handle")).removeClass("fa-rotate-90");
        if ($(details).is(":visible")) {
            $(this).find(".handle").removeClass("fa-rotate-90");
        }
        else {
            if ($(details).length !== 0) {
                $(this).find(".handle").addClass("fa-rotate-90");
            }
        }
        $(details).slideToggle();

    });*/
    $(".table-list ul li").on("click", function(event){
        $(this).toggleClass("selected");
    });
});

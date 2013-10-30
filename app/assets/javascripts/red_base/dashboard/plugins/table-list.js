$(function(){
    $(".table-list ul li").on("click", function(event) {
        var details = $(this).find(".details");
        $(".table-list ul li .details").not($(details)).slideUp();
        if ($(details).is(":visible")) {
            $(this).find("i").removeClass("fa-rotate-90");
        }
        else {
            if ($(this).has(".details")) {
                $(this).find("i").addClass("fa-rotate-90");
            }
        }
        $(details).slideToggle();

    });
});

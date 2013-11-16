angular.module("Dashboard").run(['gettextCatalog', function (gettextCatalog) {
    gettextCatalog.setStrings('fa', {"Menu":"منو","Languages":"زبان ها","Dashboard":"بخش کاربری","Change Password":"تغییر کامه عبور","Sign Out":"خروج"});
    gettextCatalog.currentLanguage = $("html").attr("lang");
    gettextCatalog.debug = true;
}]);

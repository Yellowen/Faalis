window._ = function (str, options) {
    var lang = $(html).attr("lang");
    return I18n[lang][str];
};

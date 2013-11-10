window._ = function (str, options) {
    var lang = $("html").attr("lang");
    if (lang in I18n) {
        if (str in I18n[lang]) {
            if(I18n[lang][str] !== "") {
                return I18n[lang][str];
            }
            return str;
        }
    }
    console.log("I18n: Can't find translation for '" + str + "' in '" + lang + "'");
    return str;
};

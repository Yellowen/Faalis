// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require handlebars
//= require ember
//= require ember-data
//= require_self
//= require red_base/dashboard/app


window.API_PREFIX = "/api/v1/";
window.Modules = [];
window.ErrorQueue = [];
window.lang = $("html").attr("lang");
window.I18n = {};

$.getJSON("/assets/red_base/locale/" + $("html").attr("lang") + ".json")
    .done(function(data){
        I18n[lang] = data;
    })
    .fail(function(data){
        error_message("Can't load locale file please try to refresh the page");
    });

window.Dashboard = Ember.Application.create({
    //LOG_TRANSITIONS: true,
    //LOG_VIEW_LOOKUPS: true,
    //LOG_TRANSITIONS_INTERNAL: true,
});

//= require_tree .
$(function(){
    $(document).foundation();
});

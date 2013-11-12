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
//= require red_base/dashboard/lib/ember
//= require red_base/dashboard/lib/ember-data
//= require_self
//= require red_base/dashboard/app

// Prefix url of API
window.API_PREFIX = "/api/v1/";

// Modules is an array of dashboard modules
window.Modules = [];

// Any element of this queue will be appear as error after load event
window.ErrorQueue = [];

// Current page direction
window.lang = $("html").attr("lang");

// I18n -----------------------------------------
// This Object will contains translated strings
window.I18n = {};

$.getJSON("/assets/red_base/locale/" + $("html").attr("lang") + ".json")
    .done(function(data){
        I18n[lang] = data;
    })
    .fail(function(data){
        error_message("Can't load locale file please try to refresh the page");
    });
// ----------------------------------------------

window.Dashboard = Ember.Application.create({
    //LOG_TRANSITIONS: true,
    //LOG_VIEW_LOOKUPS: true,
    //LOG_TRANSITIONS_INTERNAL: true,
});

Dashboard.ApplicationAdapter = DS.FixtureAdapter.extend({});
/*Dashboard.ApplicationAdapter = DS.RESTAdapter.extend({
    namespace: 'api/v1'
});*/
//= require_tree .
$(function(){
    $(document).foundation();
});

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
//= require_tree ./plugins/

// for more details see: http://emberjs.com/guides/application/
window.Dashboard = Ember.Application.create({
    Resolver: Ember.DefaultResolver.extend({
        resolveTemplate: function(parsedName) {
            parsedName.fullNameWithoutType = "red_base/dashboard/" + parsedName.fullNameWithoutType;
            return this._super(parsedName);
        }
    })
});

//= require_tree .
$(function(){
    $(document).foundation();
});

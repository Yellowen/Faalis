Dashboard.LinkView = Ember.View.extend({
    tagName: 'li',
    classNameBindings: ['active'],
    attributeBindings: ['resource:data-resource'],

    active: Ember.computed(function() {
        var router = this.get('router'),
            route = this.get('route'),
            resource = this.get('resource'),
            model = this.get('content');

        params = [route];

        if(model){
            params.push(model);
        }

        return router.isActive.apply(router, params);
    }).property('router.url'),

    router: Ember.computed(function() {
        return this.get('controller').container.lookup('router:main');
    }),

    click: function(){
        var router = this.get('router'),
            route = this.get('route'),
            model = this.get('content');

        params = [route];

        if(model){
            params.push(model);
        }

        router.transitionTo.apply(router, params);
    }
});

var get = Ember.get;

/**
 @extends Ember.Mixin

 Implements common pagination management properties for controllers.
 */
Ember.PaginationSupport = Ember.Mixin.create({
    /**
     */
    total: 0,

    /**
     */
    rangeStart: 0,

    /**
     */
    rangeWindowSize: 10,

    /**
     */
    rangeStop: Ember.computed('total', 'rangeStart', 'rangeWindowSize', function() {
        var rangeStop = get(this, 'rangeStart') + get(this, 'rangeWindowSize'),
            total = get(this, 'total');
        if (rangeStop < total) {
            return rangeStop;
        }
        return total;
    }).cacheable(),

    /**
     */
    page: Ember.computed('rangeStart', 'rangeWindowSize', function() {
        return (get(this, 'rangeStart') / get(this, 'rangeWindowSize')) + 1;
    }).cacheable(),

    /**
     */
    totalPages: Ember.computed('total', 'rangeWindowSize', function() {
        return Math.ceil(get(this, 'total') / get(this, 'rangeWindowSize'));
    }).cacheable(),

    /**
     */
    hasPrevious: Ember.computed('rangeStart', function() {
        return get(this, 'rangeStart') > 0;
    }).cacheable(),

    /**
     */
    hasNext: Ember.computed('rangeStop', 'total', function() {
        return get(this, 'rangeStop') < get(this, 'total');
    }).cacheable(),

    /**
     */
    didRequestRange: Ember.K,

    /**
     */
    nextPage: function() {
        if (get(this, 'hasNext')) {
            this.incrementProperty('rangeStart', get(this, 'rangeWindowSize'));
        }
    },

    /**
     */
    previousPage: function() {
        if (get(this, 'hasPrevious')) {
            this.decrementProperty('rangeStart', get(this, 'rangeWindowSize'));
        }
    },

    rangeDidChange: Ember.observer(function() {
        this.didRequestRange(get(this, 'rangeStart'), get(this, 'rangeStop'));
    }, 'rangeStart', 'rangeStop')
});

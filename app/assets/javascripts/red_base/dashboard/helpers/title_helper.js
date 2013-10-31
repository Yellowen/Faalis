Ember.Handlebars.helper('__title__', function(record, field, options){

    if (field === undefined){
        // If user did not provide a field to get
        if ("toString" in record) {
            // If record was a model instance
            return record.toString();
        }
        else {
            // If record was a plain object
            return record[keys(record)[0]];
        }
    }
    else {
        if ("get" in record) {
            return record.get(field);
        }
        else {
            return record[field];
        }
    }
});

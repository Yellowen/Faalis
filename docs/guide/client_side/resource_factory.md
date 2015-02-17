# Resource Factory

Resource factory is the most important part in client side application, if you want to use **Faalis**
controllers in you own code. Practically using **Faalis** generators will do.

## Resource initialization

Creating a new resource is very easy:

```javascript
  new ResourceFactory('<resource-name>');
  new ResourceFactory('user');
```

`ResourceFactory` class contructor gets three arguments:

* **name**: Name of the resource you want to represent.
* **parents**: An array of current resource parents. In case of a nested resource.
* **options**: An object which will pre-populate the Resource object.

The only confusing part is the `options` parameter. Any key/value pair you provide via
options will automatically attach to the Resource object by transforming the key name to

`_<key>` ( notice the prefixed underscore ). Most of **Resource** methods will check
the value of a prefixed key of their name. for example `Resource.details_template` will
check for `Resource._details_template` if it has a value then it will use that instead of
default value. So you can easily define these value via contructor of**ResourceFactory**
like this:

```javascript
new ResourceFactory('user', [], { default_template: '/url/to/template' });
```

that's it.

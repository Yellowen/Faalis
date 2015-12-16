**DO NOT READ THIS FILE ON GITHUB, GUIDES ARE PUBLISHED ON http://guides.faalis.io.**

Authentication
==============

This guide will get you through **Faalis** authentication.

After reading this guide, you will know:

* How to **Faalis** authentication works
* Use **Faalis** authentication

--------------------------------------------------------------------------------

Devise
------
[Devise](https://github.com/plataformatec/devise) is one the well known gems for authentication
which offers flexible authentication solutions. We use **Devise** in **Faalis**, so basically
you can do what ever you used to do with **Devise** in **Faalis** too. Checkout
[Devise README](https://github.com/plataformatec/devise/blob/master/README.md)
and [Devise Wiki](https://github.com/plataformatec/devise/wiki) for more information.


User Model
----------
The default user model for **Devise** inside the **Faalis** ecosystem is
[Faalis::User](http://api.faalis.io/Faalis/User.html) model.

So if you want to make a relation to user you should use `Faalis::User`. For instance:

```
class Post < ActiveRecord::Base
  belongs_to :user, class_name: 'Faalis::User'
end
```

We don't provides any solution to
replace this model, but you can override or extend this model by simply using ruby `class_eval`
method. For example if you want to add extra stuff to this model or override something, just
add an `initializer` script to your `config/initializers` and do as follow:

```ruby
Faalis::User.class_eval do
  # ...
  # Do your business here
end
```
or even you can load different files in this initializer script and patch `Faalis::User` model in
your thirdparty scripts.

**DO NOT READ THIS FILE ON GITHUB, GUIDES ARE PUBLISHED ON http://guides.faalis.io.**

Authentication Configuration
============================

This guide will get you through **Faalis** authentication configuration.

After reading this guide, you will know:

* How to **Faalis** authentication configuration works
* How to customize **Faalis** authenticaion

--------------------------------------------------------------------------------

Override Controller
-------------------
For changing the default controllers of **Faalis** we need to change routes.
In above example we changed the registration controller name:
```ruby
devise_for :users, :class_name => 'Faalis::User', :controllers => {:registrations => "new_controller" }
```

Override views
--------------
The fastest way to change the views of authentication is copying the `devise` directory in faalis views to views directory of your application and edit files that you need.
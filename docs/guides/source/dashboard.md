**DO NOT READ THIS FILE ON GITHUB, GUIDES ARE PUBLISHED ON http://guides.faalis.io.**

Dashboard Overview
==================

This guide will get you started with **Faalis** dashboard.

This guide covers the overview of dashboard system and how it works.

After reading this guide, you will know:

* How to use Faalis dashboard.
* How Faalis dashboard works in general.
* How to hack dashboard.

--------------------------------------------------------------------------------

Dashboard
---------
Generally **Dashboard** subsystem will be installed with a default **Faalis** installation on `/dashboard`
mount point and just contains necessary views and controllers to do **CRUD** actions on `Faalis::Users` and
`Faalis::Group` models. Basically just working with users, groups and their permissions.

Before continue you should be aware of two main rules:

1- Dashboard subsystem is just like a normal Rails application. There is nothing magical about it. So
you can easily do what ever you like with Rails for your dashboard. **Faalis** just provides easier
way to do the whole thing.

2- If you use the **Faalis** approach to extend your dashboard you should know that models play the main role
in **Faalis** dashboard's scenario.

Let's explain the **dashboard** system in the hard way first. If you don't like the hard way approach skip
it.

Dashboard in the hard way
-------------------------

**Faalis** provides a very simple and easy way to extend the dashboard system by content you want. The idea is
to create a controller for each `resource` you want to include in your dashboard interface under the `app/controllers/dashboard`
directory. The controller should inherit from `Faalis::Dashboard::ApplicationController`. Then you need to add
the proper routes in your application `config/routes.rb` for example for `posts` resource you should do this:


```ruby
in_dashboard do
  resources :posts
end
```

pretty simple right ?

The `Faalis::Dashboard::ApplicationController` controller class provides the basic CRUD actions for a resource
that should be available via dashboard interface. So when you use this class as the superclass for your dashboard
controller, you won't need do define any action in you controller.

But if you don't want to use that controller or even if you want to override any section in dashboard all you have
to do is to override the given action. Well that's **Ruby** and I don't have to lecture you how to do it, I'm sure
that you already know.

Another way to enhance any section in dashboard is to use the **Faalis dashboard DSL** in your controller which
allows you to easily enhance your desire section. **We highly recommend you to use this approach**

For mode information checkout the [Dashboard Controller DSL][#Dashboard_Controller_DSL] section on this doc.

Dashboard the easy way
----------------------

Ok, let's say you have a model called `Post` and you want to create a CRUD interface for it in you dashboard. all
you have to do is to invoke `faalis:resource` generator like this:

```bash
$ rails generate faalis:resource post
```

This generator will creates all the means necessary to grant your wish. Now if you navigate to `/dashboard/posts` you'll
see the list of your posts. Piece of cake, right ?

NOTE: If you want to create a menu entry on the sidebar for your created dashboard resource, checkout
[Sidebar Guide](dashboard_sidebar.html).

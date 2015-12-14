**DO NOT READ THIS FILE ON GITHUB, GUIDES ARE PUBLISHED ON http://guides.faalis.io.**

Dashboard Sidebar
==================

This guide will get you started with sidebar menu of **Faalis** dashboard.

This guide covers the overview of dashboard sidebar and how it works.

After reading this guide, you will know:

* How to use Sidebar in dashboard
* How to populate the sidebar
* How authorization works with sidebar

--------------------------------------------------------------------------------

> Warning: Sidebar API is in beta state and may change in the future.

How sidebar works?
------------------
Sidebar is not very complicated. It's just a nested hash which **Faalis** uses it
to render a nested menu in dashboard. You can build this hash easily by yourself
and via any source you want. For example you can fetch the entries from database
of a remote API. But **Faalis** provides a simple DSL for you to build this hash
more easily. It's a bit limited but far from enough.

The best place to build your sidebar hash is in `Dashboard::ApplicationController`.
**Faalis** will generate a very besic skel for you to easily create your hash.

## Sidebar DSL
In `Dashboard::ApplicationController` of your application. You should define
a method called `setup_sidebar`. In fact by overriding this method you will
allow **Faalis** to know about the sidebar.

In `setup_sidebar` method you should build your suitable sidebar menu hash and
assign it to `@sidebar` instance variable.

**Faalis** provides a nice little DSL for you to helps you build your hash easily.
Here is an example of the sidebar DSL:

```ruby
  # Dashboard::ApplicationController
  # ...
  def setup_sidebar

    @sidebar = sidebar('') do |s|
      s.faalis_entries
      s.menu(t('Base Data'), icon: 'fa fa-book') do
        s.item(t('Provinces'),
               url: main_app.dashboard_provinces_path,
               model: 'Province')
        s.item(t('Cities'),
               url: main_app.dashboard_cities_path,
               model: 'City')
        s.item(t('Areas'),
               url: main_app.dashboard_areas_path,
               model: 'Area')
      end
    end
  end
  #...
```

As you can see in the above example you can start defining your sidebar hash using
[sidebar](http://api.faalis.io/Faalis/Dashboard/Sections/Sidebar/ClassMethods.html#sidebar-instance_method)
method (Checkout the API documents for this method for more information). This method yields an
[Sidebar](http://api.faalis.io/Faalis/Dashboard/Models/Sidebar.html) instance which provides following methods.

### faalis_entries
This method will render all the menu entries provided by **Faalis** itself. Currently **Faalis** only
provides the authentication and authorization menu.

> NOTE: If you wish your users to not see this menu don't worry you can handle it via permissions.

### menu
Using `menu` item you can define a head menu which can contains several `item`s. Checkout the API
docs for [menu](http://api.faalis.io/Faalis/Dashboard/Models/Sidebar.html#menu-instance_method)

### item
This method will define a single clickable entry inside a `menu`. The most important thing about this
method is the `model` argument which is optional and indicates that user have to has `read` access to
what model to see this entry. If user does not have read access on the given model name, he/she won't
see this `item` and `menu`s with no visible item won't be visible to user too. For more information
on [item](http://api.faalis.io/Faalis/Dashboard/Models/Sidebar.html#item-instance_method) take a look at its API docs.

# Dashboard
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

## Dashboard in the hard way

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

## Dashboard the easy way
Ok, let's say you have a model called `Post` and you want to create a CRUD interface for it in you dashboard. all
you have to do is to invoke `faalis:resource` generator like this:

```bash
$ rails generate faalis:resource post
```

This generator will creates all the means necessary to grant your wish. Now if you navigate to `/dashboard/posts` you'll
see the list of your posts. Piece of cake, right ?

> Note: If you want to create a menu entry on the sidebar for your created dashboard resource, checkout
> [Sidebar Guide](file.sidebar.html).


## Dashboard Controller DSL
Do you remember the rule one ? The dashboard subsystem is just a Rails application nothing special. But you can use
the `Faalis::Dashboard::ApplicationController` as you're parent controller ( if you use the easy solution you're already
doing that ) and benefit from the **DSL** of **Faalis** dashboard controller. This way you can tweak your dashboard interface in
the way you want.

Generally there is three main sections for each resource in dashboard, `index`, `new` and `edit` sections. And a forth section that
is just a shortcut for both `new` and `edit` sections that is `form` section. Each section have different DSL but there are several
shared methods between them. First of all you need to specify the section you want to tweak. This is easy, you can do like this:

```ruby
in_<section> do
  # Tweak DSL goes here . . .
end
```

As you already guessed you should fill `<section>` which the corresponding section. for example in case of `index` section you should
do like this `in_index` and provide a block for this method. Then you can tweak the index section as you want using the dashboard tweaking
DSL.

Let's start with the shared DSLs

### in_<section>

### attributes
You can specify the model fields that you wanted to show in the corresponding section like `index` or `form`.
### actions

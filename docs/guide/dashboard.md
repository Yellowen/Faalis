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

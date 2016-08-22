**DO NOT READ THIS FILE ON GITHUB, GUIDES ARE PUBLISHED ON http://guides.faalis.io.**

Dashboard DSL
=============

This guide will teach you the DSL to enhance your dashboard.

This guide covers all the methods and solutions to enhance any section of **Faalis** dashboard.

After reading this guide, you will know:

* How to enhance any section within your dashboard.
* Different solutions for dashboard enhancement.
* All the possible dashboard DSL methods.

--------------------------------------------------------------------------------

Dashboard Controller DSL
------------------------

Do you remember the rule one ? The dashboard subsystem is just a Rails application nothing special. But you can use
the `Faalis::Dashboard::ApplicationController` as you're parent controller ( if you use the easy solution you're already
doing that ) and benefit from the **DSL** of **Faalis** dashboard controller. This way you can tweak your dashboard interface in
the way you want.

Generally there is three main sections for each resource in dashboard, `index`, `new` and `edit` sections. And a forth section that
is just a shortcut for both `new` and `edit` sections that is `form` section. Each section have different DSL but there are several
shared methods between them. First of all you need to specify the section you want to tweak. This is easy, you can do like this:

```ruby
in_<section> do |section|
  # Tweak DSL goes here . . .
end
```

As you already guessed you should fill `<section>` which the corresponding section. for example in case of `index` section you should
do like this `in_index` and provide a block for this method. Then you can tweak the index section as you want using the dashboard tweaking
DSL.

Let's start with the shared DSLs

### in_\<section\>
In order to customize a section of a resource you need to specify the section first like this:

```ruby
in_index do |index|
  # index section customization goes here . . .
end
```

Also you can do this for other sections too. In fact you have to.

#### in_index
TODO

#### in_form
TODO

#### in_show
Any customization you want to apply to `show` section will goes here. For example:

```ruby
in_show do |show|
  show.attributes :id, :name, :custom_method1
end
```
But if you don't do any customization, `show` section will create a list of all the
columns your resource have including the relations and possible attachment urls.

If you looked at the show list before, you may saw that **Faalis** returns the ruby
representation of each relationship in your resource. For example for a relationship
with `Faalis::User` you should see something like:

```
#<Faalis::User:0x007f22977b7a30>
```

It's totally fine because **Faalis** does not know about your relationship context and
what field should be used on the relation object. It simply apply `to_s` on the relation
object.

So you can change this behavior by overriding your model `to_s` method. This way instead
of ruby representation of the relation object you'll see much more suitable string.

There are lots of way to fix this problem. For instance, as we mentioned earlier attribute
delegation and custom methods are always fine solutions.

### attributes
You can specify the model fields that you wanted to show in the corresponding section like `index` or `form`.

for example assume we have a `Post` model like this:

```ruby
# title       String
# content     Text
# user_id     Integer
# created_at  Datetime
# updated_at  Datetime
class Post
  belongs_to :user, class_name: 'Faalis::User'

  delegate :name, to: :user, prefix: true

  def rendered_content
    # render content using markdown
  end
end
```

By default all the fields in model will appear in the `index` section of your resource UI in dashboard. To reduce
the number of `attributes` in the `index` section all you have to do is to do this:

```ruby
  # some where in your Dashboard::PostsController
  in_index do |index|
    index.attribtues :title, :user_name, :created_at

    # OR

    index.attributes except: [:updated_at, :content]
  end
```

Pretty simple right?

### attributes_properties

Some time you want to change the behavior in an specific section. For example you want to render an textarea
for a field instead of simple input in `form` section. You can achieve that with `attributes_properties`.

For example:

```ruby
in_form do 'form'
  form.attributes_properties name: { #name_properties }
end
```

`name_properties` would be any [formtastic](https://github.com/justinfrench/formtastic) configuration you needed.
It will directly apply to the given property.

### scope
Using this method you can override the default scope of a section (generally `index` section). By default **Faalis**
will use this scope on your Model:

```ruby

Model.policy_scope(Model.order('created_at DESC').page(params[:page]))
```

This scope will order the result based on `created_at` and fetch a page only. Then it will pass the resulted scope
to scope class inside of the related `Pundit` policy. This way you can easily change the scope base on user permissions.
For more information checkout `Pundit` [documents](https://github.com/elabs/pundit#scopes).

### action_button

Using this method you can define different buttons on action area of each section. For example you can simply add another
button in `index` section next to `add new` button. Each section has it's own action area. Defining new action buttons is
super easy:

```ruby

  # inside Dashboard::PostController
  in_index do |index|
    index.action_button(name: t('Disable'), href: someaction_path,
                        class: 'btn-info', icon_button: 'remove')
  end

  # . . .
```

### tool_button
TODO

```
  in_index do |index|
    index.tool_button(name: t('Approve'),
      icon_button: 'approve', class: 'class') do |obj|
      "/dashboard/entries/approve/#{obj.id}"
    end
  end
```

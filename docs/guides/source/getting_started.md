**DO NOT READ THIS FILE ON GITHUB, GUIDES ARE PUBLISHED ON http://guides.faalis.io.**

Getting Started with Faalis
===========================

In this guide we will review the whole **Faalis** platform at once.


This guide covers getting up and running with Faalis.

After reading this guide, you will know:

* How to install Faalis on your Rails application.
* The general layout of Faalis.
* The basic principles of a Faalis application.
* How to quickly generate the starting pieces of a Faalis application.

--------------------------------------------------------------------------------


Guide Assumptions
-----------------

This guide is designed for beginners who want to get started with a Faalis
application from scratch. It does not assume that you have any prior experience
with Faalis. Also you need to know about general concepts of Rails framework. However,
to get the most out of it, you need to have some prerequisites installed:

* The [Ruby](https://www.ruby-lang.org/en/downloads) language version 2.2.2 or newer.
* Right version of [Development Kit](http://rubyinstaller.org/downloads/), if you
  are using Windows.
* The [RubyGems](https://rubygems.org) packaging system, which is installed with
  Ruby by default. To learn more about RubyGems, please read the
  [RubyGems Guides](http://guides.rubygems.org).
* A working installation of the [SQLite3 Database](https://www.sqlite.org).

What is Faalis generally?
-------------------------

**Faalis** is development platform which provides lots of functionality for developers to create
their apps much easier. For example **Faalis** provides a very flexible and easy to use dashboard
system. Dashboard system is an administration panel and a user dashboard to easily manage different
resource on the application. Most of web applications need such facility.

There are other features like dashboard in **Faalis**. That's why make it a good platform to speed
up your development process and make better applications.

Lots of great tools been used in **Faalis**, tools that you might used on daily basis. Tools like
`Pundit`, `Devise` and other greate tools.

**Faalis** is a **RubyOnRails** Platform for rapid web application development. It provides a very
robust dashboard subsystem with some fantastic generators to improve productivity as much as possible.

Installation
-------------

Simply add these to the end of your `Gemfile`:

```ruby
source 'http://rails-assets.org' do
  gem 'rails-assets-sugar'
  gem 'rails-assets-bootstrap-rtl'
  gem 'rails-assets-jquery-knob'
  gem 'rails-assets-bootstrap-daterangepicker'
  gem 'rails-assets-jquery-sparkline'
  gem 'rails-assets-jquery-icheck'
  gem 'rails-assets-admin-lte'
end

gem "faalis"
```

If you want to install **faalis** from github just replace previous `gem "faalis"` with this:

```ruby
gem "faalis", github: 'Yellowen/Faalis'
```

Then install your project dependencies using `bundle`

```bash
bundle install
```

use `faalis:install` generator to install **faalis** into your project.

```bash
rails g faalis:install
```

Add this to your `config/environments/development.rb`

```ruby
config.action_mailer.default_url_options = { :host => 'localhost:3000' }
```
NOTE: In production, `:host` should be set to the actual host of your application.

Perform `rake db:migrate db:seed` and enjoy Faalis

NOTE: You can specify the ORM you'd like to use in `config/initializers/faalis.rb`

Perform `rake db:migrate db:seed`. If you're using different database engine rather than
`sqlite`, then you have to create the db first.

Done. Now you're ready to start developing your application using **Faalis**. Have fun.

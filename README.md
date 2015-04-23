# Faalis
[![Gem Version](https://badge.fury.io/rb/faalis.png)](http://badge.fury.io/rb/faalis)
[![Build Status](https://travis-ci.org/Yellowen/Faalis.svg?branch=master)](https://travis-ci.org/Yellowen/Faalis)
[![Downloads](https://img.shields.io/gem/dt/faalis.svg)](http://rubygems/gems/faalis)

**Faalis** is a **RubyOnRails** Platform for rapid web application development. It provides a very
robust dashboard subsystem with some fantastic generators and client side framework based on **AngularJS**
to improve productivity as much as possible.


## Installation

* First add `rails-assets` source to your `Gemfile`:

```ruby
source 'http://rails-assets.org'
```
> **NOTE**: Remember to add this source not to replace the default one.

* Add `faalis` gem and it's dependencies to your `Gemfile` like:

```ruby
group :development, :test do
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem "capybara"
  gem "factory_girl_rails", "~> 4.0", :require => false
  gem "database_cleaner"
  gem "email_spec"
  gem "cucumber-rails", :require => false
end

# Current Dashstrap theme for Faalis
gem "dashstrap"

gem "faalis"
```

* Install your project dependencies using `bundle`

```ruby
bundle install
```

* Add this to your `config/environments/development.rb`

```ruby
config.action_mailer.default_url_options = { :host => 'localhost:3000' }
```
> In production, `:host` should be set to the actual host of your application.

* Ensure you have flash messages in `app/views/layouts/application.html.erb`.
For example (only if you want to change default layout):

```rhtml
<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>
```

* Perform `rails generate faalis:install_all` to copy necessary files.
* Add this to your `config/application.rb` :

```ruby
config.railties_order = [:main_app, Dashstrap::TemplateEngine, Faalis::Engine, :all]
```

* Perform `rake db:migrate` and enjoy Faalis

> **NOTE**: You can specify the ORM you'd like to use in `config/initializers/faalis.rb`

## Documents
There are a couple of guides along with **Ruby** and **JavaScript** API documents
inside the source tree. We use `yardoc` so you can build them easily or look at automated [rubydoc](http://rubydoc.info/gems/faalis)
docs.

Also take a look at [Wiki of Faalis](https://github.com/Yellowen/Faalis/wiki).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Also you can join us in our `IRC` channel: **#Faalis** on freenode. ( It will redirect you to #5hit :P )

## Credit
![Yellowen](http://www.yellowen.com/images/logo.png)

**Faalis**  is maintained and funded by Yellowen. Whenever a code snippet is borrowed or inspired by existing code, we try to credit the original developer/designer in our source code. Let us know if you think we have missed to do this.


# License

**Faalis** is Copyright © 2013-2015 Yellowen. It is free software, and may be redistributed under the terms specified in the LICENSE file.

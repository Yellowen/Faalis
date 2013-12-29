# RedBase  [![Gem Version](https://badge.fury.io/rb/red_base.png)](http://badge.fury.io/rb/red_base)

RedBase is a ruby on rails engine which provides a basic features of a web application. It provide a very
robust dashboard subsystem with some fantastic generators which provide rapid productivity.

## Dependencies

* Add this to your Gemfile:

```ruby
group :development, :test do
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem "capybara"
  gem "factory_girl_rails", "~> 4.0", :require => false
  gem "database_cleaner"
  gem "email_spec"
  gem "cucumber-rails", :require => false
end
```

## Installation

1. Add this to your `config/environments/development.rb`

```ruby
config.action_mailer.default_url_options = { :host => 'localhost:3000' }
```

In production, :host should be set to the actual host of your application.

2. Ensure you have flash messages in app/views/layouts/application.html.erb.
For example (Only if you want to change default layout):

```rhtml
<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>
```


3. Perfrom `rails generate red_base:install_all` to copy necessary files.
4. Perform `rake db:migrate` and enjoy RedBase

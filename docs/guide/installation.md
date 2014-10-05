In this article we will show you how to start you development using  [Faalis](https://github.com/Yellowen/Faalis) platform.

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

* Iinstall your project dependencies using `bundle`

```ruby
bundle install
```

* Add this to your `config/environments/development.rb`

```ruby
config.action_mailer.default_url_options = { :host => 'localhost:3000' }
```
> In production, `:host` should be set to the actual host of your application.

* Ensure you have flash messages in `app/views/layouts/application.html.erb`.
For example (Only if you want to change default layout):

```rhtml
<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>
```

* Perfrom `rails generate faalis:install_all` to copy necessary files.
* Add this to your `config/routes.rb` :

```ruby
mount Faalis::Engine => "/"
Faalis::Routes.define_api_routes
```
* Perform `rake db:migrate` and enjoy Faalis

> **NOTE**: You change the orm you like to use in `config/initializers/faalis.rb`

In this article we will show you how to start you development using  [Faalis](https://github.com/Yellowen/Faalis) platform.

## Installation

1. First add `rails-assets` source to your `Gemfile`:

```ruby
source 'http://rails-assets.org'
```

**NOTE**: Remember to add this source not to replace the default one.

2. Add `faalis` gem and it's dependencies to your `Gemfile` like:

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

3. Iinstall your project dependencies using `bundle`

```ruby
bundle install
```

4. Add this to your `config/environments/development.rb`

```ruby
config.action_mailer.default_url_options = { :host => 'localhost:3000' }
```

In production, `:host` should be set to the actual host of your application.

5. Ensure you have flash messages in `app/views/layouts/application.html.erb`.
For example (Only if you want to change default layout):

```rhtml
<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>
```
6. Perfrom `rails generate faalis:install_all` to copy necessary files.
7. Perform `rake db:migrate` and enjoy Faalis
8. Add this to your `config/routes.rb` :

```ruby
mount Faalis::Engine => "/"
Faalis::Routes.define_api_routes
```

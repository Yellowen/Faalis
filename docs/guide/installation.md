In this article we will show you how to start you development using  [Faalis](https://github.com/Yellowen/Faalis) platform.

## Installation
First add `faalis` to your `Gemfile` like
```ruby
gem "faalis"
```
and install your project dependencies using `bundle`
```ruby
bundle install
```
Add this to your `config/environments/development.rb`
```ruby
config.action_mailer.default_url_options = { :host => 'localhost:3000' }
```
In production, `:host` should be set to the actual host of your application.
Ensure you have flash messages in app/views/layouts/application.html.erb.
For example (Only if you want to change default layout)
```rhtml
<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>
```
Add below line to your `config/routes.rb`:
```ruby
mount Faalis::Engine => "/"
```
Perfrom `rails generate faalis:install_all` to copy necessary files.
Perform `rake db:migrate` and enjoy Faalis

# Faalis  [![Gem Version](https://badge.fury.io/rb/faalis.png)](http://badge.fury.io/rb/faalis)
[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/Yellowen/Faalis?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

Faalis is a ruby on rails engine which provides a basic features of a web application. It provide a very
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

1. First add `faalis` to your `Gemfile` like

```ruby
# Make sure to add this source to you Gemfile
source 'http://rails-assets.org'

gem "faalis"
```
**Note**: Make sure to add `source 'http://rails-assets.org'` to your `Gemfile`.

2. Iinstall your project dependencies using `bundle`

```ruby
bundle install
```

3. Add this to your `config/environments/development.rb`

```ruby
config.action_mailer.default_url_options = { :host => 'localhost:3000' }
```

In production, `:host` should be set to the actual host of your application.

4. Ensure you have flash messages in `app/views/layouts/application.html.erb`.
For example (Only if you want to change default layout):

```rhtml
<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>
```
5. Perfrom `rails generate faalis:install_all` to copy necessary files.
6. Perform `rake db:migrate` and enjoy Faalis

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credit
![Yellowen](http://www.yellowen.com/images/logo.png)

**Faalis**  is maintained and funded by Yellowen. Whenever a code snippet is borrowed or inspired by existing code, we try to credit the original developer/designer in our source code. Let us know if you think we have missed to do this.


# License

**Faalis** is Copyright © 2014 Yellowen. It is free software, and may be redistributed under the terms specified in the LICENSE file.

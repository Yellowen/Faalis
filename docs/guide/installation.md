**Faalis** is a **RubyOnRails** Platform for rapid web application development. It provides a very
robust dashboard subsystem with some fantastic generators to improve productivity as much as possible.

## Installation
Simply add `faalis` to your gem file like this:

```ruby
gem "faalis"
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
> In production, `:host` should be set to the actual host of your application.

Perform `rake db:migrate db:seed` and enjoy Faalis

> **NOTE**: You can specify the ORM you'd like to use in `config/initializers/faalis.rb`

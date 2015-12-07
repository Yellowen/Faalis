# Faalis
[![Gem Version](https://img.shields.io/gem/v/faalis.svg?style=flat)](http://badge.fury.io/rb/faalis)
[![Build Status](https://travis-ci.org/Yellowen/Faalis.svg?branch=master)](https://travis-ci.org/Yellowen/Faalis)
[![Downloads](https://img.shields.io/gem/dt/faalis.svg)](http://rubygems.org/gems/faalis)
[![Test Coverage](https://codeclimate.com/github/Yellowen/Faalis/badges/coverage.svg)](https://codeclimate.com/github/Yellowen/Faalis/coverage)
[![Code Climate](https://codeclimate.com/github/Yellowen/Faalis/badges/gpa.svg)](https://codeclimate.com/github/Yellowen/Faalis)
[![Dependency Status](https://gemnasium.com/Yellowen/Faalis.svg)](https://gemnasium.com/Yellowen/Faalis)
[![Lisence](https://img.shields.io/github/license/Yellowen/Faalis.svg)](http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

**Faalis** is well tuned platform to create web applications as fast as possible. It is built on top of other quality
tools, and provides additional features like a robust dashboard, pre-baked authentication and authorization and other
cool stuff.

## Installation
Simply add `faalis` to your gem file with following command:

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

gem "faalis", github: 'Yellowen/Faalis'
```

Then install your project dependencies using `bundle` command:

```bash
bundle install
```

use `faalis:install` generator to install **faalis** into your project by issuing the following command:

```bash
rails g faalis:install
```

Add this to your `config/environments/development.rb` file

```ruby
config.action_mailer.default_url_options = { :host => 'localhost:3000' }
```
> In production, `:host` should be set to the actual host of your application.

Perform `rake db:migrate db:seed` and enjoy Faalis

> **NOTE**: You can specify the ORM you'd like to use in `config/initializers/faalis.rb`

## Documents

It's easier to starts with [Faalis Guides](http://guides.faalis.io/) but you can checkout the
automated [rubydoc](http://rubydoc.info/gems/faalis) docs.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Also you can join us in our `IRC` channel: **#Faalis** on freenode. ( It will redirect you to #5hit :P )

## Credit
![Yellowen](http://www.yellowen.com/images/logo.png)

**Faalis**  is maintained and funded by Yellowen. Whenever a code snippet is borrowed or inspired by
existing code, we try to credit the original developer/designer in our source code. Let us know if you
think we have forgotten to do this, and we will do our best to locate the problem and fix it in a timely
manner.


# License

**Faalis** is Copyright © 2013-2015 Yellowen. It is free software, and may be redistributed under the terms specified in the LICENSE file.

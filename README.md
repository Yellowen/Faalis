# Faalis
[![Gem Version](https://img.shields.io/gem/v/faalis.svg?style=flat)](http://badge.fury.io/rb/faalis)
[![Build Status](https://travis-ci.org/Yellowen/Faalis.svg?branch=master)](https://travis-ci.org/Yellowen/Faalis)
[![Downloads](https://img.shields.io/gem/dt/faalis.svg)](http://rubygems.org/gems/faalis)
[![Test Coverage](https://codeclimate.com/github/Yellowen/Faalis/badges/coverage.svg)](https://codeclimate.com/github/Yellowen/Faalis/coverage)
[![Code Climate](https://codeclimate.com/github/Yellowen/Faalis/badges/gpa.svg)](https://codeclimate.com/github/Yellowen/Faalis)
[![Dependency Status](https://gemnasium.com/Yellowen/Faalis.svg)](https://gemnasium.com/Yellowen/Faalis)
[![Lisence](https://img.shields.io/github/license/Yellowen/Faalis.svg)](http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

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

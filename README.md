activesupport-uwsgistore
========================

Active Support cache store that uses uwsgi caching framework


Usage
=====

To take advantage of the [uWSGI Caching Framework](http://uwsgi-docs.readthedocs.org/en/latest/Caching.html)
in your rails application, you just need to add this gem to your Gemfile

```ruby
gem 'activesupport-uwsgistore', :git => 'https://github.com/rugginoso/activesupport-uwsgistore.git'

```

and then configure your app editing config/application.rb
```ruby
config.cache_store = :uwsgi_store, { cache_name: 'whatever' }

```

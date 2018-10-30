# system_information gem

A gem to provide health checks for CWDS products. Adds a `/system_information`
endpoint to perform health checks. Designed to be used for monitoring services
such as New Relic and load balancer checks. It returns JSON defined with in
[CWDS development practices](https://github.com/ca-cwds/development-practices/blob/master/health_checks.md).

## Installation

Add the following line to your Gemfile:

```ruby
gem 'system_information'
```

And execute:

```cli
bundle
```

## Checks

* `:redis` - checks if Redis is available with a ping

## Configuration

To change the configuration, create a file `config/initializers/system_information.rb`
and add a config block:

```ruby
SystemInformation.configure do |config|
  # Add all needed checks here following a keyname/url string pattern
  config.checks = [ { redis: "redis://{ENV.fetch('REDIS_HOST', 'localhost')}:{ENV.fetch(REDIS_PORT, 6379)}" } ]
end
```

Then add to middleware within `config/application.rb` :

```ruby
  config.middleware.insert_after Rails::Rack::Logger, SystemInformation::SystemInformationMiddleware
```


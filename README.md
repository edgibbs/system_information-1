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
* `:perry` - checks if Perry is available according to its health check

## Configuration

To change the configuration, create a file `config/initializers/system_information.rb`
and add a config block:

```ruby
SystemInformation.configure do |config|
  # Add all needed checks here following a symbol name/url string pattern
  config.checks =
    [
      { name: :redis, url: "redis://#{ENV.fetch('REDIS_HOST', 'localhost')}:#{ENV.fetch('REDIS_PORT', 6379)}" },
      { name: :perry, url: "#{ENV.fetch('BASE_PERRY_URL', 'http://localhost/perry')}/system-information" }
    ]
end
```

Then add to middleware within `config/application.rb`, this should probably be the first Rack middleware loaded ahead of authentication:

```ruby
  config.middleware.use config.middleware.use SystemInformation::SystemInformationMiddleware
```


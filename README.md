# system_information gem

A gem to provide health checks for CWDS products. Adds a `/system_information`
endpoint to perform health checks. Designed to be used for monitoring services
such as New Relic and load balancer checks. It returns JSON defined with in
[CWDS development practices](https://github.com/ca-cwds/development-practices/blob/master/health_checks.md).

## Installation

Add the following line to your Gemfile:

```ruby
gem 'system_information', github: 'ca-cwds/system_information'
```

And execute:

```cli
bundle
```

## Checks

* `:redis`     - checks if Redis is available with a ping
* `:perry`     - checks if Perry is available according to its health check
* `:cals_api`  - checks if Cals API is avilable according to its health check
* `:cans-api`  - checks if Cans API is avilable according to its health check
* `:ferb_api`  - checks if Ferb API is avilable according to its health check
* `:dora_api`  - checks if Dora API is avilable according to its health check
* `:geo_api`   - checks of Geo API is avilable according to its health check

## Configuration

To change the configuration, create a file `config/initializers/system_information.rb`
and add a config block:

```ruby
SystemInformation.configure do |config|
  config.application = 'CWDS Example System'
  config.version = "#{ENV.fetch('APP_VERSION', 'unknown')}"
  # Add all needed checks here following a symbol name/url string pattern
  config.checks =
    [
      { name: :redis,    url: "redis://#{ENV.fetch('REDIS_HOST', 'localhost')}:#{ENV.fetch('REDIS_PORT', 6379)}" },
      { name: :perry,    url: "#{ENV.fetch('PERRY_BASE_URL', 'http://localhost/perry')}/system-information" },
      { name: :cals_api, url: "#{ENV.fetch('CALS_API_URL', 'http://localhost/cals')}/system-information" },
      { name: :cans_api, url: "#{ENV.fetch('CANS_API_BASE_URL', 'http://localhost/cans')}/system-information" },
      { name: :dora_api, url: "#{ENV.fetch('DORA_API_URL', 'http://localhost/dora')}/system-information" },
      { name: :ferb_api, url: "#{ENV.fetch('FERB_API_URL', 'http://localhost/ferb')}/system-information" },
      { name: :geo_api,  url: "#{ENV.fetch('GEO_SERVICE_URL', 'http://localhost/geo')}/system-information" }
    ]
end
```

The options include:

* config.application - Name of the application
* config.version - Version, optional currently
* config.checks - Add any checks of dependent services following the format in the example

Then add to middleware within `config/application.rb`, this should probably be the first Rack middleware loaded ahead of authentication:

```ruby
  config.middleware.use SystemInformation::SystemInformationMiddleware
```

## Questions

If you have any questions regarding the contents of this repository, please email the Office of Systems Integration at FOSS@osi.ca.gov.

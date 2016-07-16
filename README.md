# Rambo
[![Gem Version](https://badge.fury.io/rb/rambo_ruby.svg)](https://badge.fury.io/rb/rambo_ruby)  [![Build Status](https://travis-ci.org/danascheider/rambo.svg?branch=master)](https://travis-ci.org/danascheider/rambo) [![Code Climate](https://codeclimate.com/github/danascheider/rambo/badges/gpa.svg)](https://codeclimate.com/github/danascheider/rambo) [![Dependency Status](https://gemnasium.com/badges/github.com/danascheider/rambo.svg)](https://gemnasium.com/github.com/danascheider/rambo)
 [![Coverage Status](https://coveralls.io/repos/github/danascheider/rambo/badge.svg?branch=dev)](https://coveralls.io/github/danascheider/rambo?branch=master)

Rambo is a gem that generates API contract tests from API docs in [RAML](http://raml.org/). Rambo is being developed to test APIs complying with standard REST practices. Mileage may vary with other architectures, but I'm happy to consider pull requests.

## Usage
You can install Rambo using:
```ruby
gem install rambo_ruby
```
You can also add it to your project's Gemfile:
```ruby
group :development, :test do
  gem 'rambo_ruby', '~> 0.8'
end
```
There are three options for generating tests from Rambo: The command line tool, the rake task, and the Ruby API. In all cases, Rambo will look for a `.rambo.yml` file in the root directory of your project for configuration options. Options may also be passed in through the command line as arguments or the Ruby API as a hash. There is currently no option to pass arguments to the Rake task, but Rambo comes pre-loaded with sensible defaults, and the `.rambo.yml` file is always an option.

Rambo will create `spec/contract` directory and a `spec/rambo_helper.rb` file if they don't exist, and will create a `spec/contract/foobar_spec.rb` file. The latter will overwrite any existing spec file by the same name. This is intentional behavior and will not change in future versions.

The Rack::Test API uses different syntax for Rails and non-Rails Rack apps. By default, Rambo assumes it is dealing with a Rails app, but this is easily modified by passing options or using a .rambo.yml file.

To run the RSpec examples Rambo generates, you will need to have `require`s in your `spec_helper.rb` or `rambo_helper.rb` file:

- `require "rack/test"`
- `require "json"`
- `require "json-schema"`

### The Command Line Tool
To use the command line tool, simply `cd` into the root directory of your project and run
```
$ rambo foobar.raml
```
Replace `foobar.raml` with the path of the actual RAML file from which you want to generate tests.

#### Options
By default, Rambo assumes you are testing a Rails app and generates tests using syntax that will work for Rails apps. If you are testing a non-Rails app, you can use the `--framework` flag to indicate a `sinatra:classic`, `sinatra:modular`, `grape`, or `rory` app. If you are using a different framework, please open an issue to let us know which, or submit a PR adding support for the framework you are using.

If your app uses an API token header, you can also pass in the token to be used as an option using the `-T` or `--token` flag:
```
$ rambo foobar.raml -T sometoken
```
Rambo will automatically use this value for any header whose name matches "token" or "key" (not case-sensitive).

By default, Rambo detects models and creates [FactoryGirl](https://github.com/thoughtbot/factory_girl) fixtures. (You will need to configure the fixtures manually with the appropriate attributes.) If your app is functional and does not use models, you can use the `--no-models` switch to turn this functionality off.

### The Rake Task
After adding `rambo_ruby` to your Gemfile or gemspec, you will need to add the following to your Rakefile:
```ruby
require "rambo"

Rambo::Rake::Task.new
```
This will create a Rake task called `rambo`. Now, you can generate tests by running:
```
rake rambo
```

### The Ruby API
You can generate Rambo tests from a Ruby script using:
```ruby
require "rambo"

Rambo.generate_contract_tests!(File.expand_path("doc/foobar.raml"), {})
```
You can pass any options in as a hash. Currently, the available options are `:framework`, `:token`, and `:models`. Valid values for the `:framework` option are `:grape`, `:"sinatra:classic"`, `:"sinatra:modular"`, `:rory`, and `:rails`, with `:rails` being the default. The `:token` option takes an API token as a string. The default value of `:models` is `true`. Setting this option to `false` prevents Rambo from generating fixtures using FactoryGirl. You should only set `:models` to `false` if your app is functional and does not use models.

## The .rambo.yml File
By default, Rambo will always check for a `.rambo.yml` file in the root directory of your projects and load options from there. If there is no `.rambo.yml` file, default values will be used (see below).

A sample `.rambo.yml` file could look like this:
```yaml
raml: docs/contracts/foobar.raml
framework: sinatra:modular
token: foobarbaz
models: false
```
There are four possible keys, all optional:
  - `raml` - specifies the RAML file to use to generate the tests. The default, relative
    to the root of your project directory, is `doc/raml/foobar.raml`, where `foobar.raml` is the first RAML file found in the `doc/raml` directory.
  - `framework` - specifies the framework you are using. The default value is `rails`; other available 
    frameworks are `sinatra:classic`, `sinatra:modular`, `grape`, and `rory`.
  - `token` - the API key or token to be included in the security headers. This value will be
    used for any header whose name matches either "token" or "key" (not case-sensitive).
  - `models` - when set to `false`, prevents Rambo from generating FactoryGirl fixtures to 
    mock your models. This option is set to `true` by default. You should only use this option 
    if your app is purely functional and does not use models.

If a `.rambo.yml` file is present and additional options are passed in through the command line or Ruby API, the option values that are passed in will override those in the `.rambo.yml` file.

## Default Behavior
In order to provide the best user experience to a majority of users, Rambo comes with some sensible defaults that are easily overridden in an optional `.rambo.yml` file, or by using command line flags or a Ruby option hash (see above).

### RAML File
In the present version, Rambo only generates tests from a single RAML file. If you're using the command line tool, the name of this file is passed in as an argument. If you're not using the command line tool and don't specify by another means (Ruby hash, `.rambo.yml` file) which RAML file to use, Rambo will look in `your_project/doc/raml` and use the first RAML file it finds.

As noted above, Rambo currently supports only [Rails](https://github.com/rails/rails), [Sinatra](https://github.com/sinatra/sinatra), [Grape](https://github.com/ruby-grape/grape), and [Rory](https://github.com/screamingmuse/rory) apps. Since Rails is the most popular Ruby framework, it assumes your app is a Rails app unless specified otherwise. Since Rack::Test syntax differs when testing Rails and non-Rails apps, you will need to tell Rambo if your app is not a Rails app using the `--framework` flag on the command line, the `:framework` option for the Ruby API, or specifying `framework: <framework>` in your `.rambo.yml` file. Note that for Sinatra apps, you must choose either `sinatra:classic` or `sinatra:modular`.

## Using Rambo with Grape or Sinatra
Rambo is able to generate tests for apps written in Rails, Grape, or Sinatra. However, it has one important limitation when working with non-Rails frameworks. Specifically, Rambo does not support multiple subclasses of `Sinatra::Base`, `Sinatra::Application`, or `Grape::API`. In order to identify the class of your app (which is required to configure Rack::Test), the Rambo-generated test configuration will use the first subclass of one of these classes that it finds. There is currently no option to override this behavior. (If you are building a classic Sinatra app instead of the modular type, `Sinatra::Application` will be used.)

## About the Project
I started Rambo in March of 2016 as part of my work at [Renew Financial](http://renewfinancial.com). For this reason, our primary focus has been on adding the features and functionality that are most important for testing RF's back-end services. Since my contract with Renew Financial has ended, I now have more latitude to do with the project what I want, but also less time to do it.

Rambo, therefore, considers RAML 1.0 and Rails 4 the default, and support for other frameworks and for RAML 0.8 is currently lower priority. We would be delighted to merge pull requests adding such support, as long as they don't adversely affect the features we need most.

## Rambo and Test Data
As of version 0.8, Rambo tests generate test data using [Factory Girl](https://github.com/thoughtbot/factory_girl). Although this is done by default, you can turn off this functionality for purely functional apps by adding `models: false` to your Ruby hash or `.rambo.yml` file, or by using the `--no-models` command line flag.

You will need to include `gem "factory_girl"` or `gem "factory_girl_rails"` in your Gemfile and define factories for each of your model resources with the required data. 

For the purpose of generating data, Rambo assumes you are using RESTful routes where the URI partial corresponds to the plural of the model class. For example, a `/movies` endpoint is assumed to correspond to a `Movie` model and a `:movie` factory. There is currently no option to override this behavior.

## Contributing
Rambo is a new project and any contributions are much appreciated. All pull requests should include comprehensive test coverage and, where appropriate, documentation. If you're not sure where to get started, contact me [through Github](https://github.com/danascheider) and I'll be glad to chat.

Additional information for contributors is available in the wiki. Beginning or first-time contributors are welcome and encouraged!

## More Information
  * [RAML homepage](https://raml.org)
  * [Roy Fielding's dissertation](https://www.ics.uci.edu/~fielding/pubs/dissertation/fielding_dissertation.pdf) describing Representational State Transfer (REST) architecture
  * [RESTful Web Services](http://www.crummy.com/writing/RESTful-Web-Services/RESTful_Web_Services.pdf), by Leonard Richardson & Sam Ruby
  * [Toby Clemson](http://martinfowler.com/articles/microservice-testing/) on testing microservices

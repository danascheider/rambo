# Rambo
[![Gem Version](https://badge.fury.io/rb/rambo_ruby.svg)](https://badge.fury.io/rb/rambo_ruby)  [![Build Status](https://travis-ci.org/danascheider/rambo.svg?branch=master)](https://travis-ci.org/danascheider/rambo) [![Code Climate](https://codeclimate.com/github/danascheider/rambo/badges/gpa.svg)](https://codeclimate.com/github/danascheider/rambo) [![Dependency Status](https://gemnasium.com/badges/github.com/danascheider/rambo.svg)](https://gemnasium.com/github.com/danascheider/rambo)
 [![Coverage Status](https://coveralls.io/repos/github/danascheider/rambo/badge.svg?branch=dev)](https://coveralls.io/github/danascheider/rambo?branch=master)

Rambo is a gem that generates API contract tests from API docs in [RAML](http://raml.org/). Rambo is being developed to test APIs complying with standard REST practices. Mileage may vary with other architectures, but I'm happy to consider pull requests.

#### The current version of Rambo is 0.3.1. It is highly unstable and has a limited feature set. Use at your own risk and please file issue reports if they come up!

## Usage
You can install Rambo using:
```ruby
gem install rambo_ruby
```
You can also add it to your project's Gemfile:
```ruby
group :development, :test do
  gem 'rambo_ruby', '~> 0.3.1'
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
By default, Rambo assumes you are testing a Rails app and generates tests using the Rails Rack::Test syntax. If you are testing a non-Rails Rack app, you can use the `--no-rails` switch to use the non-Rails syntax. Rambo does not currently support non-Rack-based frameworks.

If your app uses an API token header, you can also pass in the token to be used as an option using the `-T` or `--token` flag:
```
$ rambo foobar.raml -T sometoken
```
Rambo will automatically use this value for any header whose name matches "token" or "key" (not case-sensitive).

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
You can pass any options in as a hash. Currently, the only supported option is `"rails"`, which can be set to `true` or `false`, with `true` being the default value. Set `"rails"` to `false` if your app is built with a different Rack-based framework. Currently, Non-Rack-based frameworks are not supported, but pull requests are welcome if your use case requires such support.

## The .rambo.yml File
By default, Rambo will always check for a `.rambo.yml` file in the root directory of your projects and load options from there. If there is no `.rambo.yml` file, default values will be used (see below).

A sample `.rambo.yml` file could look like this:
```yaml
raml: docs/contracts/foobar.raml
rails: false
token: foobarbaz
```
The three possible keys are:
  - `raml` - specifies the RAML file to use to generate the tests. The default, relative
    to the root of your project directory, is `doc/raml/foobar.raml`, where `foobar.raml` is the first RAML file found in the `doc/raml` directory.
  - `rails` - specifies whether your app is a Rails app. The default value is `true`.
  - `token` - the API key or token to be included in the security headers. This value will be
    used for any header whose name matches either "token" or "key" (not case-sensitive).

If a `.rambo.yml` file is present and additional options are passed in through the command line or Ruby API, the option values that are passed in will override those in the `.rambo.yml` file.

## Default Behavior
In order to provide the best user experience to a majority of users, Rambo comes with some sensible defaults that are easily overridden in an optional `.rambo.yml` file, or by using command line flags or a Ruby option hash (see above).

### RAML File
In the present version, Rambo only generates tests from a single RAML file. If you're using the command line tool, the name of this file is passed in as an argument. If you're not using the command line tool and don't specify by another means (Ruby hash, `.rambo.yml` file) which RAML file to use, Rambo will look in `your_project/doc/raml` and use the first RAML file it finds.

As noted above, Rambo currently supports only Rack-based apps. Since Rails is the most popular Ruby framework, it assumes your app is a Rails app unless specified otherwise. Since Rack::Test syntax differs when testing Rails and non-Rails apps, you will need to tell Rambo if your app is not a Rails app using the `--no-rails` switch on the command line, the `{ rails: false }` option hash for the Ruby API, or specifying `rails: false` in your `.rambo.yml` file.

## About the Project
I started Rambo in March of 2016 as part of my work at [Renew Financial](http://renewfinancial.com). For this reason, our primary focus has been on adding the features and functionality that are most important for testing RF's back-end services. Since my contract with Renew Financial has ended, I now have more latitude to do with the project what I want, but also less time to do it.

Rambo, therefore, considers RAML 1.0 and Rails 4 the default, and support for other frameworks and for RAML 0.8 is currently lower priority. We would be delighted to merge pull requests adding such support, as long as they don't adversely affect the features we need most.

Although development of Rambo is largely supported by Renew Financial, we have every intention of keeping the tool open source and to continue expanding and updating its functionality.

## Contributing
Rambo is a new project and any contributions are much appreciated. All pull requests should include comprehensive test coverage and, where appropriate, documentation. If you're not sure where to get started, contact me [through Github](https://github.com/danascheider) and I'll be glad to chat.

Additional information for contributors is available in the wiki. Beginning or first-time contributors are welcome and encouraged!

## More Information
  * [RAML homepage](https://raml.org)
  * [Roy Fielding's dissertation](https://www.ics.uci.edu/~fielding/pubs/dissertation/fielding_dissertation.pdf) describing Representational State Transfer (REST) architecture
  * [RESTful Web Services](http://www.crummy.com/writing/RESTful-Web-Services/RESTful_Web_Services.pdf), by Leonard Richardson & Sam Ruby
  * [Toby Clemson](http://martinfowler.com/articles/microservice-testing/) on testing microservices

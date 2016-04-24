# Rambo
[![Build Status](https://travis-ci.org/danascheider/rambo.svg?branch=master)](https://travis-ci.org/danascheider/rambo) [![Code Climate](https://codeclimate.com/github/danascheider/rambo/badges/gpa.svg)](https://codeclimate.com/github/danascheider/rambo) [![Dependency Status](https://gemnasium.com/badges/github.com/danascheider/rambo.svg)](https://gemnasium.com/github.com/danascheider/rambo)
 [![Coverage Status](https://coveralls.io/repos/github/danascheider/rambo/badge.svg?branch=dev)](https://coveralls.io/github/danascheider/rambo?branch=master)

Rambo is a gem that generates API contract tests from API docs in [RAML](http://raml.org/).

## Usage
You can install Rambo using: <pre><code>gem install rambo</code></pre>You can also add it to your project's Gemfile: <pre><code>group :development, :test do
  gem 'rambo', '~> 0.0.1'
end</code></pre>To run Rambo, from the root directory of your project, run: <pre><code>rambo foobar.raml</code></pre>Rambo will create `spec/contract` directory, a `spec/spec_helper.rb` file if they don't exist, and will create a `spec/contract/foobar_spec.rb` file. The latter will overwrite any existing spec file by the same name. This is intentional behavior and will not change in future versions.

Rambo is being developed to test APIs complying with standard REST practices. Mileage may vary with other architectures, but I'm happy to consider pull requests.

## Contributing
Rambo is a new project and any contributions are much appreciated. All pull requests should include comprehensive test coverage and, where appropriate, documentation. If you're not sure where to get started, contact me [through Github](https://github.com/danascheider) and I'll be glad to chat.

Additional information for contributors is available in the wiki. Beginning or first-time contributors are welcome and encouraged!

## More Information
  * [RAML homepage](https://raml.org)
  * [Roy Fielding's dissertation](https://www.ics.uci.edu/~fielding/pubs/dissertation/fielding_dissertation.pdf) describing Representational State Transfer (REST) architecture
  * [RESTful Web Services](http://www.crummy.com/writing/RESTful-Web-Services/RESTful_Web_Services.pdf), by Leonard Richardson & Sam Ruby
  * [Martin Fowler](http://martinfowler.com/articles/microservice-testing/) on testing microservices

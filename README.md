# Rambo
[![Build Status](https://travis-ci.org/danascheider/rambo.svg?branch=master)](https://travis-ci.org/danascheider/rambo) [![Code Climate](https://codeclimate.com/github/danascheider/rambo/badges/gpa.svg)](https://codeclimate.com/github/danascheider/rambo) [![Dependency Status](https://gemnasium.com/danascheider/rambo.svg)](https://gemnasium.com/danascheider/rambo) [![Coverage Status](https://coveralls.io/repos/github/danascheider/rambo/badge.svg?branch=dev)](https://coveralls.io/github/danascheider/rambo?branch=master)

Rambo is a gem that generates API contract tests from API docs in [RAML](http://raml.org/).

## Usage
You can install Rambo using: <pre><code>gem install rambo</code></pre>You can also add it to your project's Gemfile: <pre><code>group :development, :test do
  gem 'rambo', '~> 0.0.1'
end</code></pre>To run Rambo, from the root directory of your project, run: <pre><code>rambo foobar.raml</code></pre>Rambo will create `spec/contract` directory, a `spec/spec_helper.rb` file if they don't exist, and will create a `spec/contract/foobar_spec.rb` file. The latter will overwrite any existing spec file by the same name. This is intentional behavior and will not change in future versions.
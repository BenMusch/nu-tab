# Nu-tab

[![Codeship Status for benmusch/nu-tab](https://codeship.com/projects/b391e820-d527-0134-caef-66656fa4ab2f/status?branch=master)](https://www.codeship.com/projects/202400)
[![Code Climate](https://codeclimate.com/github/BenMusch/nu-tab/badges/gpa.svg)](https://codeclimate.com/github/BenMusch/nu-tab)
[![Test Coverage](https://codeclimate.com/github/BenMusch/nu-tab/badges/coverage.svg)](https://codeclimate.com/github/BenMusch/nu-tab/coverage)

An attempt at APDA tabbing software built for 2017. The goal of this project is
to port the tab logic of [mit-tab](https://github.com/jolynch/mit-tab) into a
web application with more robust testing, documentation & clarity

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

After setting up, you can run the application using [Heroku Local]:

    % heroku local

[Heroku Local]: https://devcenter.heroku.com/articles/heroku-local

## Documentation

The documentation for this projects lives in the doc/ directory. Documentation
is written in the [RDoc](https://github.com/rdoc/rdoc) format and will be
automatically generated from the comments on the code

To generate the documentation:

    $ ./bin/generate_docs

To view the documentation as an HTML document:

    $ open doc/app/index.html

## Guidelines

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)

## Deploying

If you have previously run the `./bin/setup` script,
you can deploy to staging and production with:

    $ ./bin/deploy staging
    $ ./bin/deploy production

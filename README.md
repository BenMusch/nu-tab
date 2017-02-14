# Nu-tab

[ ![Codeship Status for codeship/mothership]
  (https://codeship.com/projects/b391e820-d527-0134-caef-66656fa4ab2f/status?branch=master)
](https://www.codeship.com/projects/202400)
[![Code Climate](https://codeclimate.com/github/BenMusch/nu-tab/badges/gpa.svg)](https://codeclimate.com/github/BenMusch/nu-tab)
[![Test Coverage](https://codeclimate.com/github/BenMusch/nu-tab/badges/coverage.svg)](https://codeclimate.com/github/BenMusch/nu-tab/coverage)

An attempt at APDA tabbing software built for 2017

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

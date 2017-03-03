# Contributing

When contributing to this repository, please first discuss the change you wish to make via issue,
email, or any other method with the owners of this repository before making a change.

## Implementing a feature/bug fix, etc.

If you would like to change the codebase, fork this repo and create your own
branch to add the feature. When you're finished, open a PR on this repository.

### Pivotal Tracker

[This Pivotal Tracker project](https://www.pivotaltracker.com/n/projects/1978223)
is used to track the features. If you want to add a feature yourself or request
a feature, please add a story to this project.

### Pull Request Process

1. Ensure any install or build dependencies are removed before the end of the layer when doing a 
   build.
2. Update the docs for any logic that you changed, and add documentation when
   for any additional functionality. Refer to the README on how to generate the
   docs
3. Do not merge the pull request unless you are an owner of the repo.

### Code Quality

#### Tests

Write lots of tests! Write unit tests for any back-end logic, write
feature/acceptance tests for front-end features and use Jest to test any
JavaScript components

A robust test suite is necessary to be confident that new features can be added
without potentially corrupting a tournament's results. PRs will not be merged if
the test coverage is insufficient.

#### Code Style

This is a relatively complex application. In order to keep the project
maintainable, the CodeClimate integration is required. Small style issues will
be generally ignored, but try to follow the style as closely as possible. PRs
will not be merged if they appear to have larger-level design issues. Keep your
code clean & follow Rails Best Practices

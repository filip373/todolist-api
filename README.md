# todolist-api

[![codebeat badge](https://codebeat.co/badges/0a6320ea-c3a8-4d20-a94d-af96e8d68d4b)](https://codebeat.co/projects/github-com-filip373-todolist-api-dev)
[ ![Codeship Status for filip373/todolist-api](https://app.codeship.com/projects/3d2eb010-e6b3-0135-399f-7e29242a5208/status?branch=dev)](https://app.codeship.com/projects/269369)

API backend of todolist app

## Setup and configuration
Add following lines to your `/etc/hosts` file to configure DNS:

```
# Todolist app
127.0.0.1 todolist.local
```

Install dependencies:

`bundle install`

Initialize and setup the database:

`bundle exec rails db:setup`

## Running
Run rails server:

`bundle exec rails s`

## Development
Run guard to watch the files for changes and trigger automatic tests and checks:

`bundle exec guard`

Run tests:

`bundle exec rspec`

Swagger docs are available at `/api-docs` endpoint

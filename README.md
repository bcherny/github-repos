github-repos
====================

[![Build Status](https://travis-ci.org/eighttrackmind/github-repos.png)](https://travis-ci.org/eighttrackmind/github-repos.png)
Fetch a user's repository count from Github

## Usage

```coffee
get = require 'github-repos'

success = (count) -> ...
error = (err) -> ...
progress = (countSoFar) -> ...

(get 'someUserName').then success, error, progress
```

## Usage (with oauth)

```coffee
(get 'someUserName', 'myClientId', 'myClientSecret').then success, error, progress
```

## Features

- Supports [ID/Secret oauth2](http://developer.github.com/v3/#oauth2-keysecret)) for higher request volumes
- Uses promises
- Supports paginated responses
- Supports `progress` for paginated responses

## Supported environments

- Node
- CommonJS
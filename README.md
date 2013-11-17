github-contributions
====================

[![Build Status](https://travis-ci.org/eighttrackmind/github-contributions.png)](https://travis-ci.org/eighttrackmind/github-contributions.png)
Fetch a user's contribution count from Github

## Usage

```coffee
getContributions = require 'github-contributions'

success = (count) -> ...
error = (err) -> ...
progress = (countSoFar) -> ...

getContributions 'someUserName', success, error, progress
```

## Features

- Uses promises
- Supports paginated responses
- Supports `progress` for paginated responses

## Supported environments

- Node
- CommonJS

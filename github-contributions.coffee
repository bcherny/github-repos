api = require 'github'

github = new api
	version: '3.0.0'

fetch = (page, total) ->

	github.repos.getFromUser
		page: page
		per_page: 100
		user: 'eighttrackmind'
	, (err, res) ->
		process res, total, page

process = (res, total, page) ->

	count = res.length

	if count
		total += count
		fetch ++page, total

	else
		notify total

notify = (total) ->

	console.log total

# do it!
fetch 1, 0
api = require 'github'
promise = require 'when'

# initialize github helper
github = new api
	version: '3.0.0'

contributor = (user) ->

	deferred = promise.defer()

	# fetches repo count
	fetch = (page, total) ->

		github.repos.getFromUser
			page: page
			per_page: 100
			user: user
		, (err, res) ->
			if err
				deferred.reject err
			else
				process res, total, page

	# tallies the total count, and fetches the next page of results if necessary
	process = (res, total, page) ->

		count = res.length

		if count
			total += count
			deferred.notify total
			fetch ++page, total

		else
			deferred.resolve total

	# do it!
	fetch 1, 0

	# return
	deferred.promise

module.exports = contributor
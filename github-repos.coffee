api = require 'github'
promise = require 'when'
request = require 'request'

github = (user, clientId, clientSecret) ->

	deferred = do promise.defer

	# fetches repo count
	fetch = (page = 1, total = 0) ->

		# build the request
		data =
			url: "https://api.github.com/users/#{user}/repos"
			qs:
				page: page
				per_page: 100

		# authenticate using oauth?
		if clientId and clientSecret
			data.qs.client_id = clientId
			data.qs.client_secret = clientSecret

		# send the request
		request data, (err, body, res) ->

			res = JSON.parse res

			if err or 'message' of res
				deferred.reject err or res

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
	do fetch

	# return
	deferred.promise

module.exports = github
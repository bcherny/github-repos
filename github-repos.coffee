promise = require 'when'
request = require 'request'

statuses =
	403: 'API request rate limit exceeded'
	404: 'You are not authorized to view this resource, or this resource does not exist'

github = (user, clientId, clientSecret, clientUser) ->

	deferred = do promise.defer

	# fetches repo count
	fetch = (page = 1, total = 0) ->

		# build the request
		data =
			headers:
				'User-Agent': clientUser or user
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

			status = body.statusCode

			# success
			if body.statusCode is 200

				res = JSON.parse res

				if err or 'message' of res
					deferred.reject err or res

				else
					process res.length, total, page

			# error
			else

				if status of statuses
					deferred.reject
						status: status
						message: statuses[status]
				else
					deferred.reject status

	# tallies the total count, and fetches the next page of results if necessary
	process = (count, total, page) ->

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
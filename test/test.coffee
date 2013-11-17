get = require '../github-contributions'

exports.github =

	success: (test) ->

		test.expect 1

		fn = (count) ->
			test.equals count, 1
			test.done()

		err = ->
			test.ok false
			test.done()

		# username has 1 repo
		get('demo').then fn, err

	error: (test) ->

		test.expect 1

		fn = ->
			test.ok true
			test.done()

		# username doesn't exist and should throw an error
		get('ajkldanjkndjklfndjfnjkdsnfjrnfjkdndjkvnifsdvnfjkvnsrifrifnsermnerjifnerjfnjr').then (->), fn, (->)

	progress: (test) ->

		test.expect 1

		called = 0

		fn = ->
			++called

		done = (total) ->
			expected = Math.ceil total/100
			test.equals called, expected
			test.done()

		err = ->
			test.ok false
			test.done()

		# has >300 repos
		get('isaacs').then done, err, fn
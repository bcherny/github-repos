get = require '../github-contributions'

exports.github =

	success: (done) ->

		called =
			success: 0
			progress: 0

		success = (count) ->

			++called.success

			test.expect called.success, 1
			test.expect called.progress, 1
			done()

		progress = (countSoFar) ->
			++called.progress

		get('demo').then success, (->), progress

	error: (done) ->

		called = 0

		err = (err) ->
			++called
			test.expect called, 1
			done()

		get('ajkldanjkndjklfndjfnjkdsnfjrnfjkdndjkvnifsdvnfjkvnsrifrifnsermnerjifnerjfnjr').then (->), err, (->)
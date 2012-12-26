describe "Deployman service", !(a)->
	service = null

	beforeEach module \deployman

	beforeEach inject [\deployman, !(deployman)->
		service := deployman
	]

	beforeEach !->
		@addMatchers do
			toBeArray: ->
				_(@actual).isArray!

	it "Should start with an empty list of hosts.", !->
		debugger
		expect service.hosts .toBeArray!

	# it "Should fire a loaded event with new hosts.", !->
	# 	loaded = false
	# 	service.loaded :> !(hosts)->
	# 		expect hosts.length .toBeGreaterThan 0
	# 		loaded := true

	# 	waitsFor -> loaded

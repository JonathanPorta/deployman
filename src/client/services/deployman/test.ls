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
		expect service.hosts .toBeArray!

	it "Should create and fire the loaded event", !->
		cb = jasmine.createSpy!
		service.loaded :> cb
		hosts = service.hosts.length
		service.create!
		expect service.hosts.length .toBe hosts + 1
		expect cb .toHaveBeenCalled!

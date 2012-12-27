describe "Hosts", !(a)->
	beforeEach !->
		browser!navigateTo '/#'

	it "Should add a host", !->
		expect repeater('.hostTable tr').count! .toBe (0 + 2)
		# element '.hostTable .create' .click!
		# expect repeater('.hostTable tr').count! .toBe (1 + 2)
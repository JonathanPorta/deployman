describe "Hosts", !(a)->
	$scope = null

	beforeEach module \deployman

	beforeEach inject [\$rootScope, \$controller, !($rootScope, $controller)->
		$scope := $rootScope.$new!
		ctrl = $controller \Host, {$scope}
	]

	it "Should set an array of hosts on the scope.", !->
		expect $scope.hosts .toBeDefined!

	it "Should expose a create function", !->
		expect $scope.create .toBeDefined!
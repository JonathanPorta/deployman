describe "Routers", !(a)->
	$scope = null

	beforeEach module \deployman

	beforeEach inject [\$rootScope, \$controller, !($rootScope, $controller)->
		$scope := $rootScope.$new!
		ctrl = $controller \Router, {$scope}
	]

	it "Should set an array of routers on the scope.", !->
		expect $scope.routers .toBeDefined!

	it "Should expose a create function", !->
		expect $scope.create .toBeDefined!
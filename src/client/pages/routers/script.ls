router = !(scope, deployman)->
	scope <<<
		routers: deployman.routers
		create: !->
			deployman.create \Router
	deployman.loaded :> !->
		scope.routers = deployman.routers
		unless scope.$$phase then scope.$apply!

angular.module \deployman
	.controller \Router, [\$scope, \deployman, \JEFRi, router]

angular.classes do
	routerTable: "table table-striped"
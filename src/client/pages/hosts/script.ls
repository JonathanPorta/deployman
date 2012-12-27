host = !(scope, deployman)->
	scope <<<
		hosts: deployman.hosts
		create: !->
			deployman.create \Host
	deployman.loaded :> !->
		scope.hosts = deployman.hosts
		unless scope.$$phase then scope.$apply!

angular.module \deployman
	.controller \Host, [\$scope, \deployman, \JEFRi, host]

angular.classes do
	title: "hero-unit"
	hostTable: "table table-striped"
	create: "btn btn-primary"
	remove: "btn"
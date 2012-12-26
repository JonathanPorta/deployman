host = !(scope, deployman)->
	scope <<<
		hosts: deployman.hosts

angular.module \deployman
	.controller \Host, [\$scope, \deployman, \JEFRi, host]

angular.classes do
	title: "hero-unit"
	hostTable: "table table-striped"
	create: "btn btn-primary"
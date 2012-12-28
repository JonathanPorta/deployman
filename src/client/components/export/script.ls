controller = !($scope, deployman, jQuery) ->
	success = (msg)->
		$scope.success = msg
		$scope.$sapply!
		setTimeout (!->
			$scope.success = false
			$scope.$sapply!
		), 2000
	$scope <<<
		success: false
		save: !->
			deployman.save!done -> success "Saved!"
		load: !->
			deployman.load!done -> success "Loaded!"
		write: !->
			deployman.write!done -> success "Wrote config!"

controller.$inject = <[ $scope deployman ]>

directive = ($) ->
	restrict: \E
	template: $.template \#export
	replace: true
	controller: controller

angular.module \deployman
	.directive \export, [\jQuery, directive]

angular.classes do
	exportMenu: "navbar"
	menuInner: "navbar-inner" 
	menuTitle: "brand"
	export: "nav"
	success: "alert alert-success"
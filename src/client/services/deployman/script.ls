deployman = (JEFRi)->
	class deployman
		->
			JEFRi.ready.then !~>
				@load!
				@loaded <: {}

		load: ->
			getHosts = 
				JEFRi.get {_type: \Host } .done !(gotten)~>
					@hosts = gotten.entities
					_(@hosts).each !~> @_watch it
			getRouters = 
				JEFRi.get {_type: \Router } .done !(gotten)~>
					@routers = gotten.entities
					_(@routers).each !~> @_watch it
			_.when(getHosts, getRouters).then !~>
				@loaded <: {}

		save: ->
			ents = @routers +++ @hosts
			JEFRi.save ents

		write: ->
			_.request.post "#{@ENDPOINT}write/"

		create: !(which)->
			build =
				Host: !~>
					ent = JEFRi.build \Host, {hostname: "New Host", ip: "0.0.0.0", mac: "00:00:00:00:00:00"}
					ent.router @routers[0]
					@hosts.push @_watch ent
				Router: !~>
					ent = JEFRi.build \Router, {name: "new-router", gateway: "0.0.0.0", mask: "255.255.255.255"}
					@routers.push @_watch end
			build[which]!
			@loaded <: {}

		# Configure event watchers on an entity.
		_watch: (ent)->
			which = switch ent._type()
			| \Host => @hosts
			| \Router => @routers
			ent.destroying :> !~>
				# Remove the entity from the array the service is holding it in.
				if (t = which.indexOf ent) > -1
					which[t to t] = []
					@loaded <: {}
			ent

		hosts: []
		routers: []

		ENDPOINT: 'http://localhost:3000/'

	new deployman!

angular.module \deployman
	.factory \deployman, [\JEFRi, deployman]

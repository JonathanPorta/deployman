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

		create: !(which)->
			switch which
			| \Host => @hosts.push @_watch JEFRi.build \Host, {hostname: "New Host", ip: "0.0.0.0", mac: "00:00:00:00:00:00"}
			| \Router => @routers.push @_watch JEFRi.build \Router, {name: "new-router", gateway: "0.0.0.0", mask: "255.255.255.255"}
			@loaded <: {}

		_watch: (ent)->
			which = switch ent._type()
			| \Host => @hosts
			| \Router => @routers
			ent.destroying :> !~>
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

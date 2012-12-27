deployman = (JEFRi)->
	class deployman
		->
			JEFRi.ready.then !~>
				@load!
				@loaded <: {}

		load: !->
			routers = [
				<[ static-wireless 216.146.97.254 255.255.255.0 ]>
				<[ static-ip 216.146.96.1 255.255.255.0 ]>
			]

			static-wireless = JEFRi.build \Router, {name: routers[0][0], gateway: routers[0][1], mask: routers[0][2]}
			static-ip = JEFRi.build \Router, {name: routers[1][0], gateway: routers[1][1], mask: routers[1][2]} 

			@routers = [static-wireless, static-ip]

			hosts = [
				["mud", "216.146.97.60", "18:03:73:af:00:b2", static-wireless],
				["opal", "216.146.97.50", "fa:54:ef:33:9c:e5", static-wireless],
				["time", "216.146.96.78", "00:1a:4a:92:61:01", static-ip]
			]
			@hosts = for host in hosts
				h = @_watch JEFRi.build \Host, {hostname: host[0], ip: host[1], mac: host[2]}
				h.router host[3]

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

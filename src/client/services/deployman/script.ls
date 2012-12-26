deployman = (JEFRi)->
	class deployman
		->
			JEFRi.ready.then !~>
				@load!
				@loaded <: {}

		load: !->
			hosts = [
				["mud", "216.146.97.60", "18:03:73:af:00:b2"],
				["opal", "216.146.97.50", "fa:54:ef:33:9c:e5"],
				["time", "216.146.96.78", "00:1a:4a:92:61:01"]
			]
			@hosts = for host in hosts
				h = JEFRi.build \Host, {hostname: host[0], ip: host[1], mac: host[2]}

		hosts: []

		ENDPOINT: 'http://localhost:3000/'

	new deployman!

angular.module \deployman
	.factory \deployman, [\JEFRi, deployman]

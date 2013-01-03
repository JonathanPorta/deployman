/*
 * deployman
 * https://github.com/southerd/deployman
 *
 * Copyright (c) 2012 David Souther
 * Licensed under the MIT license.
 */

# `jefri-server` provides an express server configured to handle jefri
# transactions, so we'll use that first. We also need to do some express things.
require! { server: "jefri-server", express, _: superscore, fs, nconf }

nconf.argv!
	.env!
	.file { file: 'config.json' }
	.defaults { port: 3000, write_path: "deployman.conf" }

server.post '/write', !(req, res)->
	config = ""
	routers = server.jefri.runtime.find \Router
	_(routers).each ->
		config += "group { \# #{it.name!}\n"
		config += "\toption routers #{it.gateway!};\n"
		config += "\toption subnet-mask #{it.mask!};\n"
		_(it.hosts!).each ->
			config += "\thost #{it.hostname!} {\n"
			config += "\t\thardware ethernet #{it.mac!};\n"
			config += "\t\tfixed-address #{it.ip!};\n"
			config += "\t}\n"
		config += "}\n"
	fs.writeFile (nconf.get 'write_path'), config, (err)->
		unless err
			res.status 204 # No Content
		else
			res.status 500 # Server error
				.send {err: err.toString!}

# The jefri-server runtime doesn't have a default context, load the app's.
server.jefri.runtime.load "http://localhost:#{nconf.get \port}/deployman.json"

# Use index.html for /
server.get '/', !(req, res)->
	res.sendfile "lib/client/index.html"

server.get '/context.json', !(req, res)->
	res.sendfile 'lib/client/deployman.json'

# Otherwise, serve requests as static files from lib/client/
server.use '/', express.static 'lib/client/'

# Start the server.
server.listen nconf.get 'port'

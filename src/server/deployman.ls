/*
 * deployman
 * https://github.com/southerd/deployman
 *
 * Copyright (c) 2012 David Souther
 * Licensed under the MIT license.
 */

# `jefri-server` provides an express server configured to handle jefri
# transactions, so we'll use that first. We also need to do some express things.
require! { server: "jefri-server", express }

# The jefri-server runtime doesn't have a default context, load the app's.
server.jefri.runtime.load 'http://localhost:3000/deployman.json'

# Use index.html for /
server.get '/', !(req, res)->
	res.sendfile "lib/client/index.html"

server.get '/context.json', !(req, res)->
	res.sendfile 'lib/client/deployman.json'

# Otherwise, serve requests as static files from lib/client/
server.use '/', express.static 'lib/client/'

# Start the server.
server.listen 3000
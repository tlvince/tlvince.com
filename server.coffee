express = require 'express'
http = require 'http'
path = require 'path'
poweredBy = require 'connect-powered-by'
nowww = require 'connect-no-www'

app = express()
port = process.env.PORT or 3000
oneDay = 86400000
build = path.join __dirname, 'build'

mime = express.static.mime
mime.default_type = mime.lookup 'html'

# Middleware
app.set 'port', port
app.use express.compress()
app.use express.logger 'short'
app.use poweredBy()
app.use nowww()
app.use express.favicon "#{build}/favicon.ico"

# Redirect early otherwise static will serve 'index'
app.get '/index', (req, res) ->
  res.redirect 301, '/'

app.use express.static build, maxAge: oneDay

# Routes
app.get '/$', (req, res) ->
  res.sendfile "#{build}/index", maxAge: oneDay

app.get '/:year/:month/:day/:entry/', (req, res) ->
  res.redirect 301, req.params.entry

app.get '/archive', (req, res) ->
  res.redirect 301, '/'

app.get '/:entry/$', (req, res) ->
  res.redirect 301, req.params.entry

# Error handling
app.use (req, res, next) ->
  res.status 404
  res.sendfile "#{build}/404", maxAge: oneDay * 365

app.use (err, req, res, next) ->
  console.error err.stack
  res.status 500
  res.sendfile "#{build}/500", maxAge: oneDay * 365

http.createServer(app).listen app.get('port'), ->
  console.log "Express server listening on port #{app.get('port')}"

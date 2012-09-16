express      = require('express')
assetManager = require('connect-assetmanager')
poweredBy    = require('connect-powered-by')
nowww        = require('connect-no-www')
app          = express()
port         = process.env.PORT or 3000
oneDay       = 86400000
build        = "#{__dirname}/build"

assetManagerGroups = css:
  route    : /\/assets\/style\/.*\.css/
  path     : "#{build}/assets/style/"
  dataType : 'css'
  files    : ['site.css']

# Middleware
app.use assetManager(assetManagerGroups)
app.use express.compress()
app.use express.logger('short')
app.use poweredBy()
app.use nowww()
app.use express.favicon("#{build}/assets")
app.use express.static(build, maxAge: oneDay)

# Routes
app.get '/:entry$', (req, res) ->
  if req.params.entry isnt 'feed'
    res.sendfile "#{build}/#{req.params.entry}.html",
      maxAge: oneDay

app.get '/:year/:month/:day/:entry/', (req, res) ->
  res.redirect req.params.entry

app.get '/archives/', (req, res) ->
  res.redirect 'archive'

app.get '/:entry/$', (req, res) ->
  res.redirect req.params.entry

# Error handling
app.use (req, res, next) ->
  res.status 404
  res.sendfile "#{build}/404.html", maxAge: oneDay * 365

app.use (err, req, res, next) ->
  console.error err.stack
  res.status 500
  res.sendfile "#{build}/500.html", maxAge: oneDay * 365

app.listen port

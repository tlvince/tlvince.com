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

app.use assetManager(assetManagerGroups)
app.use express.compress()
app.use express.logger('short')
app.use poweredBy()
app.use nowww()
app.use express.favicon("#{build}/assets")
app.use express.static(build, maxAge: oneDay)

app.get '/:entry$', (req, res) ->
  # Assume html top-level route
  if req.params.entry isnt 'feed'
    res.sendfile "#{build}/#{req.params.entry}.html",
      maxAge: oneDay

app.get '/:year/:month/:day/:entry/', (req, res) ->
  res.redirect req.params.entry

app.get '/archives/', (req, res) ->
  res.redirect 'archive'

app.get '/:entry/$', (req, res) ->
  res.redirect req.params.entry

app.listen port

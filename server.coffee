express      = require('express')
assetManager = require('connect-assetmanager')
poweredBy    = require('connect-powered-by')
nowww        = require('connect-no-www')
app          = express()
port         = process.env.PORT or 3000
oneDay       = 86400000

assetManagerGroups = css:
  route    : /\/assets\/style\/.*\.css/
  path     : __dirname + '/build/assets/style/'
  dataType : 'css'
  files    : ['site.css']

app.use assetManager(assetManagerGroups)
app.use express.compress()
app.use express.logger('short')
app.use poweredBy()
app.use nowww()
app.use express.favicon(__dirname + '/build/assets')
app.use express.static(__dirname + '/build', maxAge: oneDay)

app.get '/:entry$', (req, res) ->
  # Assume html top-level route
  if req.params.entry isnt 'feed'
    res.sendfile __dirname + '/build/' + req.params.entry + '.html',
      maxAge: oneDay

app.get '/:year/:month/:day/:entry/', (req, res) ->
  res.redirect req.params.entry

app.get '/:entry/$', (req, res) ->
  res.redirect req.params.entry

app.listen port

var express      = require('express'),
    assetManager = require('connect-assetmanager'),
    app          = express(),
    port         = process.env.PORT || 3000,
    oneDay       = 86400000;

var assetManagerGroups = {
  css: {
    route: /\/assets\/style\/.*\.css/,
    path: __dirname + '/build/assets/style/',
    dataType: 'css',
    files: ['site.css']
  }
};

var assetsManagerMiddleware = assetManager(assetManagerGroups);

app.use(express.compress());
app.use(express.logger('short'));
app.use(assetsManagerMiddleware);
app.use(express.favicon(__dirname + '/build/assets'));
app.use(express.static(__dirname + '/build', { maxAge: oneDay }));

app.listen(port);

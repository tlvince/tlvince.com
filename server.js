var express = require('express'),
    app     = express(),
    port    = process.env.PORT || 3000,
    oneDay  = 86400000;

app.use(express.compress());
app.use(express.logger('short'));
app.use(express.favicon(__dirname + '/build/assets'));
app.use(express.static(__dirname + '/build', { maxAge: oneDay }));

app.listen(port);

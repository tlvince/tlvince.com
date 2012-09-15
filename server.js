var connect = require('connect'),
    h5bp    = require('./h5bp.js'),
    port    = process.env.PORT || 3000,
    oneDay  = 86400000,
    options = {
      root: __dirname + '/build',
      maxAge: oneDay
    },
    server  = h5bp.server(connect, options);

server.listen(port);

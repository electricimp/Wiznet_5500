#!/usr/bin/env node

/**
 *  echo server
 *
 */

const DEFAULT_PORT = 60000;


var net = require('net');
var log = function(who, what) {
    return function() {
        var args = Array.prototype.slice.call(arguments);
        // console.log('[%s on %s]', who, what, args);
    };
};


var cid = 1;
var echo = function(socket) {

    socket.id = cid++;

    socket.on('data', function(data) {
        console.log("Data[%d]: %s", socket.id, data.toString().trim());
    });

    socket.on('timeout', function() {
        socket.destroy();
    });

    socket.on('close', function() {
        server.getConnections(function(err, count) {
            console.log("Disconnection from %s:%d, %d of %d open connections", socket.remoteAddress, socket.remotePort, socket.id, count);
        })
    });

    socket.on('end', log('socket', 'end'));
    socket.on('drain', log('socket', 'drain'));
    socket.on('error', log('socket', 'error'));

    socket.pipe(socket);

    server.getConnections(function(err, count) {
        console.log("Connection from %s:%d to %s:%d, %d of %d open connections", socket.remoteAddress, socket.remotePort, socket.localAddress, socket.localPort, socket.id, count);
    });
};


var port = parseInt(process.argv[2]);
if (port <= 1024 || isNaN(port)) port = DEFAULT_PORT;

/**
 *  net.Server (http://nodejs.org/api/net.html#net_class_net_server)
 *  events: listening, connections, close, err
 *  methods: listen, address, getConnections,  
 */
var server = net.createServer(echo);
server.listen({ host: "0.0.0.0", port: port });

server.on('listening', function() {
    var ad = server.address();
    console.log('Listening on %s:%s using %s', ad.address, ad.port, ad.family);
});

server.on('connection', function(socket) {
    socket.setKeepAlive(true);
    socket.setTimeout(30000);
});

server.on('error', function(err) {
    console.log(err);
    server.close(function() { console.log("shutting down the server!"); });
});

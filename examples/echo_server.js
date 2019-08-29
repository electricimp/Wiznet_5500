#!/usr/bin/env node

/**
 *  echo server
 *
 */

const DEFAULT_PORT = 4242;
const DEFAULT_HOST = "192.168.201.3";

var net = require('net');
var cid = 1;
var started = new Date().getTime() / 1000;
var port = parseInt(process.argv[2]);
if (port <= 1024 || isNaN(port)) port = DEFAULT_PORT;

function log() {
    var now = new Date().getTime() / 1000;
    var time = parseInt((now - started) % 10000);
    var args = Array.prototype.slice.call(arguments);
    args[0] = "[%d] " + args[0];
    args.splice(1, 0, time);
    console.log.apply(null, args);
}

function echo(socket) {

    socket.id = cid++;

    socket.on('data', function(data) {
        log("Data[%d]: %s", socket.id, data.toString('hex').trim());
    });

    socket.on('timeout', function() {
		log("Timeout!");
        socket.destroy();
    });

    socket.on('error', function() {
		log("Error!");
        socket.destroy();
    });

    socket.on('end', function() {
		log("End!");
        socket.destroy();
    });

    socket.on('close', function() {
		log("Close!");
        server.getConnections(function(err, count) {
            log("Disconnection from %s:%d, %d of %d open connections", socket.remoteAddress, socket.remotePort, socket.id, count);
        })
    });

    socket.on('drain', () => null);

    socket.pipe(socket);

    server.getConnections(function(err, count) {
        log("Connection from %s:%d to %s:%d, %d of %d open connections", socket.remoteAddress, socket.remotePort, socket.localAddress, socket.localPort, socket.id, count);
    });
};


/**
 *  net.Server (http://nodejs.org/api/net.html#net_class_net_server)
 *  events: listening, connections, close, err
 *  methods: listen, address, getConnections,  
 */
var server = net.createServer(echo);
server.listen({ host: DEFAULT_HOST, port: port });

server.on('listening', function() {
    var ad = server.address();
    log('Listening on %s:%s using %s', ad.address, ad.port, ad.family);
});

server.on('connection', function(socket) {
    socket.setKeepAlive(true);
    socket.setTimeout(90000);
});

server.on('error', function(err) {
    log(err);
    server.close(function() { log("shutting down the server!"); });
});

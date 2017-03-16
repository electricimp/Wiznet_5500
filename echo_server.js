#!/usr/bin/env node
/**
 *  echo server
 *
 */

const PORT = 60000;
var net = require('net');
var log = function(who, what) {
  return function() {
    var args = Array.prototype.slice.call(arguments);
    // console.log('[%s on %s]', who, what, args);
  };
};

var echo = function(socket) {
  /**
   *  net.Socket (http://nodejs.org/api/net.html#net_class_net_socket)
   *  events: end, data, end, timeout, drain, error, close
   *  methods:
   */
  socket.on('data', function(data) {
    // data is a Buffer object
    console.log("Data:", data.toString().trim());
  });

  socket.on('end', log('socket', 'end'));
  socket.on('timeout', log('socket', 'timeout'));
  socket.on('drain', log('socket', 'drain'));
  socket.on('error', log('socket', 'error'));
  socket.on('close', log('socket', 'close'));

  socket.pipe(socket);
};

/**
 *  net.Server (http://nodejs.org/api/net.html#net_class_net_server)
 *  events: listening, connections, close, err
 *  methods: listen, address, getConnections,  
 */
var server = net.createServer(echo);
server.listen({ host: "0.0.0.0", port: PORT }); 

server.on('listening', function() {
  var ad = server.address();
  if (typeof ad === 'string') {
    console.log('Listening: %s', ad);
  } else {
    console.log('Listening on %s:%s using %s', ad.address, ad.port, ad.family);
  }
});

server.on('connection', function(socket) {
  server.getConnections(function(err, count) {
    console.log('Open: %d', count);
  });
});

server.on('close', function(socket) {
  server.getConnections(function(err, count) {
    console.log('Close: %d', count);
  });
});

server.on('error', function(err) { 
  console.log(err);
  server.close(function() { console.log("shutting down the server!"); });
});


# Wiznet W5500

This library allows you to communicate with a TCP/IP network (separate from an imp’s connection to the network) using the [Wiznet W5500 chip](http://wizwiki.net/wiki/lib/exe/fetch.php?media=products:w5500:w5500_ds_v106e_141230.pdf). The W5500 chip is a hardwired TCP/IP embedded Ethernet controller. The W5500 is used by the [impAccelerator&trade; Fieldbus Gateway](https://electricimp.com/docs/hardware/resources/reference-designs/fieldbusgateway/).

This library supports SPI integration with the W5500.

**To use this library, add** `#require "W5500.device.nut:1.0.0"` **to the top of your device code.**

## W5500 Class Usage

### Constructor: W5500(*interruptPin, spi[, csPin][, resetPin][, autoRetry]*)

| Parameter | Data Type | Required | Default Value | Description |
| --- | --- | --- | --- | --- |
| *interruptPin* |imp **pin** object|Yes|N/A|The pin represents a physical pin on the imp and is used for receiving interrupts from the W5500 chip. The pin can be any digital input that supports a callback on pin state change |
| *spi* | imp **spi** object | Yes | N/A | A configured SPI object |
| *csPin* | imp **pin** object | No | null | The pin represents a physical pin on the imp and is used to select the SPI bus. On the imp005 if you do not pass a pin into *csPin* you must configure the SPI with the *USE_CS_L* constant |
| *resetPin* | imp **pin** object | No | N/A| The pin represents a physical pin on the imp and is used for sending a hard reset signal to the W5500 chip |
| *autoRetry* | Boolean | No | false | Whether the library should automatically retry to open a connection should one fail. **Note** Yet to be implemented |

#### Example

```squirrel
// Setup for an imp005
speed <- 4000;
spi <- hardware.spi0;
spi.configure(CLOCK_IDLE_LOW | MSB_FIRST | USE_CS_L, speed);

resetPin <- hardware.pinN;
interruptPin <- hardware.pinXA;

wiz <- W5500(interruptPin, spi, null, resetPin);
```

```squirrel
// Setup for an imp001
speed <- 4000;
spi <- hardware.spi257
spi.configure(CLOCK_IDLE_LOW | MSB_FIRST, speed);

cs <- hardware.pin8;
resetPin <- hardware.pin9;
interruptPin <- hardware.pin1;

wiz <- W5500(interruptPin, spi, cs, resetPin);
```

## W5500 Class Methods

### configureNetworkSettings(*sourceIP[, subnet_mask][, gatewayIP][, mac]*)

This method takes the network information and sets the data into the relevant registers in the Wiznet chip.

#### Inputs

| Parameter | Data Type | Required | Default Value | Description |
| --- | --- | --- | --- | --- |
| *sourceIP* | String or an array of integers | Yes | N/A | The IP address for Wiznet adapter. For example, the address 192.168.1.37 can be passed in as an array, `[192, 168, 1, 37]`, or as a string `"192.168.1.37"` |
| *subnet_mask* | String or an array of four integers | No | null | The subnet mask. For example, a subnet mask of 255.255.255.0 can be passed in as an array, `[255, 255, 255, 0]`, or as a string `"255.255.255.0"` |
| *gatewayIP* | String or an array of four integers | No  | null | The IP address of the gateway or router. For example, the address 192.168.1.1 can be passed in as an array, `[192, 168, 1, 1]`, or as a string `"192.168.1.1"` |
| *mac* | String or an array of six integers | No | A function that will return the MAC address of the Wiznet | The MAC address to assign to the Wiznet adapter. It is easiest to let the MAC address be set automatically by leaving this as null. You can manually enter the address 0c:2a:69:09:76:64 by passing it into an array, `[0x0c, 0x2a, 0x69, 0x09, 0x76, 0x64]`, or as a string `"0c2a69097664"` |

#### Example

```squirrel
    // Configured using strings
    wiz.configureNetworkSettings("192.168.1.37", "255.255.255.0", "192.168.1.1");
```

```squirrel
    // Configured using arrays
    wiz.configureNetworkSettings([192,168,1,37], [255,255,255,0], [192,168,1,1]);
```

### onReady(*callback*)

Has method has a single, required argument: a callback function. The callback will be executed when the initialization of the W5500 has completed successfully. It will be called immediately if the initialization has already been completed. The callback takes no parameters.

#### Example

```squirrel
// The callback funciton will not run until the 5500 has finished initializing
wiz.onReady(function() {
    server.log("The Wiznet W5500 is ready");     
}.bindenv(this));
```

### openConnection(*ip, port[, mode][, callback]*)

This method finds a socket that is not in use and initializes a connection for the socket.

| Parameter | Data Type | Required | Default Value | Description |
| --- | --- | --- | --- | --- |
| *ip* | String or an array of four integers | Yes | N/A | The destination IP address. For example, the address 192.168.1.37 can be passed in as an array, `[192, 168, 1, 37]`, or as a string `"192.168.1.37"` |
| *port* | An integer or an array of two integers | Yes | N/A | The destination port. For port 4242, pass in an array, `[0x10, 0x92]`, or an integer `4242` |
| *mode* | Constant | No | *W5500_SOCKET_MODE_TCP* | The mode of communication to be used by the socket. The list of available options is listed in the table below. Currently only TCP is supported |
| *callback* | Function | No | null | A callback function that is passed an error message or the opened connection. The callback’s parameters are listed below |

#### Communication Modes

| Constant | Value |
| --- | --- |
| W5500_SOCKET_MODE_TCP | 0x01 |
| W5500_SOCKET_MODE_UDP | 0x02 |

#### Callback Parameters

| Parameter | Data Type | Description |
| --- | --- | --- |
| *error* | String | An error message if there was a problem, or null if successful |
| *connection* | A W5500.Connection object | An instantiated object representing the open socket connection |

#### Example

```squirrel
// Using a string and a integer
local destIp = "192.168.1.42";
local destPort = 4242;
wiz.openConnection(destIp, destPort, function(error, connection) {
   if (error) {
       server.error(error);
   } else {
       // Work with connection
   }
}.bindenv(this));
```

```squirrel
// Using arrays
local destIp = [192, 168, 1, 42];
local destPort = [0x10, 0x92];
wiz.openConnection(destIp, destPort, function(error, connection) {
   if (error) {
       server.error(error);
   } else {
       // Work with connection
   }
}.bindenv(this));

```

### listen(*port, callback*)

This method function finds a socket that is not in use and sets up a TCP server. It has the following parameters:

| Parameter | Data Type | Required | Default Value | Description |
| --- | --- | --- | --- | --- |
| *port* | An integer | Yes | N/A | The port to listen on for connections |
| *callback* | Function | Yes | N/A | A callback function that is passed an error message, or the established remote connection is established. The table below lists its parameters |

#### Callback Parameters

| Parameter | Data Type | Description |
| --- | --- | --- |
| *error* | String | An error message if there was a problem, or null if successful |
| *connection* | A W5500.Connection object | An instantiated object representing the open socket connection |

#### Example

```squirrel
local port = 80;
wiz.listen(port, function(error, connection) {
    if (error) {
        server.error(error);
    } else {
        local ip = connection.getIP();
        local port = connection.getPort();
        server.log(format("Connection established from %d.%d.%d.%d:%d", ip[0], ip[1], ip[2], ip[3], port));
    }
}.bindenv(this))
```

### reset(*[softReset]*)

This method causes the Wiznet chip to undergo a reset. It is recommended that your use hardware resets (the default behaviour) and to wait for the *onReady()* callback to be triggered before proceeding after a reset.

The single parameter, *softReset*, is a Boolean value: pass `true` to trigger a soft reset, or `false` (the detault) for a hard reset.

#### Example

```squirrel
// Perform a hardware reset
wiz.reset();
wiz.onReady(function() {
    // Reset complete, so configure the Wiznet 5500 here
}.bindenv(this));
```
```squirrel
// A software reset
wiz.reset(true);
wiz.onReady(function() {
    // Reset complete, so configure the Wiznet 5500 here
}.bindenv(this));
```

### setNumberOfAvailableSockets(*numSockets*)

This method configures the Wiznet 5500’s buffer memory allocation by dividing the available memory between the number of required sockets evenly. If you need a greater buffer per socket, allocate fewer sockets. The default behaviour is to allocate eight sockets.

#### Example

```squirrel
wiz.setNumberOfAvailableSockets(2);
```

### isPhysicallyConnected()

This method returns `true` if the W5500 detects an Ethernet cable is plugged into the socket to which the chip is connected.

#### Example
```squirrel
server.log(format("Cable %s connected.", wiz.isPhysicallyConnected() ? "is" : "is not"));
```

### forceCloseAllSockets()

This method closes all sockets by sending a disconnect request followed by a close request.

#### Example

```squirrel
wiz.forceCloseAllSockets();
```

### getNumSocketsFree()

This method returns the number of sockets that are still available for use. The number is returned as an integer.

#### Example

```squirrel
if (wiz.getNumSocketsFree() == 0)  server.error("Wiznet is busy.");
```

## W5500.Connection Class Usage

This connection class is used to perform all actions using the connection. This includes initializing and ending a connection to a socket, as well as using the connection for transmission and reception of data packets.

You do no instantiate W5500.Connection objects yourself &mdash; they will be generated for you by the methods detailed above.

## W5500.Connection Class Methods

### open(*[callback]*)

This method opens a socket then sets up the connection. It is called as part of *openConnection()* and should not be called directly.

### close(*[callback]*)

This method loses the connection on a socket then fires the supplied callback on completion of all stages of disconnection. This callback takes no parameters.

#### Example

```squirrel
connection.close(function(){
    server.log("Connection closed");
}.bindenv(this));
```

### getSocket()

This method returns the ID of the socket.

#### Example

```squirrel
server.log("This connection is using socket " + connection.getSocket());
```

### isEstablished()

This method returns a Boolean: `true` if a connection is established, otherwise `false`.

#### Example

```squirrel
server.log(connection.isEstablished() ? "established" : "not established");
```

### onReceive(*[callback]*)

This method triggers the supplied callback function when data is received. The callback takes the following parameters:

| Parameter | Data Type | Description|
| --- | --- | --- |
| *error* | String | An error message if there was a problem, or `null` if it was successful |
| *data* | Blob | The data that was received |

#### Example

```squirrel
connection.onReceive(function(error, data) {
    if (error) {
        server.error(error);
    } else {
        server.log("Received data: " + data);
    }
}.bindenv(this));
```

### onDisconnect(*[callback]*)

This method triggers the supplied callback function when a disconnection takes place. The callback takes a single parameter of its own: *error*, which will be a string if an error occured, or `null`.

#### Example

```squirrel
connection.onDisconnect(function(error) {
    if (error) server.error(error);
    server.log("Disconnected");
}.bindenv(this));
```

### onClose(*[cb]*)

This method triggers the supplied callback function when the connection is fully closed and removed from the system. The callback takes no parameters.

#### Example

```squirrel
connection.onClose(function() {
    server.log("Connection closed");
}.bindenv(this));
```

### transmit(*transmitData[, callback]*)

This method is called within a connection to transmit the data through the socket.  

| Parameter | Data Type | Required | Default Value | Description |
| --- | --- | --- | --- | --- |
| *transmitData* | Blob or string | Yes | N/A | The data to be transmitted |
| *callback* | Function | No | null | The callback is called in the event of data being successfully sent or in the event of a timeout. It has a single parameter into which is passed an error message if there was a problem or `null` if transmission was successful |

#### Example

```squirrel
local data = "Hello, world.";
connection.transmit(data, function(error) {
    if (error) {
        server.error(error);
    } else {
        server.log("Data sent successfully");
    }
}.bindenv(this));
```

### receive(*[callback]*)

This method is an alternative to *onReceive()* and which will temporarily override *onReceive()*. It receives the next available data packet on the connection. If a callback is supplied, it should take the following two parameters:

| Parameter | Data Type | Description |
| --- | --- | --- |
| *error* | String | An error message if there was a problem or `null` if it was successful |
| *data* | Blob | The data that was received |

#### Example  

```squirrel
connection.receive(function(error, data) {
    if (error) {
        server.error(error);
    } else {
        server.log("Received data: " + data);
    }
}.bindenv(this));
```

## W5500.Driver Class

The W5500.Driver class is responsible for a number of low-levels operations, including opening and closing sockets, setting memory, getting memory, and setting and getting socket modes. The W5500 and W5500.Connection classes make use of this class.

## License

The Wiznet code is licensed under the [MIT License](./LICENSE).

# Wiznet W5500 #

The W5500 chip is a hardwired TCP/IP embedded Ethernet controller. We have two libraries for use with the [Wiznet W5500 chip](http://wizwiki.net/wiki/lib/exe/fetch.php?media=products:w5500:w5500_ds_v106e_141230.pdf). 

The base library allows you to communicate with a TCP/IP network (separate from an imp’s connection to the network). This library supports SPI integration with the W5500. See documentation [below](#w5500-class-usage). 

In addition we have a W5500.DHCP library that enables Dynamic Host Configuration Protocol (DHCP) functionality for the [Wiznet W5500 chip](http://wizwiki.net/wiki/lib/exe/fetch.php?media=products:w5500:w5500_ds_v106e_141230.pdf). Documentation and source code can be found in the [DHCP directory](./DHCP).

The W5500 is used by the [impAccelerator&trade; Fieldbus Gateway](https://developer.electricimp.com/hardware/resources/reference-designs/fieldbusgateway).

**To include the base library in your project, add** `#require "W5500.device.lib.nut:2.1.1"` **at the top of your device code**

## W5500 Class Usage ##

### Constructor: W5500(*interruptPin, spi[, csPin][, resetPin][, autoRetry][, setMac]*) ###

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *interruptPin* | imp **pin** object | Yes | The pin represents a physical pin on the imp and is used for receiving interrupts from the W5500 chip. The pin can be any digital input that supports a callback on pin state change |
| *spi* | imp **spi** object | Yes | A configured SPI object |
| *csPin* | imp **pin** object | No | The pin represents a physical pin on the imp and is used to select the SPI bus. On the imp005 if you do not pass a pin into *csPin* you must configure the SPI with the *USE_CS_L* constant, Default: `null` |
| *resetPin* | imp **pin** object | No | The pin represents a physical pin on the imp and is used for sending a hard reset signal to the W5500 chip |
| *autoRetry* | Boolean | No | Whether the library should automatically retry to open a connection should one fail. Default: `false`. **Note** Not yet implemented |
| *setMac* | Boolean | No | Whether the library should set the MAC address of the chip to the imp’s own MAC (with the last bit flipped). This should be set to `false` when using a Wiznet Wiz550io board, since it has its own MAC address. Default: `true` |
 
#### Examples ####

```squirrel
// Setup for an imp005 Fieldbus Gateway

// Configure pins 
interruptPin <- hardware.pinXC;
resetPin     <- hardware.pinXA;

// Initialize SPI 
spiSpeed     <- 1000;
spi          <- hardware.spi0;
spi.configure(CLOCK_IDLE_LOW | MSB_FIRST | USE_CS_L, spiSpeed);

// Initialize Wiznet
wiz <- W5500(interruptPin, spi, null, resetPin);
```

```squirrel
// Setup for an imp001 
speed        <- 1000;
spi          <- hardware.spi257
spi.configure(CLOCK_IDLE_LOW | MSB_FIRST, speed);

cs           <- hardware.pin8;
resetPin     <- hardware.pin9;
interruptPin <- hardware.pin1;

wiz <- W5500(interruptPin, spi, cs, resetPin);
```

## W5500 Class Methods ##

### configureNetworkSettings(*sourceIP[, subnetMask][, gatewayIP][, mac]*) ###

This method takes the network information and sets the data into the relevant registers in the Wiznet chip.

#### Parameters ####

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *sourceIP* | String or an array of integers | Yes | The IP address for Wiznet adapter. For example, the address 192.168.1.37 can be passed in as an array, `[192, 168, 1, 37]`, or as a string `"192.168.1.37"` |
| *subnetMask* | String or an array of four integers | No | The subnet mask. For example, a subnet mask of 255.255.255.0 can be passed in as an array, `[255, 255, 255, 0]`, or as a string `"255.255.255.0"`. Default: `null` |
| *gatewayIP* | String or an array of four integers | No | The IP address of the gateway or router. For example, the address 192.168.1.1 can be passed in as an array, `[192, 168, 1, 1]`, or as a string `"192.168.1.1"`. Default: `null` |
| *mac* | String or an array of six integers | No | The MAC address to assign to the Wiznet adapter. It is easiest to let the MAC address be set automatically by leaving this as `null`. You can manually enter the address 0c:2a:69:09:76:64 by passing it into an array, `[0x0c, 0x2a, 0x69, 0x09, 0x76, 0x64]`, or as a string `"0c2a69097664"`. Default: `null` |

#### Returns ####

The instance (*this*).

#### Examples ####

```squirrel
// Configured using strings
wiz.configureNetworkSettings("192.168.1.37", "255.255.255.0", "192.168.1.1");
```

```squirrel
// Configured using arrays
wiz.configureNetworkSettings([192,168,1,37], [255,255,255,0], [192,168,1,1]);
```

### onReady(*callback*) ###

This method is used to register a callback function that will be triggered to notify you that the W5500 is ready for use. 

#### Parameters ####

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *callback* | Function | Yes | A function that will be executed when the initialization of the W5500 has completed successfully. It will be called immediately if the initialization has already been completed. It has no parameters of its own |

#### Returns ####

The instance (*this*).

#### Example ####

```squirrel
// The callback function will not run until the 5500 has finished initializing
wiz.onReady(function() {
    server.log("The Wiznet W5500 is ready");
}.bindenv(this));
```

### openConnection(*ip, port[, mode][, callback]*) ###

This method finds a socket that is not in use and initializes a connection for the socket.

#### Parameters ####

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *ip* | String or an array of four integers | Yes | The destination IP address. For example, the address 192.168.1.37 can be passed in as an array, `[192, 168, 1, 37]`, or as a string `"192.168.1.37"` |
| *port* | An integer or an array of two integers | Yes | The destination port. For port 4242, pass in an array, `[0x10, 0x92]`, or an integer `4242` |
| *mode* | Constant | No | The [mode of communication](#communication-mode-constants) to be used by the socket. The list of available options is listed in the table below. Currently only TCP is supported. Default: *W5500_SOCKET_MODE_TCP* |
| *callback* | Function | No | A callback function that is passed an error message or the opened connection. The callback’s parameters are [listed below](#on-open-callback-parameters). Default: `null` |

#### Communication Mode Constants ####

| Communication&nbsp;Mode | Value |
| --- | --- |
| *W5500_SOCKET_MODE_TCP* | 0x01 |
| *W5500_SOCKET_MODE_UDP* | 0x02 |

#### On Open Callback Parameters ####

| Parameter | Data&nbsp;Type | Description |
| --- | --- | --- |
| *error* | String | An error message if there was a problem, or `null` if successful |
| *connection* | A W5500.Connection object | An instantiated object representing the open socket connection |

#### Returns ####

Nothing.

#### Examples ####

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

### listen(*port, callback*) ###

This method finds a socket that is not in use and sets up a TCP server.

#### Parameters ####

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *port* | An integer | Yes | The port to listen on for connections |
| *callback* | Function | Yes | A callback function that is passed an error message, or the established remote connection is established. The table below lists its parameters |

| Callback Parameter | Data&nbsp;Type | Description |
| --- | --- | --- |
| *error* | String | An error message if there was a problem, or `null` if successful |
| *connection* | A W5500.Connection object | An instantiated object representing the open socket connection |

#### Returns ####

Nothing.

#### Example ####

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

### reset(*[softReset]*) ###

This method causes the Wiznet chip to undergo a reset. It is recommended that you use hardware resets (the default behavior) and to wait for the [callback registered with *onready()*](#onreadycallback) to be triggered before proceeding after a reset.

#### Parameters ####

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *softReset* | Boolean | No | Pass `true` to trigger a soft reset, or `false` for a hard reset. Default: `false` |

#### Returns ####

Nothing.

#### Examples ####

```squirrel
// Perform a hardware reset
wiz.onReady(function() {
    // Reset complete, so configure the Wiznet 5500 here
}.bindenv(this));
wiz.reset();
```

```squirrel
// A software reset
wiz.onReady(function() {
    // Reset complete, so configure the Wiznet 5500 here
}.bindenv(this));
wiz.reset(true);
```

### setNumberOfAvailableSockets(*numSockets*) ###

This method configures the Wiznet 5500’s buffer memory allocation by dividing the available memory between the number of required sockets evenly. If you need a greater buffer per socket, allocate fewer sockets. The default behavior is to allocate eight sockets.

#### Parameters ####

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *numSockets* | Integer | Yes | The number of sockets required |

#### Returns ####

Integer &mdash; The number of actual sockets set.

#### Example ####

```squirrel
wiz.setNumberOfAvailableSockets(2);
```

### isPhysicallyConnected() ###

This method indicates whether an Ethernet cable is plugged into the socket to which the W5500 is connected.

#### Returns ####

Boolean &mdash; `true` if the W5500 is physically connected, otherwise `false`.

#### Example ####

```squirrel
server.log(format("Cable %s connected.", wiz.isPhysicallyConnected() ? "is" : "is not"));
```

### forceCloseAllSockets() ###

This method closes all sockets by sending a disconnect request followed by a close request.

#### Returns ####

Nothing.

#### Example ####

```squirrel
wiz.forceCloseAllSockets();
```

### getNumSocketsFree() ###

This method determines the number of sockets that are still available for use.

#### Returns ####

Integer &mdash; The number of sockets available.

#### Example ####

```squirrel
if (wiz.getNumSocketsFree() == 0) server.error("Wiznet is busy.");
```

## W5500.Connection Class Usage ##

This connection class is used to perform all actions using the connection. This includes initializing and ending a connection to a socket, as well as using the connection for the transmission and reception of data packets.

You do not instantiate W5500.Connection objects yourself. Instead, they will be generated for you by the methods detailed above.

## W5500.Connection Class Methods ##

### open(*[callback]*) ###

This method opens a socket then sets up the connection. It is called as part of *openConnection()* and should not be called directly.

#### Parameters ####

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *callback* | Function | No | A function to be called when the connection is open, or an error occurred |

#### Returns ####

The instance (*this*).

### close(*[callback]*) ###

This method closes a connection via the W5500. 

#### Parameters ####

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *callback* | Function | No | A function to be called when the connection is closed, or an error occurred. It has no parameters of its own |

#### Returns ####

Nothing.

#### Example ####

```squirrel
connection.close(function(){
    server.log("Connection closed");
}.bindenv(this));
```

### getSocket() ###

This method retrieves the ID of the socket.

#### Returns ####

Integer &mdash; The socket ID.

#### Example ####

```squirrel
server.log("This connection is using socket " + connection.getSocket());
```

### isEstablished() ###

This method indicates whether a connection is open via the W5500.

#### Returns ####

Boolean &mdash; `true` if a connection is established, otherwise `false`.

#### Example ####

```squirrel
server.log("A W5500 link is " + (connection.isEstablished() ? "established" : "not established"));
```

### onReceive(*[callback]*) ###

This method registers a callback function that will be triggered when data is received.

#### Parameters ####

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *callback* | Function | No | A function to be called when data is received. Its parameters are listed below |

| Parameter | Data&nbsp;Type | Description|
| --- | --- | --- |
| *error* | String | An error message if there was a problem, or `null` if it was successful |
| *data* | Blob | The data that was received |

#### Returns ####

The instance (*this*).

#### Example ####

```squirrel
connection.onReceive(function(error, data) {
    if (error) {
        server.error(error);
    } else {
        server.log("Received data: " + data);
    }
}.bindenv(this));
```

### onDisconnect(*[callback]*) ###

This method registers a callback function that will be triggered when the connection is broken.

#### Parameters ####

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *callback* | Function | No | A function to be called when the W5500 is disconnects. Its parameters are listed below |

| Callback&nbsp;Parameter | Data&nbsp;Type | Description|
| --- | --- | --- |
| *error* | String | An error message if there was a problem, or `null` if it was successful |

#### Returns ####

The instance (*this*).

#### Example ####

```squirrel
connection.onDisconnect(function(error) {
    if (error) server.error(error);
    server.log("Disconnected");
}.bindenv(this));
```

### onClose(*[callback]*) ###

This method registers a callback function that will be triggered when the connection is fully closed and removed from the system.

#### Parameters ####

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *callback* | Function | No | A function to be called when the connection is closed. It has no parameters of its own |

#### Returns ####

The instance (*this*).

#### Example ####

```squirrel
connection.onClose(function() {
    server.log("Connection closed");
}.bindenv(this));
```

### transmit(*data[, callback]*) ###

This method is called within a connection to transmit the data through the socket.

#### Parameters ####

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *data* | Blob or string | Yes | The data to be transmitted |
| *callback* | Function | No | The callback triggered when data was sent successfully or a timeout occurred. Its parameters are listed below |

| Callback&nbsp;Parameter | Data&nbsp;Type | Description|
| --- | --- | --- |
| *error* | String | An error message if there was a problem, or `null` if it was successful |

#### Returns ####

The instance (*this*).

#### Example ####

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

### receive(*[callback]*) ###

This method is an alternative to [*onReceive()*](#onreceivecallback) and which will temporarily override [*onReceive()*](#onreceivecallback). It receives the next available data packet on the connection.

#### Parameters ####

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *callback* | Function | No | The callback triggered when data was received. Its parameters are listed below |

| Callback&nbsp;Parameters | Data&nbsp;Type | Description|
| --- | --- | --- |
| *error* | String | An error message if there was a problem, or `null` if it was successful |
| *data* | Blob | The data that was received |

#### Returns ####

The instance (*this*).

#### Example ####

```squirrel
connection.receive(function(error, data) {
    if (error) {
        server.error(error);
    } else {
        server.log("Received data: " + data);
    }
}.bindenv(this));
```

## W5500.Driver Class ##

The W5500.Driver class is responsible for a number of low-levels operations, including opening and closing sockets, setting and getting memory, and setting and getting socket modes. The W5500 and W5500.Connection classes make use of this class.

## License ##

The Wiznet code is licensed under the [MIT License](./LICENSE).

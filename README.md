# Wiznet W5500

This library allows you to communicate with a TCP/IP network (separate from the Imp's connection to the network) using the [Wiznet W5500 chip](http://wizwiki.net/wiki/lib/exe/fetch.php?media=products:w5500:w5500_ds_v106e_141230.pdf). The W5500 chip is a hardwired TCP/IP embedded Ethernet controller. This library supports SPI integration with the W5500.

**To use this library, add `#require "W5500.device.nut:1.0.0"` to the top of your device code.**

## Class W5500

### Constructor: W5500(*interruptPin, spi[, csPin][, resetPin][, autoRetry]*)

| Key | Data Type |Required | Default Value |Description |
|----|------------|---------|--------------|------------|
|interruptPin|hardware.pin|Yes|N/A|The Pin represents a physical pin on the imp card or module. This pin is used for receiving interrupts from the W5500 chip. The pin can be any digital input that supports a callback on pin state change  |
|spi|hardware.spi|Yes|N/A|A configured spi object|
|csPin|hardware.pin|No|null|The Pin represents a physical pin on the imp card or module. In this case the pin used for selecting the spi bus. On the Imp005 if you do not pass in a csPin you must configure the SPI with the USE_CS_L constant|
|resetPin|hardware.pin|No|N/A|The Pin represents a physical pin on the imp card or module. In this case the pin used for sending a hard reset signal for the W5500 chip|
|autoRetry|Boolean|No|false| autoRetry will automatically retry to open a connection should one initially fail. Yet to be implemented.|

#### Example Code:
```squirrel
// setup for an Imp 005
speed <- 4000;
spi <- hardware.spi0;
spi.configure(CLOCK_IDLE_LOW | MSB_FIRST | USE_CS_L, speed);

resetPin <- hardware.pinN;
interruptPin <- hardware.pinXA;

wiz <- W5500(interruptPin, spi, null, resetPin);
```

```squirrel
// setup for an Imp 001 or 002
speed <- 4000;
spi <- hardware.spi257
spi.configure(CLOCK_IDLE_LOW | MSB_FIRST, speed);

cs <- hardware.pin8;
resetPin <- hardware.pin9;
interruptPin <- hardware.pin1;

wiz <- W5500(interruptPin, spi, cs, resetPin);
```

## Class Methods

### configureNetworkSettings(*sourceIP[, subnet_mask][, gatewayIP][, mac]*)

This function takes the network information and sets the data into the relevant registers in the Wiznet chip.

#### Inputs

| Key | Data Type |Required | Default Value |Description |
|----|------------|---------|--------------|------------|
| SourceIP | String or an array of integers |Yes| N/A| The IP address for Wiznet adapter. For an IP address 192.168.1.37 can be passed in as an array: [192, 168, 1, 37] or as a string "192.168.1.37" |
| *subnet_mask* | string or an array of four integers |No |null| The subnet mask. For a subnet mask 255.255.255.0 pass it in as an array [255, 255, 255, 0] or as a string "255.255.255.0" |
| *gatewayIP* | String or an array of four integers |No|null |The IP address of the gateway or router. For an IP address 192.168.1.1 pass it in as array  [192, 168, 1, 1] or as a string "192.168.1.1"|
| *mac* | string or an array of six integers |No|An internal function that  will return the mac address of the Wiznet |The mac address to assign to the Wiznet adapter. It is easiest to let the mac address be set automatically by leaving this as null. You can manually enter the address 0c:2a:69:09:76:64 by passing it into an array [0x0c, 0x2a, 0x69, 0x09, 0x76, 0x64] or pass it as a string `"0c2a69097664"`|

#### Example Code:
```squirrel
    // configured using strings
    wiz.configureNetworkSettings("192.168.1.37", "255.255.255.0", "192.168.1.1");
```
```squirrel
    // configured using arrays
    wiz.configureNetworkSettings([192,168,1,37], [255,255,255,0], [192,168,1,1]);
```
### onReady(*cb*)
Has 1 required argument a callback function. The callback will be called when the initialization of the W5500 is successfully completed. It will be called immediately if the initialization has already been completed.

| Key | Data Type |Required | Default Value |Description |
|----|------------|---------|--------------|------------|
|cb|function|Yes|N/A| A function that is called when the Wiznet initialization has completed. It expects no parameters.|

#### Example Code:  
```squirrel
    // the callback funciton will not run until wiz has finished initializing
    wiz.onReady(function() {
        // The Wiznet device is ready      
    }.bindenv(this));
```

### openConnection(*ip, port[, mode][, cb]*)

The *openConnection()*  finds a socket that is not in use and Initializes a connection for the socket.

#### Connection Settings
| key | Data Type | Required | Default Value |Description |
| ----- | -------- | ----|----|  --------------- |
| ip | String or an array of 4 integers | Yes |N/A| The destination IP address. For the IP address 192.168.1.42 pass in an array  [192, 168, 1, 42] or a string "192.168.1.42"|
| port | An integer or an array of 2 integers | Yes |N/A| The destination port. For port 4242 pass in array [0x10, 0x92] or as integer 4242|
|mode |enum|No|W5500_SOCKET_MODE_TCP|The mode of communication to be used by the socket. The list of available options is listed in the table before. Currently only TCP is supported. |
|cb| Function | No | null | A callback function that is passed an error message or the connection during *openconnection* |

#### Mode communication type codes
|Code (Hex)|Value|
|-----|--------|
|0x01|W5500_SOCKET_MODE_TCP|
|0x02|W5500_SOCKET_MODE_UDP|

#### Callback Arguments
|Key |Data Type|Description|
|-----|----|--------------|
|error|String|An error message if there was a problem or null if successful.|
|connection|W5500.Connection object|An instantiated object representing the open socket connection.|


#### Example Code:
```squirrel
    // using a string and a integer
    local destIp = "192.168.1.42";
    local destPort = 4242;
    wiz.openConnection(destIp, destPort, function(error, connection) {
        server.log(error);
    }.bindenv(this))
```
```squirrel
    // using arrays
    local destIp = [192, 168, 1, 42];
    local destPort = [0x10, 0x92];
    wiz.openConnection(destIp, destPort, function(error, connection) {
        server.log(error);
    }.bindenv(this))

```


### listen(*port, cb*)

The *listen()* function finds a socket that is not in use and sets up a TCP server. 

#### Connection Settings
| key | Data Type | Required | Default Value |Description |
| ----- | -------- | ----|----|  --------------- |
| port | An integer | Yes | N/A | The port to listen on for connections. |
| cb   | Function   | Yes | N/A | A callback function that is passed an error message or the connection when a remote connection is established. |

#### Callback Arguments
|Key |Data Type|Description|
|-----|----|--------------|
|error|String|An error message if there was a problem or null if successful.|
|connection|W5500.Connection object|An instantiated object representing the open socket connection.|


#### Example Code:
```squirrel
    local port = 80;
    wiz.listen(port, function(error, connection) {
        if (error) return server.log(error);
        local ip = connection.getIP();
        local port = connection.getPort();
        server.log(format("Connection established from %d.%d.%d.%d:%d", ip[0], ip[1], ip[2], ip[3], port));
    }.bindenv(this))
```


### reset (*[sw]*)
*reset()* causes the Wiznet chip to undergo a reset. It is recommended to use hardware resets (the default behaviour). It is recommended to wait for the onReady() callback before proceeding further after a reset.

| Key   | Data Type | Required | Default Value | Description     |
| ----- | --------- | -------- | ------------- | --------------- |
| sw    | boolean   | No       | false         | Set to true to perform a software reset or false to perform a hardware reset |

#### Example Code:
```squirrel
    // A hardware reset
    wiz.reset();
    wiz.onReady(function() {
        // Reset complete, configure the Wiznet 5500 here
    }.bindenv(this));
```
```squirrel
    // A software reset
    wiz.reset(true);
    wiz.onReady(function() {
        // Reset complete, configure the Wiznet 5500 here
    }.bindenv(this));
```


### setNumberOfAvailableSockets(*numSockets*)

The *setNumberOfAvailableSockets()* function configures the Wiznet 5500's buffer memory allocation by dividing the available memory between the number of required sockets evenly. If you need a greater buffer, allocate fewer sockets. The default behaviour is to allocate all 8 sockets.

#### Connection Settings
| Key | Data Type | Required | Default Value |Description |
| ----- | -------- | ----|----|  --------------- |
| numSockets | integer | No | 8 | The number of sockets to enable. |


#### Example Code:
```squirrel
    wiz.setNumberOfAvailableSockets(2);
```


### reset (*[sw]*)
*reset()* causes the Wiznet chip to undergo a software reset. It is  recommended to use hardware resets.

| Key | Data Type |Required|Default Value |Description |
| ----- | -------- | ----|----|  --------------- |
|sw|boolean|No |false|Set to true to perform a software reset or false to perform a hardware reset|

#### Example Code:
```squirrel
    wiz.reset();
```



### isPhysicallyConnected()
*isPhysicallyConnected()* returns true if the W5500 detects an ethernet cable is plugged into the socket.

#### Example Code:
```squirrel
    server.log(format("Cable %s connected.", wiz.isPhysicallyConnected() ? "is" : "is not"));
```



### forceCloseAllSockets()
*forceCloseAllSockets()* closes all sockets by sending a disconnect request followed by a close request.

#### Example Code:
```squirrel
    wiz.forceCloseAllSockets();
```



### getNumSocketsFree()
*getNumSocketsFree()* returns the number (integer) of sockets that are still available for use. 

#### Example Code:
```squirrel
    if (wiz.getNumSocketsFree() == 0) {
        server.error("Wiznet is busy.")
    }
```




# W5500.Connection

The connection class is used to perform all actions for a connection. This includes initializing and ending a connection to a socket. As well as using the connection for transmission and reception of data packets.

## Class Methods

### open(*[cb]*)

opens a socket then sets up the connection. Called as part of *openConnection()*, not to be called directly.

### close(*[cb]*)
Closes the connection on a socket then fires the callback on completion of all stages of disconnection.

|Key|Data Type|Required|Default Value |Description |
| ----- | -------- | ----|----|  --------------- |
|cb|Function|No|null|Callback function that can be called upon the closure of a connection. This callback should not expect any parameters.|

#### Callback Arguments
|Key |Data Type|Description|
|-----|----|----|
|error|string|An error message if there was a problem or null if it was successful|

#### Example Code:
```squirrel
    connection.close(function(){
        server.log("Connection closed");
    }.bindenv(this));
```

### getSocket()
Returns the socket id of the socket.

#### Example Code:
```squirrel
    server.log("This connection is using socket " + connection.getSocket());
```

### isEstablished()
The *isEstablished()* method returns a Boolean. Returns true if a connection is established otherwise returns false.

#### Example Code:
```squirrel
    server.log(connection.isEstablished() ? "established" : "not established");
```

### onReceive(*[cb]*)
Passes the callback function to called when data is received.

| Key | Data Type |Required|Default Value |Description |
| ----- | -------- | ----|----|  --------------- |
|cb|function|Yes|N/A|Callback function to called in the event of data being received |


#### Callback Arguments
|Key |Data Type|Description|
|-----|----|----|
|error|string|An error message if there was a problem or null if it was successful|
|data|blob|The data that was received|

#### Example Code:
```squirrel
    connection.onReceive(function(error, data) {
        server.log("Received data: " + data);
    }.bindenv(this));
```

### onDisconnect(*[cb]*)
Passes the callback function to be called when the connection disconnects.

| Key | Data Type |Required|Default Value |Description |
| ----- | -------- | ----|----|  --------------- |
|cb|Function|Yes|N/A|Callback function to called in the event of a disconnection |

#### Callback Arguments
|Key |Data Type|Description|
|-----|----|----|
|error|string|An error message if there was a problem or null if it was successful|


#### Example Code:
```squirrel
    connection.onDisconnect(function(error) {
        server.log("Disconnected")
    }.bindenv(this));
```

### onClose(*[cb]*)
Passes the callback function to be called when the connection is fully closed and removed from the system.

| Key | Data Type |Required|Default Value |Description |
| ----- | -------- | ----|----|  --------------- |
|cb|Function|Yes|N/A|Callback function to called. Has no parameters.  |


#### Example Code:
```squirrel
    connection.onClose(function() {
        server.log("Closed")
    }.bindenv(this));
```

### transmit(*transmitData[, cb]*)

*transmit* is called within a connection. Transmitting the data through the socket.  

| Key | Data Type |Required|Default Value |Description |
| ----- | -------- | ----|----|  --------------- |
|transmitData|blob or string|Yes|N/A|The data to be transmitted |
|cb|Function|No|null|The call back is called in the event of data being successfully sent or in the event of a timeout.|

#### Callback Arguments
|Key |Data Type|Description|
|-----|----|----|
|error|string|An error message if there was a problem or null if it was successful|

#### Example Code  
```squirrel
    local data = "Hello, world.";
    connection.transmit(data, function(error) {
        if (error) return server.error(error);
        server.log("Sent successful");
    }.bindenv(this));
```

### receive(*[cb]*)
The *receive* function is an alternative to *onReceive* which will temporarily override *onReceive*. It receives the next available data packet on the connection.

| Key | Data Type |Required|Default Value |Description |
| ----- | -------- | ----|----|  --------------- |
|cb|Function|No|null|The received data is passed into the callback|

#### Callback Arguments
|Key |Data Type|Description|
|-----|----|----|
|error|string|An error message if there was a problem or null if it was successful|
|data|blob| The data that was received|

#### Example Code  
```squirrel
    // waits for data to be received
    connection.receive(function(error, data) {
        server.log("Received data: " + data);
    }.bindenv(this));
```
#### Callback Arguments
|Key |Data Type|Description|
|-----|----|----|
|error|string|An error message if there was a problem or null if it was successful|
|data|blob|The data that was received|


# W5500.Driver
The W5500.Driver class is responsible for a number of lower levels operations. Including opening and closing sockets, setting memory, getting memory, setting and getting socket modes. The other classes W5500 and W5500.Connection will make use of these functions.

## License
The Wiznet code is licensed under the [MIT License](./LICENSE).

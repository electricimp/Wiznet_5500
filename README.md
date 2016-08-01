#Wiznet_5500

Connection API for Wiznet chip [W5500](http://wizwiki.net/wiki/lib/exe/fetch.php?media=products:w5500:w5500_ds_v106e_141230.pdf).  The W5500 chip is a hardwired TCP/IP embedded Ethernet controller that enables easier Internet connection for embedded systems.  This library supports SPI integration with the W5500.

**To add this code to your project, copy and paste the entire contents of the** `W5500.class.nut` **file just below your library *#require* statements at the top of your device code.**

## Class Usage

### Constructor: W5500.API(*spi, interruptPin[, csPin][, resetPin]*)

The constructor takes two (required) parameters: a configured SPI object, and the interrupt pin.  The *interruptPin* can be any digital input that supports a callback on pin state change.

If you are not using the Imp005 you must pass in the digital output pin to be used as the chip select. On the Imp005 if you do not pass in a *csPin* you must configure the SPI with the *USE_CS_L* constant.

If you wish to do a hardware reset of the W5500, the digital output pin connected to the chip's reset pin can also be passed in.  Note: the W5500 datasheet recomends a hardware reset, as the software reset is not reliable.

All pins will all be configured by the constructor, however you must configure the SPI object before calling the constructor.  The W5500 supports SPI modes 0 and 3, MSB first, and the chip can support SPI speeds up to 14000.

#####Example Code:
```squirrel
// setup for an Imp 005
speed <- 4000;
spi <- hardware.spiABCD;
spi.configure(CLOCK_IDLE_LOW | MSB_FIRST | USE_CS_L, speed);

resetPin <- hardware.pinN;
interruptPin <- hardware.pinXA;

wiz <- Wiznet(spi, interruptPin, null, resetPin);
```

```squirrel
// setup for an Imp 001 or 002
speed <- 4000;
spi <- hardware.spi257
spi.configure(CLOCK_IDLE_LOW | MSB_FIRST, speed);

cs <- hardware.pin8;
resetPin <- hardware.pin9;
interruptPin <- hardware.pin1;

wiz <- Wiznet(spi, interruptPin, cs, resetPin);
```

## Class Methods

### configureNetworkSettings(*networkSettings*)
The *configureNetworkSettings()* method takes one required parameter: a *networkSettings* table.  The chart below lists the keys that can be configured with this method.

#### Network Settings
| Keys | Value Type | Descrtiption |
| ----- | --------------- | ---------------- |
| *gatewayIP* | array of integers | The IP address for the network's gateway.  For IP address 192.168.1.1 pass in array:  [192, 168, 1, 1] |
| *subnet* | array of integers | The network subnet address. For subnet address 225.225.225.0 pass in array:  [225, 225, 225, 0]  |
| *sourceAddr* | array of integers | The mac address for WizNet adapter.  For mac address 0008dc000001 pass in array [0x00, 0x08, 0xDC, 0x00, 0x00, 0x01] |
| *sourceIP* | array of integers | The IP address for WizNet adapter. For IP address 192.168.1.2 pass in array:  [192, 168, 1, 2] |

#####Example Code:
```squirrel
networkSettings <-  { "gatewayIP"  : [192, 168, 1, 1],
                      "sourceAddr" : [0x00, 0x08, 0xDC, 0x00, 0x00, 0x01],
                      "subnet"     : [255, 255, 255, 0],
                      "sourceIP"   : [192, 168, 1, 2]
                    }

wiz.configureNetworkSettings(networkSettings);
```

###setNumberOfAvailbleConnections(*numConnections*)
The *setNumberOfAvailbleConnections()* method enables interrupt and configures memory for the number of connections passed in.  This method returns the actual number of connections configured.  By default one connection is configured.  If you wish to use more than one connection configure by using this method.

#####Example Code:
```squirrel
wiz.setNumberOfAvailbleConnections(3);
```

### openConnection(*connectionSettings[, callback]*)
The *openConnection()* method takes one required parameter: a *connectionSettings* table, see the Connection Settings chart below for the required parameters, and one optional parameter: a callback function that is executed when either the *connected* or *timeout* interrupt is triggered.  The callback function takes two required parameters: error, a string if an error occured, and connection. If no error is encountered then the *error* parameter will be `null`. The *connection* parameter is a connection object that is needed to transmit data, close the connection etc.  The openConnection method also returns the connection object.

#### Connection Settings
| Key | Value Type | Description |
| ----- | -------- | --------------- |
| destIP | array of 4 integers | The destination IP address. For IP address 192.168.1.42 pass in array:  [192, 168, 1, 42] |
| destPort | array of 2 integers | The destination port.  For port 4242 pass in array: [0x10, 0x92] |

#####Example Code:
```squirrel
connectionSettings <- { "destIP"     : [192, 168, 1, 42],
                        "destPort"   : [0x10, 0x92]
                      };

wiz.openConnection(connectionSettings, function(err, connection) {
    wiz.setReceiveCallback(connection, logResponseData);
    wiz.transmit(connection, transmitData);
})
```

### closeConnection(*connection*)
The *closeConnection()* method takes one required parameter: the *connection* object on which to close the connection.

#####Example Code:
```squirrel
local connection = wiz.openConnection(connectionSettings);
wiz.closeConnection(connection);
```

### setReceiveCallback(*connection, cb*)
The *setReceiveCallback()* method takes two required parameters: a connection object, and a callback function that will be executed whenever the *data received* interrupt is triggered. The callback function takes three required parameters: error, the connection object that data was received from, and the data received.

#####Example Code:
```squirrel
function logIncommingData(error, connection, data) {
    server.log("Socket " + connection.socket + ": received data: " + data);
}

wiz.openConnection(connectionSettings, function(err, connection) {
    wiz.setReceiveCallback(connection, logIncommingData);
});
```

### setDisconnectCallback(*connection, cb*)
The *setDisconnectCallback()* method takes two required parameters: connection object, and a callback function that will be executed whenever the *diconnected* interrupt is triggered.  The callback function takes one required parameter: the connection object that disconnected.

#####Example Code:
```squirrel
local connect = wiz.openConnection(connectionSettings);

wiz.setDisconnectCallback(connect, function(connection) {
    server.log("Disconnect on socket " + connection.socket);
    // try reopening a connection after waiting 5s
    imp.wakeup(5, function() {
        connect = wiz.openConnection(connectionSettings);
    })
});
```

### transmit(*connection, transmitData[, cb]*)
The *transmit()* method takes two required parameters: the *connection* to transmit data on, and *transmitData* an blob or array containing the bytes to transmit, and one optional parameter *cb*: a callback function that is executed when the *send complete* or *timeout* interrupt is triggered.  The callback function takes two required parameters: *error*, a string if a timeout error occured, and the *connection* object.

#####Example Code:
```squirrel
transmitData1 <- [0x1A, 0x00, 0x0C, 0x00, 0x48, 0x5D, 0x24, 0x00,
                 0x16, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x22,
                 0x8E, 0x53, 0xAF, 0xF0, 0x00, 0x00, 0x00, 0x00,
                 0x00, 0x00];

transmitData2 <- [0x1A, 0x00, 0x0C, 0x00, 0x48, 0x5D, 0x24, 0x00,
                 0x16, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x84,
                 0x8A, 0x73, 0x0F, 0xF3, 0x00, 0x00, 0x00, 0x00,
                 0x00, 0x00]

wiz.openConnection(connectionSettings, function(error, connection) {
    if (error) {
        server.error(error);
        return;
    }
    wiz.transmit(connection, transmitData1, function(err, connect) {
        if (err) {
            server.error(err);
            return;
        }
        server.log("first transmision sent...");
        server.log("ok to send next transmission...");
        wiz.transmit(connect,  transmitData2, function(e, c) {
            if (e) {
                server.error(e);
                return;
            }
            server.log("second transmision sent...");
        })
    });
})
```

### receive(*connection[, cb]*)
The *receive()* method takes one required parameter: the *connection* object to check for data on, and one optional parameter *cb*: a callback function that is executed if data is received.  The callback function takes three required parameters: *error*, null or a string if an error was encountered, the *connection* object on which the data was received, and the *data* received. If a callback is passed into *receive()* it will superceede the callback set by setReceiveCallback for only this data lookup.

**Note:** There is no real need to call receive.  The interrupt and receive callback should handle incoming data.

### reset()
The *reset()* method resets all registers to their defaults.  If a reset pin is passed in a harware reset will be invoked, if no reset pin is passed in a software reset will be called.

**Note:** the datasheet for the W5500 states that software reset is buggy and should not be used.

#####Example Code:
```squirrel
wiz.reset();
```

### dataWaiting(*socket*)
The *dataWaiting()* method returns a boolean, if data is available.  It takes one required parameter: the *socket* an integer(0-3) on which to check for data.

### connectionEstablished(*socket*)
The *connectionEstablished()* method returns a boolean, if the current state of the connection is *established*.  It takes one required parameter: the *socket* an integer(0-3) on which to check the connection.


## Extended Example
```squirrel
// PASTE Wiznet.nut FILE HERE

// HARDWARE SETUP
// ---------------------------------------------
// CHIP SPI INFO
    // supports spi mode 0 and 3
    //  MSB first
    // chip should support up to 14000

speed <- 4000;
spi <- hardware.spi257
spi.configure(CLOCK_IDLE_LOW | MSB_FIRST, speed);

cs <- hardware.pin8;
resetPin <- hardware.pin9;
interruptPin <- hardware.pin1;

// NETWORK & MEMORY SETTINGS
// ---------------------------------------------

gatewayIP <- [192, 168, 1, 1];
subnetAddr <- [255, 255, 255, 0];
wnIP <- [192, 168, 1, 2];
wnHWAddr <- [0x00, 0x08, 0xDC, 0x00, 0x00, 0x01];

networkSettings <-  { "gatewayIP"  : gatewayIP,
                      "sourceAddr" : wnHWAddr,
                      "subnet"     : subnetAddr,
                      "sourceIP"   : wnIP
                    };


destIP <- [192, 168, 1, 42];
destPort <- [0x10, 0x92]; //4242

connectionSettings <- { "destIP"     : destIP,
                        "destPort"   : destPort
                      };


// RUNTIME VARIABLES / SUPPORTING FUNCTIONS
// ------------------------------------------------

transmitData <- [0x1A, 0x00, 0x0C, 0x00, 0x48, 0x5D, 0x24, 0x00,
                 0x16, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x22,
                 0x8E, 0x53, 0xAF, 0xF0, 0x00, 0x00, 0x00, 0x00,
                 0x00, 0x00];

function sendResToAgent(err, receivedConnection, response) {
    local data = (err) ? {"error" : err} : response;
    // send response to agent
    agent.send("response", data);
}

// RUNTIME CODE
// ------------------------------------------------

wiz <- Wiznet(spi, interruptPin, cs, resetPin);

wiz.configureNetworkSettings(networkSettings);
wiz.openConnection(connectionSettings, function(error, connection) {
    if (error) {
        server.error(error);
        return;
    }
    wiz.setReceiveCallback(connection, sendResToAgent);
    wiz.transmit(connection, transmitData, function(err, connect) {
        if (err) server.error(err);
    })
});
```

## License
The Wiznet code is licensed under the [MIT License](./LICENSE).
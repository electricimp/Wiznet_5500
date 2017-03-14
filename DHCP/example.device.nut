<<<<<<< Updated upstream
#include "W5500.device.nut"
=======
#include "W5500.class.nut"
#include "W5500.DHCP.class.nut"


// Initialise SPI port
interruptPin <- hardware.pinXA;
resetPin     <- hardware.pinN;
spiSpeed     <- 1000;
spi          <- hardware.spi0;
spi.configure(CLOCK_IDLE_LOW | MSB_FIRST | USE_CS_L, spiSpeed);

started <- hardware.millis();

// Initialise Wiznet and DHCP
wiz <- W5500(interruptPin, spi, null, resetPin);
dhcp <- W5500.DHCP(wiz);

// Wait for Wiznet to be ready before opening connections
server.log("Waiting for Wiznet to be ready ...");


function leaseCallback() {
    // Connection settings
    local destIP   = "192.168.50.111";
    local destPort = 60000;
    local started = hardware.millis();

    // DHCP Settings
    local sourceIP = dhcp.getIP();
    local DNS = dhcp.getDNS();   
    local subnet = dhcp.getSubnetMask(); 
    local routeraddress=dhcp.getRouterAddress();
    local leaseTime=dhcp.getLeaseTime();
    wiz.configureNetworkSettings(sourceIP, subnet, routeraddress);

    server.log("Attemping to connect...");
    
    wiz.openConnection(destIP, destPort, function(err, connection) {

        local dur = hardware.millis() - started;
        if (err) {
            server.error(format("Connection failed to %s:%d in %d ms: %s", destIP, destPort, dur, err.tostring()));
            imp.wakeup(30, function() {
                wiz.onReady(readyCb);
            })
            return;
        } 

        server.log(format("Connection to %s:%d in %d ms", destIP, destPort, dur));
        
        // Create event handlers for this connection
        connection.onReceive(receiveCb);
        connection.onDisconnect(disconnectCb);

        // Send data over the connection
        server.log("Sending ...");
        connection.transmit("SOMETHING", function(err) {
            if (err) {
                server.error("Send failed, closing: " + err);
                connection.close();
            } else {
                server.log(format("Sent successful to %s:%d", destIP, destPort));
                imp.wakeup(10, send.bindenv(this));
            }
        }.bindenv(this));
        
    }.bindenv(this));
    
}

function readyCb() {   
    dhcp.onLease(leaseCallback);
    dhcp.onError(function(err) {
        console.log(err);

    });
    dhcp.onTimeout(function(){
        console.log(err);
    });
    dhcp.init();
}

wiz.onReady(readyCb);
// Initialise SPI port
interruptPin <- hardware.pinXA;
resetPin     <- hardware.pinN;
spiSpeed     <- 1000;
spi          <- hardware.spi0;
spi.configure(CLOCK_IDLE_LOW | MSB_FIRST | USE_CS_L, spiSpeed);

started <- hardware.millis();

// Initialise Wiznet and DHCP
wiz <- W5500(interruptPin, spi, null, resetPin);
dhcp<- W5500.DHCP(wiz);

// Wait for Wiznet to be ready before opening connections
server.log("Waiting for Wiznet to be ready ...");


function receiveCb(err, response) {
    server.log(format("Catchall response from %s:%d: " + response, this.getIP(), this.getPort()));
}

function disconnectCb(err) {
    server.log(format("Disconnection from %s:%d", this.getIP(), this.getPort()));
    imp.wakeup(30, function() {
        wiz.onReady(readyCb);
    })
}

function leaseCb() {
    // Connection settings
    local destIP   = "192.168.50.111";
    local destPort = 60000;
    local started = hardware.millis();

    // DHCP Settings
    local sourceIP = dhcp.getIP();
    local DNS = dhcp.getDNS();   
    local subnet = dhcp.getSubnetMask(); 
    local routeraddress=dhcp.getRouterAddress();
    local leaseTime=dhcp.getLeaseTime();
    wiz.configureNetworkSettings(sourceIP, subnet, routeraddress);

    server.log("Attemping to connect...");
    
    wiz.openConnection(destIP, destPort, function(err, connection) {

        local dur = hardware.millis() - started;
        if (err) {
            server.error(format("Connection failed to %s:%d in %d ms: %s", destIP, destPort, dur, err.tostring()));
            imp.wakeup(30, function() {
                wiz.onReady(readyCb);
            })
            return;
        } 

        server.log(format("Connection to %s:%d in %d ms", destIP, destPort, dur));
        
        // Create event handlers for this connection
        connection.onReceive(receiveCb);
        connection.onDisconnect(disconnectCb);

        // Send data over the connection
        server.log("Sending ...");
        connection.transmit("SOMETHING", function(err) {
            if (err) {
                server.error("Send failed, closing: " + err);
                connection.close();
            } else {
                server.log(format("Sent successful to %s:%d", destIP, destPort));
                imp.wakeup(10, send.bindenv(this));
            }
        }.bindenv(this));
        
    }.bindenv(this));
    
}

function readyCb() {   
    dhcp.onLease(leaseCb);
    dhcp.onError(function(err) {
        console.log(err);
    });
    dhcp.onTimeout(function(){
        console.log(err);
    });
    dhcp.init();
}

wiz.onReady(readyCb);
>>>>>>> Stashed changes




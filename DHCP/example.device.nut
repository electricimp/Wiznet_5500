#require "W5500.device.nut:1.0.0"
#require "W5500.DHCP.device.nut:1.0.0"


function leaseCallback(error) {

	if (err) return server.error(format("DHCP lease failed: %s", err.toString()));

    // DHCP Settings
    local sourceIP = dhcp.getIP();
    local subnet = dhcp.getSubnetMask(); 
    local routeraddress = dhcp.getRouterAddress();
    wiz.configureNetworkSettings(sourceIP, subnet, routeraddress);

    // Connection settings
    local destIP   = "192.168.50.111";
    local destPort = 60000;

    server.log("Attemping to connect...");
    wiz.openConnection(destIP, destPort, function(err, connection) {

        if (err) return server.error(format("Connection failed to %s:%d: %s", destIP, destPort, err.tostring()));
        server.log(format("Connection to %s:%d", destIP, destPort));
		connection.close();
        
    }.bindenv(this));
    
}


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

// Wait for Wiznet to be ready
wiz.onReady(function() {

	// Request a DHCP lease
    dhcp.onLease(leaseCallback);
    dhcp.renewLease();

});

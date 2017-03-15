#include "../W5500.device.nut"
#include "W5500.DHCP.device.nut"
// #require "W5500.device.nut:1.0.0"
// #require "W5500.DHCP.device.nut:1.0.0"


// Initialise SPI port
interruptPin <- hardware.pinXC;
resetPin     <- hardware.pinXA;
spiSpeed     <- 1000;
spi          <- hardware.spi0;
spi.configure(CLOCK_IDLE_LOW | MSB_FIRST | USE_CS_L, spiSpeed);

// Initialise Wiznet and DHCP
wiz <- W5500(interruptPin, spi, null, resetPin);
dhcp <- W5500.DHCP(wiz);

// Wait for Wiznet to be ready
server.log("Waiting for Wiznet to be ready ...");
wiz.onReady(function() {

    dhcp.onLease(function(err) {

        if (err) return server.error(format("DHCP lease failed: %s", err.toString()));
        
        local ip = dhcp.getIP();
        if (typeof ip == "array") server.log(format("ip = %d.%d.%d.%d", ip[0], ip[1], ip[2], ip[3]))

        local subnet_mask = dhcp.getSubnetMask();
        if (typeof subnet_mask == "array") server.log(format("subnet mask = %d.%d.%d.%d", subnet_mask[0], subnet_mask[1], subnet_mask[2], subnet_mask[3]))

        local router = dhcp.getRouterAddress();
        if (typeof router == "array") server.log(format("router = %d.%d.%d.%d", router[0], router[1], router[2], router[3]))

        local dns = dhcp.getDNS();
        if (typeof dns == "array") {
            foreach (dnsi,dnse in dns) {
                server.log(format("dns%d = %d.%d.%d.%d", dnsi+1, dnse[0], dnse[1], dnse[2], dnse[3]))
            }
        }
    });

    // Request a DHCP lease
    server.log("Waiting for DHCP lease ...");
    dhcp.renewLease();

});

#include "../W5500.device.nut"
#include "W5500.DHCP.device.nut"
// #require "W5500.device.nut:1.0.0"
// #require "W5500.DHCP.device.nut:1.0.0"

const ECHO_SERVER_IP = "192.168.201.63";
const ECHO_SERVER_PORT = 60000;

// Initialise SPI port
interruptPin <- hardware.pinXC;
resetPin <- hardware.pinXA;
spiSpeed <- 1000;
spi <- hardware.spi0;
spi.configure(CLOCK_IDLE_LOW | MSB_FIRST | USE_CS_L, spiSpeed);

// Initialise Wiznet and DHCP
wiz <- W5500(interruptPin, spi, null, resetPin);
dhcp <- W5500.DHCP(wiz);
cid <- 0;

// Wait for Wiznet to be ready
server.log("Waiting for Wiznet to be ready ...");
wiz.onReady(function() {

    dhcp.onLease(function(err) {

        if (err) return server.error(format("DHCP lease failed: %s", err.toString()));

        // Output the lease data
        server.log("/--------[ LEASE ]--------\\");
        local ip = dhcp.getIP();
        if (typeof ip == "string") server.log(format("ip = %s", ip))

        local subnet_mask = dhcp.getSubnetMask();
        if (typeof subnet_mask == "string") server.log(format("subnet mask = %s", subnet_mask))

        local router = dhcp.getRouterAddress();
        if (typeof router == "string") server.log(format("router = %s", router))

        local dns = dhcp.getDNS();
        if (typeof dns == "array") {
            foreach (dnsi, dnse in dns) {
                server.log(format("dns%d = %s", dnsi + 1, dnse))
            }
        }
        server.log("sockets = " + wiz.getNumSockets());
        server.log("\\-------------------------/");

        // Use the new values to connect to the echo server
        local cid = ++cid;
        server.log(format("Connecting from %s to %s:%d with %d sockets free", ip, ECHO_SERVER_IP, ECHO_SERVER_PORT, wiz.getNumSockets()));
        wiz.configureNetworkSettings(ip, subnet_mask, router);
        wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {

            if (err) return server.error(format("Connection failed to %s:%d : %s", ECHO_SERVER_IP, ECHO_SERVER_PORT, err.tostring()));
            server.log(format("Connected to %s:%d", ECHO_SERVER_IP, ECHO_SERVER_PORT));

            // Renew the lease early
            imp.wakeup(30, dhcp.renewLease.bindenv(dhcp));

            // Keep the port active
            local mid = 0;

            function keepalive() {
                if (connection.isEstablished()) {
                    connection.transmit(format("keepalive: %d - %d", cid, ++mid));
                    imp.wakeup(5, keepalive.bindenv(this));
                } else {
                    server.log("Connection died.");
                    connection.close();
                }
            }
            imp.wakeup(0, keepalive.bindenv(this));

        }.bindenv(this));
    }.bindenv(this));

    // Request a DHCP lease
    server.log("Waiting for DHCP lease ...");
    dhcp.renewLease();

    // Log the number of free sockets over time
    function log() {
        server.log("Sockets free: " + wiz.getNumSockets());
        imp.wakeup(10, log)
    }
    log();

});

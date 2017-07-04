// MIT License
//
// Copyright 2016-2017 Electric Imp
//
// SPDX-License-Identifier: MIT
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.


#require "W5500.device.lib.nut:2.0.0"
#require "W5500.DHCP.device.lib.nut:2.0.0"

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
next_cid <- 0;

// Wait for Wiznet to be ready
server.log("Waiting for Wiznet to be ready ...");
wiz.onReady(function() {

    dhcp.onLease(function(err) {

        if (err) return server.error(format("DHCP lease failed: %s", err.toString()));

        // Renew the lease early
        imp.wakeup(30, dhcp.renewLease.bindenv(dhcp));


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
        server.log("\\-------------------------/");
        wiz.configureNetworkSettings(ip, subnet_mask, router);


        // Use the new values to connect to the echo server
        server.log(format("Connecting from %s to %s:%d with %d sockets free", ip, ECHO_SERVER_IP, ECHO_SERVER_PORT, wiz.getNumSockets()));
        wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, conn) {

            if (err) return server.error(format("Connection failed to %s:%d : %s", ECHO_SERVER_IP, ECHO_SERVER_PORT, err.tostring()));

            // Keep the port active
            local mid = 0;
            local cid = ++next_cid;
            server.log(format("Connected #%d to %s:%d", cid, ECHO_SERVER_IP, ECHO_SERVER_PORT));

            // Output a log on close
            conn.onClose(function() {
                server.log(format("Disconnected #%d from %s:%d", cid, ECHO_SERVER_IP, ECHO_SERVER_PORT));
            }.bindenv(this));

            // Send something on the line so we can be sure its actively connected
            local keepalive;
            keepalive = function() {
                if (conn.isEstablished()) {
                    conn.transmit(format("keepalive: #%d, %d", cid, ++mid));
                    server.log(format("sending on #%d, %d", cid, mid));
                    imp.wakeup(5, keepalive.bindenv(this));
                } else {
                    server.log(format("closing #%d", cid));
                    conn.close();
                }
            }
            imp.wakeup(0, keepalive.bindenv(this));

        }.bindenv(this));
    }.bindenv(this));


    // Request a DHCP lease
    server.log("Waiting for DHCP lease ...");
    dhcp.renewLease();


    // Log the number of free sockets whenever it changes
    local sockets_free = wiz.getNumSocketsFree();
    function log() {
        local new_sockets_free = wiz.getNumSocketsFree();
        if (new_sockets_free != sockets_free) {
            server.log(format("sockets free: %d of %d", new_sockets_free, wiz.getNumSockets()));
            sockets_free = new_sockets_free;
        }
        imp.wakeup(1, log)
    }
    log();

});

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

// #require "W5500.DHCP.device.nut:1.0.0"

// echo server address and port
const ECHO_SERVER_IP = "192.168.201.63";
const ECHO_SERVER_PORT = 60000;
const ECHO_MESSAGE = "Hello, world!";

class W5500_DHCP_TestCase extends ImpTestCase {

    wiz = null;
    dhcp = null;
    resetPin = hardware.pinXA;
    interruptPin = hardware.pinXC;
    spiSpeed = 1000;
    spi = hardware.spi0;


    // setup function needed to run others. Instantiates the wiznet driver.
    function setUp() {
        spi.configure(CLOCK_IDLE_LOW | MSB_FIRST | USE_CS_L, spiSpeed);
        wiz = W5500(interruptPin, spi, null, resetPin);
        dhcp = W5500.DHCP(wiz);
    }

    function testGetIPWithoutInit() {
        this.assertTrue(typeof dhcp.getIP() == "null", "getIP failed to return null");
    }

    function testGetSubnetMaskWithoutInit() {
        this.assertTrue(typeof dhcp.getSubnetMask() == "null", "getSubnetMask failed to return null");
    }

    function testGetDNSWithoutInit() {
        this.assertTrue(typeof dhcp.getDNS() == "null", "getDNS failed to return null");
    }

    function testGetLeaseTimeWithoutInit() {
        this.assertTrue(typeof dhcp.getLeaseTime() == "null", "getLeaseTime failed to return null");
    }

    function testGetRouterAddressWithoutInit() {
        this.assertTrue(typeof dhcp.getRouterAddress() == "null", "getRouterAddress failed to return null");
    }


    function testOnLease() {
        return Promise(function(resolve, reject) {

            dhcp.onLease(function(err) {

                if (err) return reject(format("onLease failed: %s", err.tostring()));

                local source_ip = dhcp.getIP();
                local subnet_mask = dhcp.getSubnetMask();
                local router = dhcp.getRouterAddress();
                local log = format("%s / %s via %s", source_ip, subnet_mask, router);
                resolve("Lease obtained: " + log);

                dhcp._isLeased = false;
            }.bindenv(this));

            // Request the lease renewal with a 20s timeout
            dhcp.renewLease(50);

        }.bindenv(this));
    }


    function testSetupConnection() {
        return Promise(function(resolve, reject) {

            dhcp.onLease(function(err) {

                if (err) return reject(format("onLease failed: %s", err.tostring()));

                // DHCP Settings
                local source_ip = dhcp.getIP();
                local subnet_mask = dhcp.getSubnetMask();
                local router = dhcp.getRouterAddress();
                local log = format("%s / %s via %s", source_ip, subnet_mask, router);
                this.info("Lease obtained: " + log);

                wiz.configureNetworkSettings(source_ip, subnet_mask, router);
                wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {

                    if (err) return reject(format("openConnection failed to %s:%d : %s", ECHO_SERVER_IP, ECHO_SERVER_PORT, err.tostring()));

                    // Send data over the connection
                    connection.transmit(ECHO_MESSAGE, function(err) {
                        connection.close();
                        if (err) return reject("Error transmitting: " + err);
                        resolve(format("Connection setup successfully to %s:%d", ECHO_SERVER_IP, ECHO_SERVER_PORT));
                    }.bindenv(this));

                }.bindenv(this));

            }.bindenv(this));

            // Request the lease renewal with a 20s timeout
            dhcp.renewLease(50);

        }.bindenv(this));
    }


}

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

// ==============================================================================
// TEST: 01.W5500.DHCP Basic Tests for W5500.DHCP Library 
// ==============================================================================

// Include Network settings for test Echo Server
@include __PATH__ + "/EchoNetworkSettings.device.nut"

const LEASE_RENEWAL_TIMEOUT_SEC = 50;

class W5500_DHCP_TestCase extends ImpTestCase {

    wiz  = null;
    dhcp = null;

    // setup function needed to run others. Instantiates the wiznet driver.
    function setUp() {
        wiz = W5500(INTERRUPT_PIN, WIZNET_SPI, null, RESET_PIN);
        dhcp = W5500.DHCP(wiz);
    }

    function testGetIPWithoutInit() {
        assertTrue(typeof dhcp.getIP() == "null", "getIP failed to return null");
    }

    function testGetSubnetMaskWithoutInit() {
        assertTrue(typeof dhcp.getSubnetMask() == "null", "getSubnetMask failed to return null");
    }

    function testGetDNSWithoutInit() {
        assertTrue(typeof dhcp.getDNS() == "null", "getDNS failed to return null");
    }

    function testGetLeaseTimeWithoutInit() {
        assertTrue(typeof dhcp.getLeaseTime() == "null", "getLeaseTime failed to return null");
    }

    function testGetRouterAddressWithoutInit() {
        assertTrue(typeof dhcp.getRouterAddress() == "null", "getRouterAddress failed to return null");
    }

    function testOnLease() {
        return Promise(function(resolve, reject) {
            dhcp.onLease(function(err) {
                if (err) return reject(format("onLease failed: %s", err.tostring()));

                local source_ip = dhcp.getIP();
                local subnet_mask = dhcp.getSubnetMask();
                local router = dhcp.getRouterAddress();
                local log = format("%s / %s via %s", source_ip, subnet_mask, router);
                return resolve("Lease obtained: " + log);

                dhcp._isLeased = false;
            }.bindenv(this));

            // Request the lease renewal specified timeout
            dhcp.renewLease(LEASE_RENEWAL_TIMEOUT_SEC);
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
                info("Lease obtained: " + log);

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

            // Request the lease renewal specified timeout
            dhcp.renewLease(LEASE_RENEWAL_TIMEOUT_SEC);

        }.bindenv(this));
    }

    function tearDown() {
        wiz = null;
        imp.enableblinkup(true);
    }

}

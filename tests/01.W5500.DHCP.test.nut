// Copyright (c) 2017 Electric Imp
// This file is licensed under the MIT License
// http://opensource.org/licenses/MIT

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

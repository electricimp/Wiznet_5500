// Copyright (c) 2017 Electric Imp
// This file is licensed under the MIT License
// http://opensource.org/licenses/MIT

// #require "W5500.DHCP.device.nut:1.0.0"

// echo server address and port
const ECHO_SERVER_IP = "173.255.197.142";
const ECHO_SERVER_PORT = 17294;
const ECHO_MESSAGE = "Hello, world!";

class W5500_DHCP_TestCase extends ImpTestCase {

    wiz = null;
    dhcp = null;
    resetPin = hardware.pinXA;
    interruptPin = hardware.pinXC;
    spiSpeed = 1000;
    spi = hardware.spi0;
    connection = null;


    // setup function needed to run others. Instantiates the wiznet driver.
    function setUp() {
        spi.configure(CLOCK_IDLE_LOW | MSB_FIRST | USE_CS_L, spiSpeed);
        wiz = W5500(interruptPin, spi, null, resetPin);
        dhcp = W5500.DHCP(wiz);
    }

    function testGetIPWithoutInit() {
        this.assertTrue(typeof dhcp.getIP() == "string");
    }

    function testGetSubnetMaskWithoutInit() {
        this.assertTrue(typeof dhcp.getSubnetMask() == "string");
    }

    function testGetDNSWithoutInit() {
        this.assertTrue(typeof dhcp.getDNS() == "string");
    }

    function testGetLeaseTimeWithoutInit() {
        this.assertTrue(typeof dhcp.getLeaseTime() == "string");
    }

    function testGetRouterAddressWithoutInit() {
        this.assertTrue(typeof dhcp.getRouterAddress() == "string");
    }

    function testOnLeaseIncorrectParameterType() {
        this.assertTrue(typeof(dhcp.onLease(32)) == "string");
    }

    function testOnLease() {
        connection = Promise(function(resolve, reject) {

            dhcp.onLease(function(err) {

                resolve("Lease Obtained");
                if (dhcp._connection) dhcp._connection.close();
                dhcp._isLeased = false;
            }.bindenv(this));
            dhcp.renewLease();

        }.bindenv(this));
        return connection;
    }

    function testSetupConnection() {
        connection = Promise(function(resolve, reject) {

            dhcp.onLease(function(err) {

                this.assertTrue(err == null, err);

                // DHCP Settings
                local sourceIP = dhcp.getIP();
                local subnet = dhcp.getSubnetMask();
                local routeraddress = dhcp.getRouterAddress();
                wiz.configureNetworkSettings(sourceIP, subnet, routeraddress);
                wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {
                    if (err) {
                        return reject("Error Opening Connection");
                    }
                    // Send data over the connection
                    connection.transmit(ECHO_MESSAGE, function(err) {
                        connection.close();
                        if (err) {
                            reject("Error Sending Data Over Connection");
                        } else {
                            resolve("Send Successfull");
                        }
                    }.bindenv(this));

                }.bindenv(this));



            }.bindenv(this));


            dhcp.renewLease();
        }.bindenv(this));
        return connection;
    }


}

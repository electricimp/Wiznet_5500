// Copyright (c) 2017 Electric Imp
// This file is licensed under the MIT License
// http://opensource.org/licenses/MIT

// echo server address and port
const SOURCE_IP = "192.168.1.185";
const SUBNET_MASK = "255.255.255.0";
const ROUTER = "192.168.1.1";
const MTIII_SERVER_IP = "192.168.1.42";
const MTIII_SERVER_PORT = 4242;
const MTIII_CONNECT_ATTEMPTS = 5;
const MTIII_REQUEST = "\x22\x1a\x5c\x75\x30\x30\x30\x30\x5c\x66\x5c\x75\x30\x30\x30\x30\xd8\x6c\x24\x5c\x75\x30\x30\x30\x30\x16\x5c\x75\x30\x30\x30\x30\x5c\x75\x30\x30\x30\x30\x5c\x75\x30\x30\x30\x30\x5c\x75\x30\x30\x30\x30\x5c\x75\x30\x30\x30\x30\x5c\x72\x23\x15\x06\xf0\x00\x00\x00\x5c\x75\x30\x30\x30\x30\x5c\x75\x30\x30\x30\x30\x5c\x75\x30\x30\x30\x30\x22";
const MTIII_RESPONSE = "\x80\x00\x0c\x00\xd8\x6c\x24\x40\x16\x00\x00\x00\x00\x00\x00\x00\x0d\x23\x15\x06\xaf\xf0\x68\x00\x68\x00\x2c\x00\x43\x66\x67\x31\x2d\x31\x35\x00\x00\x00\x00\x00\x00\x00\x00\x00\x43\x66\x67\x31\x2d\x31\x35\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x33\x31\x34\x4d\x38\x30\x38\x33\x30\x30\x31\x31\x30\x30\x37\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00";


class W5500_MicrotechIII_TestCase extends ImpTestCase {

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
        wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, ROUTER);
        wiz.setNumberOfAvailableSockets(2);
        this.info("Configured IP address to " + SOURCE_IP);
    }


    // Tests the ability of the wiznet to open and close multiple times cleanly
    // Failure to cleanly close the connection leads to the MTIII rejecting new connections
    function testConnectMultipleTimes() {
        return Promise(function(resolve, reject) {

            local connectOnce;
            connectOnce = function(attempt = 1) {
                wiz.onReady(function() {
                    wiz.openConnection(MTIII_SERVER_IP, MTIII_SERVER_PORT, function(err, connection) {

                        if (err) return reject(format("Connection attempt %d failed to %s:%d: %s", attempt, MTIII_SERVER_IP, MTIII_SERVER_PORT, err.tostring()));
                        this.info(format("Connection attempt %d successful", attempt));

                        // Now disconnect and recurse
                        connection.close(function() {
                            if (attempt >= MTIII_CONNECT_ATTEMPTS) {
                                return resolve(format("Connected to %s:%d a total of %d times", MTIII_SERVER_IP, MTIII_SERVER_PORT, MTIII_CONNECT_ATTEMPTS));
                            } else {
                                connectOnce(attempt + 1);
                            }
                        }.bindenv(this));

                    }.bindenv(this));

                }.bindenv(this));
            }

            // Start connecting sequence
            connectOnce();

        }.bindenv(this));
    }


    // Tests the Wiznet's ability to send and receive binary data to the MTIII
    function testBinaryData() {
        return Promise(function(resolve, reject) {

            wiz.onReady(function() {
                wiz.openConnection(MTIII_SERVER_IP, MTIII_SERVER_PORT, function(err, connection) {

                    if (err) return reject(format("Connection to MTIII failed: %s", err.tostring()));
                    this.info(format("Connection successful"));

                    connection.transmit(MTIII_REQUEST, function(err) {
                        if (err) return reject("Transmission failed: " + err);
                        this.info("Transmitted: " + MTIII_REQUEST.len() + " bytes");
                    }.bindenv(this));

                    connection.receive(function(err, data) {
                        this.info("Response: " + data.len() + " bytes");
                        if (data.tostring() == MTIII_RESPONSE.tostring()) {
                            resolve();
                        } else {
                            reject("Response did not match expectation");
                        }
                        connection.close();
                    }.bindenv(this))


                }.bindenv(this));

            }.bindenv(this));

        }.bindenv(this));

    }
}

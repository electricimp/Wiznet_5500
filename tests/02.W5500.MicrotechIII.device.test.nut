// MIT License
//
// Copyright 2016-2019 Electric Imp
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
// TEST: 02.W5500 MicrotechIII Tests for W5500 Library 
// 
// NOTE: This is very secific hardware, and not needed for general testing. 
// 8/30/19 - Leaving out of .impt.test config file 
// ==============================================================================

// Include Network settings for test Echo Server
@include __PATH__ + "/MicroTechIIINetworkSettings.device.nut"

// MTIII Settings
const MTIII_CONNECT_ATTEMPTS     = 5;
const MTIII_RESPONSE_TIMEOUT_SEC = 2;

MTIII_SEQUENCE <- [
    // Init
    "\x0e\x00\x04\x00\xd8\x6c\x81\x00\x16\x00\x00\x00\x00\x00", // Request
    "\x12\x00\x04\x00\xd8\x6c\x81\x40\x16\x00\x00\x00\x00\x00\x01\x00\x00\x04", // Response

    // Read the serial number
    "\x1a\x00\x0c\x00\xd8\x6c\x24\x00\x16\x00\x00\x00\x00\x00\x04\x23\x89\xd1\xea\x5c\x00\x00\x00\x00\x00\x00", // Request
    128, // Response length

    // Read the config code 1-15
    "\x1a\x00\x0c\x00\xd8\x6c\x24\x00\x16\x00\x00\x00\x00\x00\x0d\x23\x15\x06\xaf\xf0\x00\x00\x00\x00\x00\x00", // Request
    128, // Response length

    // Read the config code 16-30
    "\x1a\x00\x0c\x00\xd8\x6c\x24\x00\x16\x00\x00\x00\x00\x00\x0d\x23\x89\xda\xaf\xf0\x00\x00\x00\x00\x00\x00", // Request
    128, // Response length

    // Fake an error, should timeout
    "timeout", // Request
    null // Response

];

class W5500_MicrotechIII_TestCase extends ImpTestCase {

    wiz = null;

    // Setup function needed to run others. Instantiates the wiznet driver.
    function setUp() {
        // Initialize Wiznet
        wiz = W5500(INTERRUPT_PIN, WIZNET_SPI, null, RESET_PIN);
        
        wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, ROUTER);
        wiz.setNumberOfAvailableSockets(2);
        info("Configured IP address to " + SOURCE_IP);
    }

    // Tests the ability of the wiznet to open and close multiple times cleanly
    // Failure to cleanly close the connection leads to the MTIII rejecting new connections
    function _testConnectMultipleTimes() {
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

                    // Local function for sending and waiting for response
                    local sendAndReceive = function(send, receive, done) {

                        // Transmit the packet to the microtech
                        connection.transmit(send, function(err) {
                            if (err) return done(err, send, null);
                            this.info("Transmitted: " + send.len() + " bytes");
                        }.bindenv(this));

                        // Wait for a response from the microtech
                        connection.receive(function(err, data) {
                            if (err) return done(err, send, null);
                            this.info("Received: " + data.len() + " bytes");
                            done(err, send, data);
                        }.bindenv(this), MTIII_RESPONSE_TIMEOUT_SEC);

                    }

                    // Track where we are up to in the sequence
                    local pos = 0;
                    local runSequence;
                    runSequence = function(done) {
                        local send = MTIII_SEQUENCE[pos];
                        local receive = MTIII_SEQUENCE[pos+1];
                        sendAndReceive(send, receive, function(err, sent, received) {

                            // Check the errors
                            if (sent == "timeout" && err != "timeout") {
                                return done("Expected timeout error");
                            } else if (sent != "timeout" && err != null) {
                                return done(err);
                            }

                            // Check the values
                            if (receive == null || (typeof receive == "integer" && received.len() == receive) || received.tostring() == receive.tostring()) {
                                // Continue
                            } else {
                                return done("Response didn't match");
                            }

                            // Move onto the next one
                            pos += 2;
                            if (pos < MTIII_SEQUENCE.len()) {
                                imp.wakeup(0, function() {
                                    runSequence(done);
                                }.bindenv(this));
                            } else {
                                done(null);
                            }
                        }.bindenv(this));
                    }

                    // Start running the sequence
                    runSequence(function(err) {
                        connection.close();
                        if (err) reject(err);
                        else resolve();
                    }.bindenv(this));

                }.bindenv(this));

            }.bindenv(this));

        }.bindenv(this));

    }
}

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
// TEST: 03.W5500 Listener Tests for W5500 Library 
//
// NOTE: Cannot successfully open a connection to the Source IP, so I have 
// not gotten this test to pass. 
// 8/30/19 - Leaving out of .impt.test config file 
// ==============================================================================

// Include Network settings for test Echo Server
@include __PATH__ + "/EchoNetworkSettings.device.nut"

const LISTEN_PORT = 80;

class W5500_Listener_TestCase extends ImpTestCase {

    wiz = null;

    // setup function needed to run others. Instantiates the wiznet driver.
    function setUp() {
        // Initialize Wiznet
        wiz = W5500(INTERRUPT_PIN, WIZNET_SPI, null, RESET_PIN);

        wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
        wiz.setNumberOfAvailableSockets(3);
        info("Configured IP address to " + SOURCE_IP);
    }

    // Tests the Wiznet's ability to listen on a socket and take connections
    function testOneListener() {
        return Promise(function(resolve, reject) {

            wiz.onReady(function() {

                // Setup the listener waiting for a connection
                info(format("Listening on %s:%d", SOURCE_IP, LISTEN_PORT));
                wiz.listen(LISTEN_PORT, function(err, conn1) {

                    if (err) return reject(format("Failed to listen on port %d: ", LISTEN_PORT, err.tostring()));
                    local ip = conn1.getIP();
                    local port = conn1.getPort();
                    this.info(format("Connection established from %d.%d.%d.%d:%d", ip[0], ip[1], ip[2], ip[3], port));

                    local data_collected = false;

                    conn1.onReceive(function(err, data) {
                        this.info("Data: " + data.len() + " bytes");
                        data_collected = true;
                    }.bindenv(this));

                    conn1.onClose(function() {
                        if (data_collected) resolve();
                        else reject("No data collected");
                    }.bindenv(this));

                    info("transmitting Hello! on conn1...")
                    conn1.transmit("Hello!\r\n");

                }.bindenv(this));


                info("Opening up a connection to myself...");
                // Setup the client to make a connection
                wiz.openConnection(SOURCE_IP, LISTEN_PORT, function(err, conn2) {

                    if (err) return reject(format("Connection failed to %s:%d: %s", SOURCE_IP, LISTEN_PORT, err.tostring()));
                    
                    info(format("Connection to listener successful. Transmitting message..."));
                    conn2.transmit("Hello to you!", function(err) {
                        conn2.close();
                    }.bindenv(this))

                }.bindenv(this));


            }.bindenv(this));

        }.bindenv(this));

    }
}
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
// TEST: 00.W5500 Basic Tests for W5500 Library 
// ==============================================================================

// Include Network settings for test Echo Server
@include __PATH__ + "/EchoNetworkSettings.device.nut"

class W5500_TestCase extends ImpTestCase {

    _wiz = null;

    // Test Helpers
    function _checkAvailSockets(numSockets) {
        local availSockets = _wiz.setNumberOfAvailableSockets(numSockets);

        // Check that sockets are all in stack
        local s = 0;
        for (local x = numSockets - 1; x >= 0; x--) {
            // Check socket in right place in stack
            assertTrue(availSockets[x] == s, "incorrect socket location is stack");
            // Check that socket has been allocated correct amount of memory
            // Checking both memory for transmission and receceivng
            assertTrue(_wiz._driver.getMemory("tx", s) == 16384 / numSockets, "incorrect transmission memory");
            assertTrue(_wiz._driver.getMemory("rx", s) == 16384 / numSockets, "incorrect reception memory");
            s += 1;
        }
    }

    // Setup instantiates the wiznet driver, and waits til onReady callback
    // triggers
    function setUp() {
        // Initialize Wiznet
        _wiz = W5500(INTERRUPT_PIN, WIZNET_SPI, null, RESET_PIN);

        // Make sure Wiznet Completes initialization before 
        // starting tests
        return Promise(function(resolve, reject) {
            _wiz.onReady(function() {
                return resolve("Setup complete");
            }.bindenv(this));

            imp.wakeup(5, function() {
                return reject("Timeout");
            }.bindenv(this));
        }.bindenv(this));
    }

    function testConfigureNetworkSettings() {
        // Check that the is_ready throws the correct error
        // Check that configureNetworkSettings sets registers correctly

        _wiz._isReady = false;
        try {
            _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
        } catch (error) {
            local expectedError = "Wiznet driver not ready"
            assertEqaul(error, expectedError, "configureNetworkSettings did not throw expected error: " + error);
        }
        _wiz._isReady = true;

        // Checking all the registers are changed
        _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);

        // Source IP
        local source = split(SOURCE_IP, ".");
        assertTrue(source[0].tointeger() == _wiz._driver.readReg(W5500_SOURCE_IP_ADDR_0, W5500_COMMON_REGISTER), "incorrect register source ip[0]");
        assertTrue(source[1].tointeger() == _wiz._driver.readReg(W5500_SOURCE_IP_ADDR_1, W5500_COMMON_REGISTER), "incorrect register source ip[1]");
        assertTrue(source[2].tointeger() == _wiz._driver.readReg(W5500_SOURCE_IP_ADDR_2, W5500_COMMON_REGISTER), "incorrect register source ip[2]");
        assertTrue(source[3].tointeger() == _wiz._driver.readReg(W5500_SOURCE_IP_ADDR_3, W5500_COMMON_REGISTER), "incorrect register source ip[3]");

        // Subnet Mack
        local subnet_mask = split(SUBNET_MASK, ".");
        assertTrue(subnet_mask[0].tointeger() == _wiz._driver.readReg(W5500_SUBNET_MASK_ADDR_0, W5500_COMMON_REGISTER), "incorrect register subnet[0]");
        assertTrue(subnet_mask[1].tointeger() == _wiz._driver.readReg(W5500_SUBNET_MASK_ADDR_1, W5500_COMMON_REGISTER), "incorrect register subnet[1]");
        assertTrue(subnet_mask[2].tointeger() == _wiz._driver.readReg(W5500_SUBNET_MASK_ADDR_2, W5500_COMMON_REGISTER), "incorrect register subnet[2]");
        assertTrue(subnet_mask[3].tointeger() == _wiz._driver.readReg(W5500_SUBNET_MASK_ADDR_3, W5500_COMMON_REGISTER), "incorrect register subnet[3]");

        // Gateway IP
        local gateway = split(GATEWAY_IP, ".");
        assertTrue(gateway[0].tointeger() == _wiz._driver.readReg(W5500_GATEWAY_ADDR_0, W5500_COMMON_REGISTER), "incorrect register gateway ip[0]");
        assertTrue(gateway[1].tointeger() == _wiz._driver.readReg(W5500_GATEWAY_ADDR_1, W5500_COMMON_REGISTER), "incorrect register gateway ip[1]");
        assertTrue(gateway[2].tointeger() == _wiz._driver.readReg(W5500_GATEWAY_ADDR_2, W5500_COMMON_REGISTER), "incorrect register gateway ip[2]");
        assertTrue(gateway[3].tointeger() == _wiz._driver.readReg(W5500_GATEWAY_ADDR_3, W5500_COMMON_REGISTER), "incorrect register gateway ip[3]");

        return "ConfigureNetworkSettings test successful";
    }

    function testSetNumberOfAvailableSockets() {
        // Testing that the sockets are being filled correctly

        // Test for different total number of sockets
        _checkAvailSockets(4);
        _checkAvailSockets(8);
        _checkAvailSockets(1);

        // Test 0 sockets
        local numSockets = _wiz.setNumberOfAvailableSockets(0);
        assertEqual(0, numSockets[0], "socket 0 not only socket in socket stack");

        return "SetNumberOfAvailableSockets test successful";
    }

    function testOpenConnection() {
        // Tests openConnection conditions so that it opens after the wiznet 
        // has been setup sending to an INVALID port so that it will not connect
        return Promise(function(resolve, reject) {

            local badPort = 65535;
            if (badPort == ECHO_SERVER_PORT) badport += 1;

            // Check for _isReady
            _wiz._isReady = false;
            try {    
                _wiz.openConnection(ECHO_SERVER_IP, badPort);
                return reject("openConnection ran with an unready wiznet");
            } catch (error) {
                if (error != "Wiznet driver not ready") {
                    return reject("openConnection ran with an unready wiznet");
                }
            }
            _wiz._isReady = true;

            // Check for too few inputs
            _wiz.setNumberOfAvailableSockets(4);
            try {
                _wiz.openConnection(null, null, null, null);
                return reject("openConnection ran with incorrect number of parameters");
            } catch (error) {
                if (error != W5500_ERR_INVALID_PARAMETERS) {
                    return reject("openConnection ran with incorrect number of parameters");
                }
            }

            // Test a valid entry but pointing to an invalid port
            _wiz.openConnection(ECHO_SERVER_IP, badPort, function(error, connection) {
                if (connection == null) {
                    return resolve("OpenConnection test successful: Rejected bad port");
                } else {
                    connection.close();
                    return reject("Accepted connection on a bad port");
                }
            }.bindenv(this));

        }.bindenv(this));

    }

    function test_addrToIP() {

        // Try an array of incorrect length
        local badArray = [1, 1, 1];
        try {
            _wiz._driver._addrToIP(badArray);
            assertTrue(false, "incorrect ip address input (array) was successfully made into an address");
        } catch (error) {
            assertTrue(error == "Bad IP address", "incorrect ip address input (array) was successfully made into an address");
        }

        // try a bad string not containg the correct ip format
        local badstring = "192.192.192";
        try {
            _wiz._driver._addrToIP(badArray);
            assertTrue(false, "incorrect ip address input (string) was successfully made into an address");
        } catch (error) {
            assertTrue(error == "Bad IP address", "incorrect ip address input (string) was successfully made into an address");
        }

        // try a correct array
        local goodArray = [192, 2, 44, 234];
        local output = _wiz._driver._addrToIP(goodArray);
        assertDeepEqual(output, [192, 2, 44, 234], "correct ip address input (array) was unsuccessfully made into an address");

        // try a correct string
        local goodString = "197.4.7.235";
        output = _wiz._driver._addrToIP(goodString);
        assertDeepEqual(output, [197, 4, 7, 235], "correct ip address input (string) was unsuccessfully made into an address");
    
        return "_addrToIP test successful";
    }

    function test_addrToMac() {

        // Try an array of incorrect length
        local badArray = [1, 1, 1];
        try {
            _wiz._driver._addrToMac(badArray);
            this.assertTrue(false, "Bad mac address array was rejected");
        } catch (error) {
            this.assertTrue(error == "Bad Mac address", "Bad mac address array was rejected");
        }

        // Try a bad string
        local badstring = ".92.92.92.92";
        try {
            _wiz._driver._addrToMac(badArray);
            this.assertTrue(false, "Bad mac address array was rejected");
        } catch (error) {
            this.assertTrue(error == "Bad Mac address", "Bad mac address string was rejected");
        }

        // Try a correct array
        local goodArray = [12, 12, 44, 34, 20, 20];
        local output = _wiz._driver._addrToMac(goodArray);
        this.assertDeepEqual(output, [12, 12, 44, 34, 20, 20], "Good mac address array was converted badly");

        // Try a correct string
        local goodString = "0008dc000001";
        output = _wiz._driver._addrToMac(goodString);
        this.assertDeepEqual(output, [0x00, 0x08, 0xdc, 0x00, 0x00, 0x01], "Good mac address string was converted badly");

        return "_addrToMac test successful";
    }

    // Transmitting data to a server and receiving it correctly
    // Verifies function transmit
    // Verifies function received
    // Verifies a successful open connection
    function testTransmitReceiveString() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {
                // Making sure that the callback is not called unless wiznet is ready
                _wiz.setNumberOfAvailableSockets(4);
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
                info("Configured IP address to " + SOURCE_IP);

                _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {
                    if (err) {
                        return reject(format("openConnection failed to %s:%d : %s", ECHO_SERVER_IP, ECHO_SERVER_PORT, err.tostring()));
                    }
                    
                    try {
                        connection.transmit(ECHO_MESSAGE, function(err) {
                            if (err) return reject("Error transmitting: " + err);
                        }.bindenv(this));
                    } catch (err) {
                        connection.close();
                        return reject("Exception while transmitting: " + err);
                    }

                    connection.receive(function(err, data) {
                        connection.close();

                        // Check that the data type received was expected and that the data was what we sent
                        if (typeof(data) != "blob") return reject("data type was not a blob");
                        if (ECHO_MESSAGE != data.tostring()) return reject("data received was not the same that was transmitted");
                        
                        return resolve("TransmitReceiveString test successful");
                    }.bindenv(this));
                }.bindenv(this));
            }

            // Initialize Wiznet
            _wiz.onReady(readyCb.bindenv(this));
        }.bindenv(this));
    }

    // Tests the onreceive intterupt callback as a method of receiving data instead of 
    // the single use receive() mehtod
    function testTransmitOnReceive() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {
                // Making sure that the callback is not called unless wiznet is ready
                _wiz.setNumberOfAvailableSockets(4);
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
                info("Configured IP address to " + SOURCE_IP);

                _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {
                    if (err != null || connection == null) {
                        return reject(format("openConnection failed to %s:%d : %s", ECHO_SERVER_IP, ECHO_SERVER_PORT, err.tostring()));
                    }

                    // Define the callback for receiving data in the connection
                    connection.onReceive(function(err, data) {
                        connection.close();
                        // Ensure data received is what we expected
                        if (typeof data != "blob") return reject("data type was not a blob");
                        if (ECHO_MESSAGE != data.tostring()) return reject("data received was not the same that was transmitted");
                        return resolve("TransmitOnReceive test successful");
                    }.bindenv(this));

                    try {
                        connection.transmit(ECHO_MESSAGE, function(err) {
                            if (err) return reject("Error transmitting: " + err);
                        }.bindenv(this));
                    } catch (err) {
                        return reject("Exception while transmitting: " + err);
                    }
                }.bindenv(this));
            }

            // Initialize Wiznet
            _wiz.onReady(readyCb.bindenv(this));
        }.bindenv(this));
    }

    // Transmititting data to a server when the packet is null
    function testTransmitNull() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {
                // Making sure that the callback is not called unless wiznet is ready
                _wiz.setNumberOfAvailableSockets(4);
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
                info("Configured IP address to " + SOURCE_IP);

                _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {
                    if (err) {
                        return reject(format("openConnection failed to %s:%d : %s", ECHO_SERVER_IP, ECHO_SERVER_PORT, err.tostring()));
                    }

                    // Send data over the connection
                    try {
                        connection.transmit(null, function(err) {
                            if (err) {
                                connection.close();
                                return reject("Error transmitting: " + err);
                            }
                        }.bindenv(this));
                    } catch (error) {
                        connection.close();
                        if (error != "transmit() requires a string or blob") return reject("transmit didn't reject a null data packet");
                        resolve("TransmitNull test successful");
                    }
                }.bindenv(this));
            }

            // Initialize Wiznet
            _wiz.onReady(readyCb.bindenv(this));
        }.bindenv(this));
    }

    // Opening 1 more connection then the maximum allowed
    function testAllSocketsInUse() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {

                _wiz.setNumberOfAvailableSockets(1);
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
                info("Configured IP address to " + SOURCE_IP);

                _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, conn1) {
                    if (err) {
                        return reject(err);
                    } else {
                        _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, conn2) {
                            if (err) {
                                if (err != W5500_ERR_CANNOT_CONNECT_SOCKETS_IN_USE) return reject(err);
                                return resolve("AllSocketsInUse test successful");
                            } else {
                                conn2.close();
                                return reject("Failed to reject second openConnection request");
                            }
                        }.bindenv(this));
                        conn1.close();
                    }
                }.bindenv(this));
            }

            // Initialise Wiznet
            _wiz.onReady(readyCb.bindenv(this));
        }.bindenv(this));
    }

    // Test the close function
    function testClose() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {
                // Set so there is only a single socket
                _wiz.setNumberOfAvailableSockets(1);
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
                info("Configured IP address to " + SOURCE_IP);
                
                _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {
                    if (err) {
                        return reject(format("openConnection failed to %s:%d : %s", ECHO_SERVER_IP, ECHO_SERVER_PORT, err.tostring()));
                    } else {
                        connection.onClose(function() {
                            // Check that the number of sockets is back what is needed
                            if (_wiz.getNumSocketsFree() >= 1) {
                                return resolve("Close test successful");
                            } else {
                                return reject("Wasn't left with at least one available socket");
                            }
                        }.bindenv(this));
                        connection.close();
                    }
                }.bindenv(this));
            }

            // Initialize Wiznet
            _wiz.onReady(readyCb.bindenv(this));
        }.bindenv(this));
    }

    // Opening a connection right after closing one fails
    function testOpenClose() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {
                // Set so there is only a single socket
                _wiz.setNumberOfAvailableSockets(1);
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
                info("Configured IP address to " + SOURCE_IP);

                _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, conn1) {
                    if (err) {
                        return reject(format("openConnection failed to %s:%d : %s", ECHO_SERVER_IP, ECHO_SERVER_PORT, err.tostring()));
                    } else {
                        info("First connection opened");

                        conn1.onClose(function() {
                            // Open a second connection once it is closed
                            info("First connection closed, opening second");

                            _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, conn2) {
                                if (err) {
                                    return reject(format("openConnection failed to %s:%d : %s", ECHO_SERVER_IP, ECHO_SERVER_PORT, err.tostring()));
                                } else {
                                    conn2.close();
                                    return resolve("Single connection opened, closed and reopened.");
                                }
                            }.bindenv(this));
                        }.bindenv(this));

                        conn1.close();
                    }
                }.bindenv(this));
            }

            // Initialise Wiznet
            _wiz.onReady(readyCb.bindenv(this));
        }.bindenv(this));
    }

    function tearDown() {
        _wiz = null;
        imp.enableblinkup(true);
    }

}

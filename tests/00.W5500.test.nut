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

// echo server address and port
const SOURCE_IP = "192.168.201.185";
const SUBNET_MASK = "255.255.255.0";
const GATEWAY_IP = "192.168.201.1";
const ECHO_SERVER_IP = "192.168.201.63";
const ECHO_SERVER_PORT = 60000;
const ECHO_MESSAGE = "Hello, world!";

class W5500_TestCase extends ImpTestCase {

    _wiz = null;
    _resetPin = hardware.pinXA;
    _interruptPin = hardware.pinXC;
    _spiSpeed = 1000;
    _spi = hardware.spi0;

    // setup function needed to run others. Instantiates the wiznet driver.
    function setUp() {

        _spi.configure(CLOCK_IDLE_LOW | MSB_FIRST | USE_CS_L, _spiSpeed);

        // Initialise Wiznet
        _wiz = W5500(_interruptPin, _spi, null, _resetPin);

        // will not finish until the onReady event is called
        return Promise(function(resolve, reject) {
            _wiz.onReady(function() {
                resolve("Setup complete");
            }.bindenv(this));

            imp.wakeup(5, function() {
                reject("Timeout");
            }.bindenv(this));

        }.bindenv(this));
    }


    // testing configureNetworkSettings
    function testConfigureNetworkSettings() {

        local test;

        // check that the is_ready throws the correct error
        // check that configureNetworkSettings sets registers correctly
        _wiz._isReady = false;
        try {
            _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
        } catch (error) {
            this.assertTrue(error == "Wiznet driver not ready", "configureNetworkSettings ran with wiznet not yet ready");
        }
        _wiz._isReady = true;

        // checking all the registers are changed.
        _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);

        // source ip
        local source = split(SOURCE_IP, ".");
        this.assertTrue(source[0].tointeger() == _wiz._driver.readReg(W5500_SOURCE_IP_ADDR_0, W5500_COMMON_REGISTER), "incorrect register source ip[0]");
        this.assertTrue(source[1].tointeger() == _wiz._driver.readReg(W5500_SOURCE_IP_ADDR_1, W5500_COMMON_REGISTER), "incorrect register source ip[1]");
        this.assertTrue(source[2].tointeger() == _wiz._driver.readReg(W5500_SOURCE_IP_ADDR_2, W5500_COMMON_REGISTER), "incorrect register source ip[2]");
        this.assertTrue(source[3].tointeger() == _wiz._driver.readReg(W5500_SOURCE_IP_ADDR_3, W5500_COMMON_REGISTER), "incorrect register source ip[3]");

        // subnet
        local subnet_mask = split(SUBNET_MASK, ".");
        this.assertTrue(subnet_mask[0].tointeger() == _wiz._driver.readReg(W5500_SUBNET_MASK_ADDR_0, W5500_COMMON_REGISTER), "incorrect register subnet[0]");
        this.assertTrue(subnet_mask[1].tointeger() == _wiz._driver.readReg(W5500_SUBNET_MASK_ADDR_1, W5500_COMMON_REGISTER), "incorrect register subnet[1]");
        this.assertTrue(subnet_mask[2].tointeger() == _wiz._driver.readReg(W5500_SUBNET_MASK_ADDR_2, W5500_COMMON_REGISTER), "incorrect register subnet[2]");
        this.assertTrue(subnet_mask[3].tointeger() == _wiz._driver.readReg(W5500_SUBNET_MASK_ADDR_3, W5500_COMMON_REGISTER), "incorrect register subnet[3]");

        // gatewayIP
        local gateway = split(GATEWAY_IP, ".");
        this.assertTrue(gateway[0].tointeger() == _wiz._driver.readReg(W5500_GATEWAY_ADDR_0, W5500_COMMON_REGISTER), "incorrect register gateway ip[0]");
        this.assertTrue(gateway[1].tointeger() == _wiz._driver.readReg(W5500_GATEWAY_ADDR_1, W5500_COMMON_REGISTER), "incorrect register gateway ip[1]");
        this.assertTrue(gateway[2].tointeger() == _wiz._driver.readReg(W5500_GATEWAY_ADDR_2, W5500_COMMON_REGISTER), "incorrect register gateway ip[2]");
        this.assertTrue(gateway[3].tointeger() == _wiz._driver.readReg(W5500_GATEWAY_ADDR_3, W5500_COMMON_REGISTER), "incorrect register gateway ip[3]");

    }


    // testing that the sockets are being filled correctly
    function testSetNumberOfAvailableSockets() {
        // local test ;
        local testTest = function(sockets) {
            local test = _wiz.setNumberOfAvailableSockets(sockets);
            // check that sockets are all in stack
            local s = 0;
            for (local x = sockets - 1; x >= 0; x--) {
                // check socket in right place in stack
                this.assertTrue(test[x] == s, "incorrect socket location is stack");
                // check that socket has been allocated correct amount of memory
                // checking both memory for transmission and receceivng
                this.assertTrue(_wiz._driver.getMemory("tx", s) == 16384 / sockets, "incorrect transmission memory");
                this.assertTrue(_wiz._driver.getMemory("rx", s) == 16384 / sockets, "incorrect reception memory");
                s = s + 1;
            }
        };

        // test for different total number of sockets
        testTest(4);
        testTest(8);
        testTest(1);

        // below test the 0 case
        // where a single socket should be put in even if input is 0
        local test0 = _wiz.setNumberOfAvailableSockets(0);
        this.assertTrue(test0[0] == 0, "socket 0 not only socket in socket stack");
    }



    // tests openConnection conditions so that it opens after the wiznet has been setup
    // sending to an INVALID port so that it will not connect
    function testOpenConnection() {
        return Promise(function(resolve, reject) {
            // check for _isReady
            _wiz._isReady = false;
            try {
                _wiz.openConnection(ECHO_SERVER_IP, 65535);
                reject("openConnection ran with an unready wiznet");
            } catch (error) {
                if (error != "Wiznet driver not ready") {
                    reject("openConnection ran with an unready wiznet");
                }
            }
            _wiz._isReady = true;

            // check for too few inputs
            _wiz.setNumberOfAvailableSockets(4);
            try {
                _wiz.openConnection(null, null, null, null);
                reject("openConnection ran with incorrect number of parameters");
            } catch (error) {
                if (error != W5500_ERR_INVALID_PARAMETERS) {
                    reject("openConnection ran with incorrect number of parameters");
                }
            }

            // test a valid entry but pointing to an invalid port
            _wiz.openConnection(ECHO_SERVER_IP, 65535, function(error, connection) {
                if (connection == null) {
                    return resolve("Rejected bad port");
                } else {
                    connection.close();
                    return reject("Accepted connection on a bad port");
                }
            }.bindenv(this));

        }.bindenv(this));

    }


    // Test the address to ip
    function test_addrToIP() {
        // try an array of incorrect length
        local badArray = [1, 1, 1];
        try {
            _wiz._driver._addrToIP(badArray);
            this.assertTrue(false, "incorrect ip address input (array) was successfully made into an address");
        } catch (error) {
            this.assertTrue(error == "Bad IP address", "incorrect ip address input (array) was successfully made into an address");
        }

        // try a bad string not containg the correct ip format
        local badstring = "192.192.192";
        try {
            _wiz._driver._addrToIP(badArray);
            this.assertTrue(false, "incorrect ip address input (string) was successfully made into an address");
        } catch (error) {
            this.assertTrue(error == "Bad IP address", "incorrect ip address input (string) was successfully made into an address");
        }

        // try a correct array
        local goodArray = [192, 2, 44, 234];
        local output = _wiz._driver._addrToIP(goodArray);
        this.assertDeepEqual(output, [192, 2, 44, 234], "correct ip address input (array) was unsuccessfully made into an address");

        // try a correct string
        local goodString = "197.4.7.235";
        output = _wiz._driver._addrToIP(goodString);
        this.assertDeepEqual(output, [197, 4, 7, 235], "correct ip address input (string) was unsuccessfully made into an address");
    }



    // Test the addr to mac address function
    function test_addrToMac() {
        // try an array of incorrect length
        local badArray = [1, 1, 1];
        try {
            _wiz._driver._addrToMac(badArray);
            this.assertTrue(false, "Bad mac address array was rejected");
        } catch (error) {
            this.assertTrue(error == "Bad Mac address", "Bad mac address array was rejected");
        }

        // try a bad string
        local badstring = ".92.92.92.92";
        try {
            _wiz._driver._addrToMac(badArray);
            this.assertTrue(false, "Bad mac address array was rejected");
        } catch (error) {
            this.assertTrue(error == "Bad Mac address", "Bad mac address string was rejected");
        }

        // try a correct array
        local goodArray = [12, 12, 44, 34, 20, 20];
        local output = _wiz._driver._addrToMac(goodArray);
        this.assertDeepEqual(output, [12, 12, 44, 34, 20, 20], "Good mac address array was converted badly");

        // try a correct string
        local goodString = "0008dc000001";
        output = _wiz._driver._addrToMac(goodString);
        this.assertDeepEqual(output, [0x00, 0x08, 0xdc, 0x00, 0x00, 0x01], "Good mac address string was converted badly");

    }

    // Transmitting data to a server and receiving it correctly
    // Verifies function transmit
    // Verifies function received
    // Verifies a successful open connection
    function testTransmitReceiveString() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {
                // making sure that the callback is not called unless wiznet is ready
                _wiz.setNumberOfAvailableSockets(4);
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
                this.info("Configured IP address to " + SOURCE_IP);
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
                        // check that the data type received was expected and that the data was what we sent
                        connection.close();
                        if (typeof(data) != "blob") return reject("data type was not a blob");
                        if (ECHO_MESSAGE != data.tostring()) return reject("data received was not the same that was transmitted");
                        resolve();
                    }.bindenv(this));
                }.bindenv(this));
            }

            // Initialise Wiznet
            _wiz.onReady(readyCb.bindenv(this));
        }.bindenv(this));
    }


    // tests the onreceive intterupt callback as a method of receiving data instead of the single use receive() mehtod
    function testTransmitOnReceive() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {
                // making sure that the callback is not called unless wiznet is ready
                _wiz.setNumberOfAvailableSockets(4);
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
                this.info("Configured IP address to " + SOURCE_IP);
                _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {

                    if (err != null || connection == null) {
                        return reject(format("openConnection failed to %s:%d : %s", ECHO_SERVER_IP, ECHO_SERVER_PORT, err.tostring()));
                    }

                    // define the callback for receiving data in the connection
                    connection.onReceive(function(err, data) {

                        // ensuring data received is what we expected
                        connection.close();
                        if (typeof data != "blob") return reject("data type was not a blob");
                        if (ECHO_MESSAGE != data.tostring()) return reject("data received was not the same that was transmitted");
                        return resolve();

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

            // Initialise Wiznet
            _wiz.onReady(readyCb.bindenv(this));
        }.bindenv(this));
    }


    // transmititting data to a server when the packet is null
    function testTransmitNull() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {
                // making sure that the callback is not called unless wiznet is ready
                _wiz.setNumberOfAvailableSockets(4);
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
                this.info("Configured IP address to " + SOURCE_IP);
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
                        resolve();
                    }
                }.bindenv(this));
            }

            // Initialise Wiznet
            _wiz.onReady(readyCb.bindenv(this));
        }.bindenv(this));
    }


    // opening 1 more connection then the maximum allowed
    function testAllSocketsInUse() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {

                _wiz.setNumberOfAvailableSockets(1);
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
                this.info("Configured IP address to " + SOURCE_IP);

                _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, conn1) {
                    if (err) {
                        return reject(err);
                    } else {

                        _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, conn2) {
                            if (err) {
                                if (err != W5500_CANNOT_CONNECT_SOCKETS_IN_USE) return reject(err);
                                return resolve();
                            } else {
                                conn2.close();
                                return reject("Failed to reject second openConnection request")
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



    // test the close function
    function testClose() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {
                // set so there is only a single socket
                _wiz.setNumberOfAvailableSockets(1);
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
                this.info("Configured IP address to " + SOURCE_IP);
                _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {
                    if (err) {
                        return reject(format("openConnection failed to %s:%d : %s", ECHO_SERVER_IP, ECHO_SERVER_PORT, err.tostring()));
                    } else {
                        connection.onClose(function() {
                            // check that the number of sockets is back what is needed
                            if (_wiz.getNumSocketsFree() >= 1) {
                                return resolve();
                            } else {
                                return reject("Wasn't left with at least one available socket");
                            }
                        }.bindenv(this));
                        connection.close();
                    }
                }.bindenv(this));
            }

            // Initialise Wiznet
            _wiz.onReady(readyCb.bindenv(this));
        }.bindenv(this));
    }




    // opening a connection right after closing one fails
    function testOpenClose() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {
                // set so there is only a single socket
                _wiz.setNumberOfAvailableSockets(1);
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
                this.info("Configured IP address to " + SOURCE_IP);
                _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, conn1) {
                    if (err) {
                        return reject(format("openConnection failed to %s:%d : %s", ECHO_SERVER_IP, ECHO_SERVER_PORT, err.tostring()));
                    } else {
                        this.info("First connection opened");

                        conn1.onClose(function() {
                            // open a second connection once it is closed
                            this.info("First connection closed, opening second");
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

}

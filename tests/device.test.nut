
// echo server address and port
const SOURCE_IP = "192.168.1.37";
const SUBNET_MASK = "255.255.255.0";
const GATEWAY_IP = "192.168.1.1";
const ECHO_SERVER_IP = "192.168.1.38";
const ECHO_SERVER_PORT = 60000;
const ECHO_MESSAGE = "Hello, world!";

class DeviceTestCase extends ImpTestCase {

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
                resolve();
            }.bindenv(this));

            imp.wakeup(5, function() {
                reject("timeout...");
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
            // server.log("error occured");
            this.assertTrue(error == "Wiznet driver not ready", "configureNetworkSettings ran with wiznet not yet ready");
        }
        _wiz._isReady = true;
        _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);

        // checking all the registers are changed.

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
            local test = _wiz._driver.setNumberOfAvailableSockets(sockets);
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
        local test0 = _wiz._driver.setNumberOfAvailableSockets(0);
        this.assertTrue(test0[0] == 0, "socket 0 not only socket in socket stack");
    }

    // tests openConnection conditions so that it opens after the wiznet has been setup
	// sending to an INVALID port so that it will not connect
    function testOpenConnection() {
		// check for _isReady
        _wiz._isReady = false;
        try {
			_wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT+5);
        } catch (error) {
            this.assertTrue(error == "Wiznet driver not ready", "openConnection ran with an unready wiznet");
        }
        // check for too few inputs
        _wiz._isReady = true;
        try {
			_wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT+5);
        } catch (error) {
            this.assertTrue(error == W5500_INVALID_PARAMETERS, "openConnection ran with incorrect number of parameters");
        }
        // test a sucessful case
        _wiz._isReady = true;
		_wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT+5, function(err, connection) {
            server.log("connection" + connection);
        });


    }


    // Test the address to ip
    function test_addrToIP() {
        // try an array of incorrect length
        local badArray = [1, 1, 1];
        try {
            _wiz._driver._addrToIP(badArray);
        } catch (error) {
            this.assertTrue(error = "Bad IP address", "incorrect ip adress input (array) was successuly made into an adress");
        }

        // try a bad string not containg the correct ip format
        local badstring = "192.192.192";
        try {
            _wiz._driver._addrToIP(badArray);
        } catch (error) {
            this.assertTrue(error = "Bad IP address", "incorrect ip adress input (string) was successuly made into an adress");
        }

        // try a correct array
        local goodArray = [192, 2, 44, 234];
        local output = _wiz._driver._addrToIP(goodArray);
        this.assertDeepEqual(output, [192, 2, 44, 234], "correct ip adress input (array) was unsuccessuly made into an adress");

        // try a correct string
        local goodString = "197.4.7.235";
        output = _wiz._driver._addrToIP(goodString);
        this.assertDeepEqual(output, [197, 4, 7, 235], "correct ip adress input (string) was unsuccessuly made into an adress");
    }



    // Test the addr to mac adress function
    function test_addrToMac() {
        // try an array of incorrect length
        local badArray = [1, 1, 1];
        try {
            _wiz._driver._addrToMac(badArray);
        } catch (error) {
            // server.log("error occured from bad array")
            this.assertTrue(error = "Bad Mac address", "incorrect mac adress input (array) was successuly made into an adress");
        }

        // try a bad string
        local badstring = ".92.92.92.92";
        try {
            _wiz._driver._addrToMac(badArray);
        } catch (error) {
            // server.log("error occured from bad string");
            this.assertTrue(error = "Bad Mac address", "incorrect mac adress input (string) was successuly made into an adress");
        }

        // try a correct array
        local goodArray = [12, 12, 44, 34, 20, 20];
        local output = _wiz._driver._addrToMac(goodArray);
        this.assertDeepEqual(output, [12, 12, 44, 34, 20, 20], "correct mac adress input (array) was unsuccessuly made into an adress");

        // try a correct string
        local goodString = "0008dc000001";
        output = _wiz._driver._addrToMac(goodString);
        this.assertDeepEqual(output, [0x00, 0x08, 0xdc, 0x00, 0x00, 0x01], "correct mac adress input (string) was unsuccessuly made into an adress");

    }

    // Transmitting data to a server and receiving it correctly
    // Verifies function transmit
    // Verifies function received
    // Verifies a successful open connection
    function testTransmitReceiveString() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {
                // making sure that the callback is not called unless wiznet is ready
                this.assertTrue(_wiz._isReady == true, "wiznet not ready when the callback began");
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
                _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {
                    if (err) {
                        return reject("error");
                    }
                    try {
                        connection.transmit(ECHO_MESSAGE, function(err) {
                            if (err) {
                                return reject("error");
                            } else {}
                        }.bindenv(this));
                    } catch (error) {
                        return reject("transmission error");
                    }
                    connection.receive(function(err, data) {
                        // check that the data type received was expected and that the data was what we sent
                        this.assertEqual(typeof(data), "blob", "data type was not a blob");
                        this.assertEqual(ECHO_MESSAGE, data.tostring(), "data received was not the same that was transmitted");
                        resolve();
                    }.bindenv(this));
                }.bindenv(this));
            }

            // Initialise Wiznet
            _wiz = W5500(_interruptPin, _spi, null, _resetPin);
            _wiz.onReady(readyCb.bindenv(this));
        }.bindenv(this));
    }


    // tests the onreceive intterupt callback as a method of receiving data instead of the single use receive() mehtod
    function testTransmitOnReceive() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {
				// making sure that the callback is not called unless wiznet is ready
				this.assertTrue(_wiz._isReady == true, "wiznet not ready when the callback began");
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
				_wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {
					if (err != null || connection == null) {
						return reject("openConnection failed: " + err);
					}
					// define the callback for receiving data in the connection
					connection.onReceive(function(err, data) {
						// ensuring data received is what we expected
						this.assertEqual(typeof(data), "blob", "data type was not a blob");
						this.assertEqual(ECHO_MESSAGE, data.tostring(), "data received was not the same that was transmitted");
						return resolve();
					}.bindenv(this));

					if (err) {
						return reject("error");
					}
					try {
						connection.transmit(ECHO_MESSAGE, function(err) {
							if (err) {
								server.error("Send failed, closing: " + err);
								return reject("error");
							}
						}.bindenv(this));
					} catch (error) {
						return reject("transmission error");
					}
				}.bindenv(this));
			}

            // Initialise Wiznet
            _wiz = W5500(_interruptPin, _spi, null, _resetPin);
            _wiz.onReady(readyCb.bindenv(this));
        }.bindenv(this));
    }


    // transmititting data to a server when the packet is null
    function testTransmitNull() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {
				// making sure that the callback is not called unless wiznet is ready
				this.assertTrue(_wiz._isReady == true, "wiznet not ready when the callback began");
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
				_wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {
					if (err) {
						return reject("openConnection failed: " + err);
					}
					// Send data over the connection
					try {
						connection.transmit(null, function(err) {
							if (err) {
								connection.close();
								return reject("error transmission failed");
							}
						}.bindenv(this));
					} catch (error) {
						connection.close();
						this.assertTrue(error == "transmit() requires a string or blob", "transmit didn't reject a null data packet");
						resolve();
					}
				}.bindenv(this));
			}

            // Initialise Wiznet
            _wiz = W5500(_interruptPin, _spi, null, _resetPin);
            _wiz.onReady(readyCb.bindenv(this));
        }.bindenv(this));
    }


    // opening 1 more connection then the maximum allowed
    function testAllSocketsInUse() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {
                _wiz._driver._availableSockets = _wiz._driver.setNumberOfAvailableSockets(1);
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
                _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {
                    if (err) {
                        return reject("openConnection failed: " + err);
                    }
                }.bindenv(this));
                _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {
                    if (err) {
                        this.assertTrue(err == W5500_CANNOT_CONNECT_SOCKETS_IN_USE);
                        return resolve();
                    }
                }.bindenv(this));
            }

            // Initialise Wiznet
            _wiz = W5500(_interruptPin, _spi, null, _resetPin);
            _wiz.onReady(readyCb.bindenv(this));
        }.bindenv(this));
    }



    // test the close function
    function testClose() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {
                // set so there is only a single socket
                _wiz._driver._availableSockets = _wiz._driver.setNumberOfAvailableSockets(1);
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
                _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {
                    if (err) {
                        return reject("openConnection failed: " + err);
                    } else {
                        connection.close(function() {
                            // check that the number of sockets is back what is needed
                            this.assertTrue(_wiz._driver._availableSockets.len() == 1);
                            return resolve();
                        }.bindenv(this));
                    }
                }.bindenv(this));
            }

            // Initialise Wiznet
            _wiz = W5500(_interruptPin, _spi, null, _resetPin);
            _wiz.onReady(readyCb.bindenv(this));
        }.bindenv(this));
    }




    // opening a connection right after closing one fails
    function testOpenClose() {
        return Promise(function(resolve, reject) {
            local readyCb = function() {
                // set so there is only a single socket
                _wiz._driver._availableSockets = _wiz._driver.setNumberOfAvailableSockets(1);
                server.log("last available socket " + _wiz._driver._availableSockets[0]);
                _wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
                _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {
                    if (err) {
                        return reject("openConnection failed: " + err);
                    } else {
                        connection.close(function() {
                            //open a connection once it is closed
                            _wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {
                                if (err) {
                                    return reject("openConnection failed: " + err);
                                } else {
                                    this.assertTrue(true);
                                    return resolve();
                                }
                            }.bindenv(this));
                        }.bindenv(this));

                    }

                }.bindenv(this));

            }

            // Initialise Wiznet
            _wiz = W5500(_interruptPin, _spi, null, _resetPin);
            _wiz.onReady(readyCb.bindenv(this));
        }.bindenv(this));
    }

}

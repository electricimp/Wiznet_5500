// Copyright (c) 2017 Electric Imp
// This file is licensed under the MIT License
// http://opensource.org/licenses/MIT

// echo server address and port
const SOURCE_IP = "192.168.1.185";
const SUBNET_MASK = "255.255.255.0";
const ROUTER = "192.168.1.1";
const LISTEN_PORT = 80;

class W5500_Listener_TestCase extends ImpTestCase {

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
        wiz.setNumberOfAvailableSockets(3);
        this.info("Configured IP address to " + SOURCE_IP);
    }


    // Tests the Wiznet's ability to listen on a socket and take connections
    function testOneListener() {
        return Promise(function(resolve, reject) {

            wiz.onReady(function() {

                // Setup the listener waiting for a connection
                this.info(format("Listening on %s:%d", SOURCE_IP, LISTEN_PORT));
                wiz.listen(LISTEN_PORT, function(err, conn1) {

                    if (err) return reject(format("Failed to listen on port %d: ", LISTEN_PORT, err.tostring()));
                    local ip = conn1.getIP();
                    local port = conn1.getPort();
                    this.info(format("Connection established from %d.%d.%d.%d:%d", ip[0], ip[1], ip[2], ip[3], port));

                    local data_collected = false;
                    conn1.transmit("Hello!\r\n");

                    conn1.onReceive(function(err, data) {
                        this.info("Data: " + data.len() + " bytes");
                        data_collected = true;
                    }.bindenv(this));

                    conn1.onClose(function() {
                        if (data_collected) resolve();
                        else reject("No data collected");
                    }.bindenv(this));

                }.bindenv(this));


                // Setup the client to make a connection
                wiz.openConnection(SOURCE_IP, LISTEN_PORT, function(err, conn2) {

                    if (err) return reject(format("Connection failed to %s:%d: %s", SOURCE_IP, LISTEN_PORT, err.tostring()));
                    this.info(format("Connection to listener successful"));
                    conn2.transmit("Hello to you!", function(err) {
                        conn2.close();
                    }.bindenv(this))

                }.bindenv(this));


            }.bindenv(this));

        }.bindenv(this));

    }
}

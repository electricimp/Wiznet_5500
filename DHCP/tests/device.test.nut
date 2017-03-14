// echo server address and port
const SOURCE_IP = "192.168.1.37";
const SUBNET_MASK = "255.255.255.0";
const GATEWAY_IP = "192.168.1.1";
const ECHO_SERVER_IP = "192.168.1.3";
const ECHO_SERVER_PORT = 60000;
const ECHO_MESSAGE = "Hello, world!";

class DeviceTestCase extends ImpTestCase {

    wiz = null;
    DHCP = null;
	resetPin     = hardware.pinN;
	interruptPin = hardware.pinXA;
	spiSpeed = 1000;
	spi = hardware.spi0;
    connection = null;
    

    // setup function needed to run others. Instantiates the wiznet driver.
    function setUp() {
        spi.configure(CLOCK_IDLE_LOW | MSB_FIRST | USE_CS_L, spiSpeed);
        wiz = W5500(interruptPin, spi, null, resetPin);    
        DHCP = W5500.DHCP(wiz);   
    }

    function testGetIPWithoutInit() {
        this.assertTrue(typeof DHCP.getIP() == "string");
    }

    function testGetSubnetMaskWithoutInit() {
        this.assertTrue(typeof DHCP.getSubnetMask() == "string");
    }

    function testGetDNSWithoutInit() {
        this.assertTrue(typeof DHCP.getDNS() == "string");
    }

    function testGetLeaseTimeWithoutInit() {
        this.assertTrue(typeof DHCP.getLeaseTime() == "string");
    }

    function testGetRouterAddressWithoutInit() {
        this.assertTrue(typeof DHCP.getRouterAddress() == "string");
    }

    function testOnLeaseIncorrectParameterType() {
        this.assertTrue(typeof(DHCP.onLease(32)) == "string");
    }

    function testOnLease() {
        connection = Promise(function(resolve, reject) {
            
            DHCP.onLease(function(err) {  
                            
                resolve("Lease Obtained");
                DHCP._connection.close();
                DHCP._isLeased = false;
            }.bindenv(this));
            DHCP.renewLease();

        }.bindenv(this));
        return connection;
    }

    function testSetupConnection() {
        connection = Promise(function(resolve, reject) { 
                      
            DHCP.onLease(function() {  
                
                // DHCP Settings
                local sourceIP = DHCP.getIP();
                local DNS = DHCP.getDNS();   
                local subnet = DHCP.getSubnetMask(); 
                local routeraddress = DHCP.getRouterAddress();
                local leaseTime = DHCP.getLeaseTime();
                wiz.configureNetworkSettings(sourceIP, subnet, routeraddress);
                wiz.openConnection(ECHO_SERVER_IP, ECHO_SERVER_PORT, function(err, connection) {
                    if (err) {
                        reject("Error Opening Connection");
                    } 
                    // Send data over the connection
                    connection.transmit("SOMETHING", function(err) {
                        if (err) {
                            reject("Error Sending Data Over Connection");
                            connection.close();
                        } else {
                            resolve("Send Successfull");
                            connection.close();
                        }
                    }.bindenv(this));

                }.bindenv(this));
                
               

            }.bindenv(this));
            
            
            DHCP.renewLease();
        }.bindenv(this));
        return connection;
    }


}






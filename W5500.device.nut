// Copyright (c) 2016-2017 Electric Imp
// This file is licensed under the MIT License
// http://opensource.org/licenses/MIT

// BLOCK SELECT BITS
const W5500_COMMON_REGISTER = 0x00;
const W5500_S0_REGISTER = 0x08;
const W5500_S0_TX_BUFFER = 0x10;
const W5500_S0_RX_BUFFER = 0x18;
const W5500_S1_REGISTER = 0x28;
const W5500_S1_TX_BUFFER = 0x30;
const W5500_S1_RX_BUFFER = 0x38;
const W5500_S2_REGISTER = 0x48;
const W5500_S2_TX_BUFFER = 0x50;
const W5500_S2_RX_BUFFER = 0x58;
const W5500_S3_REGISTER = 0x68;
const W5500_S3_TX_BUFFER = 0x70;
const W5500_S3_RX_BUFFER = 0x78;
const W5500_S4_REGISTER = 0x88;
const W5500_S4_TX_BUFFER = 0x90;
const W5500_S4_RX_BUFFER = 0x98;
const W5500_S5_REGISTER = 0xA8;
const W5500_S5_TX_BUFFER = 0xB0;
const W5500_S5_RX_BUFFER = 0xB8;
const W5500_S6_REGISTER = 0xC8;
const W5500_S6_TX_BUFFER = 0xD0;
const W5500_S6_RX_BUFFER = 0xD8;
const W5500_S7_REGISTER = 0xE8;
const W5500_S7_TX_BUFFER = 0xF0;
const W5500_S7_RX_BUFFER = 0xF8;

// READ/WRITE BIT
const W5500_READ_COMMAND = 0x00;
const W5500_WRITE_COMMAND = 0x04;

// SPI OPPERATION MODE
const W5500_VARIABLE_DATA_LENGTH = 0x00;
const W5500_FIXED_DATA_LENGTH_1 = 0x01;
const W5500_FIXED_DATA_LENGTH_2 = 0x02;
const W5500_FIXED_DATA_LENGTH_4 = 0x03;

// COMMON REGISTERS OFFSET ADDRESSES
// MR
const W5500_MODE = 0x0000;

// GWR
const W5500_GATEWAY_ADDR_0 = 0x0001;
const W5500_GATEWAY_ADDR_1 = 0x0002;
const W5500_GATEWAY_ADDR_2 = 0x0003;
const W5500_GATEWAY_ADDR_3 = 0x0004;

// SUBR
const W5500_SUBNET_MASK_ADDR_0 = 0x0005;
const W5500_SUBNET_MASK_ADDR_1 = 0x0006;
const W5500_SUBNET_MASK_ADDR_2 = 0x0007;
const W5500_SUBNET_MASK_ADDR_3 = 0x0008;

// SHAR
const W5500_SOURCE_HW_ADDR_0 = 0x0009;
const W5500_SOURCE_HW_ADDR_1 = 0x000A;
const W5500_SOURCE_HW_ADDR_2 = 0x000B;
const W5500_SOURCE_HW_ADDR_3 = 0x000C;
const W5500_SOURCE_HW_ADDR_4 = 0x000D;
const W5500_SOURCE_HW_ADDR_5 = 0x000E;

// SIPR
const W5500_SOURCE_IP_ADDR_0 = 0x000F;
const W5500_SOURCE_IP_ADDR_1 = 0x0010;
const W5500_SOURCE_IP_ADDR_2 = 0x0011;
const W5500_SOURCE_IP_ADDR_3 = 0x0012;

// INTLEVEL
const W5500_INTERRUPT_LOW_LEVEL_TIMER_0 = 0x0013;
const W5500_INTERRUPT_LOW_LEVEL_TIMER_1 = 0x0014;

// IR
const W5500_INTERRUPT = 0x0015;
// IMR
const W5500_INTERRUPT_MASK = 0x0016;

// SIR
const W5500_SOCKET_INTERRUPT = 0x0017;
// SIMR
const W5500_SOCKET_INTERRUPT_MASK = 0x0018;

// RTR
const W5500_RETRY_TIME_0 = 0x0019;
const W5500_RETRY_TIME_1 = 0x001A;
// RCR
const W5500_RETRY_COUNT = 0x001B;

// PHYSICAL CONFIG
const W5500_PHYSICAL_CONFIG = 0x002E;

// VERSION
const W5500_CHIP_VERSION = 0x0039;


// SOCKET REGISTER OFFSET ADDRESSES
const W5500_SOCKET_MODE = 0x0000;
const W5500_SOCKET_COMMAND = 0x0001;
const W5500_SOCKET_N_INTERRUPT = 0x0002;
const W5500_SOCKET_STATUS = 0x0003;

const W5500_SOCKET_SOURCE_PORT_0 = 0x0004;
const W5500_SOCKET_SOURCE_PORT_1 = 0x0005;

const W5500_SOCKET_DEST_HW_ADDR_0 = 0x0006;
const W5500_SOCKET_DEST_HW_ADDR_1 = 0x0007;
const W5500_SOCKET_DEST_HW_ADDR_2 = 0x0008;
const W5500_SOCKET_DEST_HW_ADDR_3 = 0x0009;
const W5500_SOCKET_DEST_HW_ADDR_4 = 0x000A;
const W5500_SOCKET_DEST_HW_ADDR_5 = 0x000B;

const W5500_SOCKET_DEST_IP_ADDR_0 = 0x000C;
const W5500_SOCKET_DEST_IP_ADDR_1 = 0x000D;
const W5500_SOCKET_DEST_IP_ADDR_2 = 0x000E;
const W5500_SOCKET_DEST_IP_ADDR_3 = 0x000F;

const W5500_SOCKET_DEST_PORT_0 = 0x0010;
const W5500_SOCKET_DEST_PORT_1 = 0x0011;

const W5500_SOCKET_RX_BUFFER_SIZE = 0x001E;
const W5500_SOCKET_TX_BUFFER_SIZE = 0x001F;

// SOCKET TX FREE SIZE REGISTER (Sn_TX_FREE_SIZE)
const W5500_SOCKET_TX_SIZE_R1 = 0x0020;
const W5500_SOCKET_TX_SIZE_R2 = 0x0021;

// SOCKET TX READ POINTER
const W5500_SOCKET_TX_RP_R1 = 0x0022;
const W5500_SOCKET_TX_RP_R2 = 0x0023;

// SOCKET TX WRITE POINTER
const W5500_SOCKET_TX_WP_R1 = 0x0024;
const W5500_SOCKET_TX_WP_R2 = 0x0025;

// SOCKET RX RECEIVED SIZE REGISTER (Sn_RX_RSR)
const W5500_SOCKET_RX_SIZE_R1 = 0x0026;
const W5500_SOCKET_RX_SIZE_R2 = 0x0027;

// SOCKET RX READ POINTER (Sn_RX_RD)
const W5500_SOCKET_RX_RP_R1 = 0x0028;
const W5500_SOCKET_RX_RP_R2 = 0x0029;

// SOCKET N INTERRUPT MASK (Sn_IMR)
const W5500_SOCKET_N_INTERRUPT_MASK = 0x002C;

// MODES
const W5500_SW_RESET = 0x80;
const W5500_WAKE_ON_LAN = 0x20;
const W5500_PING_BLOCK = 0x10;
const W5500_PPPoE = 0x08;
const W5500_FORCE_ARP = 0x01;
const W5500_DEFAULT_MODE = 0x00;

// SOCKET MODES (Sn_MR)
const W5500_SOCKET_MODE_MULTI = 0x80;
const W5500_SOCKET_MODE_BROADCAST_BLOCKING = 0x40;
const W5500_SOCKET_MODE_NO_DELAY_ACK = 0x20;
const W5500_SOCKET_MODE_UNICAST_BLOCKING = 0x10;
const W5500_SOCKET_MODE_CLOSED = 0x00;
const W5500_SOCKET_MODE_TCP = 0x01;
const W5500_SOCKET_MODE_UDP = 0x02;
const W5500_SOCKET_MODE_MACRAW = 0x03;

// SOCKET COMMANDS (Sn_CR)
const W5500_SOCKET_OPEN = 0x01;
const W5500_SOCKET_LISTEN = 0x02;
const W5500_SOCKET_CONNECT = 0x04;
const W5500_SOCKET_DISCONNECT = 0x08;
const W5500_SOCKET_CLOSE = 0x10;
const W5500_SOCKET_SEND = 0x20;
const W5500_SOCKET_SEND_MAC = 0x21;
const W5500_SOCKET_SEND_KEEP = 0x22;
const W5500_SOCKET_RECEIVE = 0x40;

// SOCKET STATUS (Sn_SR)
const W5500_SOCKET_STATUS_CLOSED = 0x00;
const W5500_SOCKET_STATUS_INIT = 0x13;
const W5500_SOCKET_STATUS_LISTEN = 0x14;
const W5500_SOCKET_STATUS_ESTABLISHED = 0x17;
const W5500_SOCKET_STATUS_CLOSE_WAIT = 0x1C;
const W5500_SOCKET_STATUS_UDP = 0x22;
const W5500_SOCKET_STATUS_MACRAW = 0x42;
const W5500_SOCKET_STATUS_SYNSENT = 0x15;
const W5500_SOCKET_STATUS_SYNRECV = 0x16;
const W5500_SOCKET_STATUS_FIN_WAIT = 0x18;
const W5500_SOCKET_STATUS_CLOSING = 0x1A;
const W5500_SOCKET_STATUS_TIME_WAIT = 0x1B;
const W5500_SOCKET_STATUS_LAST_ACK = 0x1D;

// INTERRUPT TYPES
const W5500_CONFLICT_INT_TYPE = 0x80;
const W5500_UNREACH_INT_TYPE = 0x40;
const W5500_PPPoE_INT_TYPE = 0x20;
const W5500_MAGIC_PACKET_TYPE = 0x10;
const W5500_NONE_INT_TYPE = 0x00;

// SOCKET INTERRUPTS
const W5500_DISABLE_SOCKET_INTERRUPTS = 0x00;
const W5500_S0_INTERRUPT = 0x01;
const W5500_S1_INTERRUPT = 0x02;
const W5500_S2_INTERRUPT = 0x04;
const W5500_S3_INTERRUPT = 0x08;
const W5500_S4_INTERRUPT = 0x10;
const W5500_S5_INTERRUPT = 0x20;
const W5500_S6_INTERRUPT = 0x40;
const W5500_S7_INTERRUPT = 0x80;

// SOCKET INTERRUPT TYPES
const W5500_SEND_COMPLETE_INT_TYPE = 0x10;
const W5500_TIMEOUT_INT_TYPE = 0x08;
const W5500_DATA_RECEIVED_INT_TYPE = 0x04;
const W5500_DISCONNECTED_INT_TYPE = 0x02;
const W5500_CONNECTED_INT_TYPE = 0x01;

// Socket states
enum W5500_SOCKET_STATES {
    CLOSED,
    INIT,
    CONNECTING,
    ESTABLISHED,
    DISCONNECTING
}

// Error messages
const W5500_INVALID_PARAMETERS = "Provide 'ip', 'port', 'mode' and a callback.";
const W5500_CANNOT_CONNECT_STILL_CLEANING = "Cannot open a connection. Still cleaning up.";
const W5500_CANNOT_CONNECT_SOCKETS_IN_USE = "Cannot open a connection. All connection sockets in use.";
const W5500_CANNOT_CONNECT_TIMEOUT = "Connection timeout";
const W5500_TRANSMIT_TIMEOUT = "Transmit timeout";

// Miscellaneous constants
const W5500_TRANSMIT_TIMEOUT = 8;

// ==============================================================================
// CLASS: W5500
// ==============================================================================

class W5500 {

    static VERSION = "1.0.0";

    _driver = null;
    _interruptPin = null;
    _isReady = false; // set to true once the driver is loaded and connection to chip made
    _readyCb = null; // callback for when isReady becomes true
    _networkSettings = null;

    // TODO: implement this
    _autoRetry = false;


    // ***************************************************************************
    // Constructor
    // Returns: null
    // Parameters:
    //      spi - configured spi bus, chip supports spi mode 0 or 3
    //      cs(optional) -  chip select pin, pass in if not using imp005
    //      interruptPin - inerrupt pin
    //      reset(optional) - reset pin
    // ***************************************************************************
    constructor(interruptPin, spi, csPin = null, resetPin = null, autoRetry = false) {

        // Initialise the driver and close any stale connections
        _driver = W5500.Driver(spi, csPin, resetPin);
        _driver.init(function() {

            // Configure interrupts
            _driver.setInterrupt(W5500_CONFLICT_INT_TYPE);
            _driver.clearInterrupt();
            _driver.clearSocketInterrupts();
            _interruptPin = interruptPin.configure(DIGITAL_IN_PULLUP, _interruptHandler.bindenv(this));

            // Let the caller know the device is ready
            _isReady = true;
            if (_readyCb != null) imp.wakeup(0, _readyCb);
        }.bindenv(this));
    }

    // ***************************************************************************
    // onReady
    // Returns: this
    // Parameters:
    // cb -  function to be called in the even _isReady is true
    // ***************************************************************************
    function onReady(cb) {
        local _cb = cb;
        if (_networkSettings != null) {
            // Slip the network settings into the _cb
            _cb = function() {
                configureNetworkSettings(_networkSettings.sourceIP, _networkSettings.subnetMask, _networkSettings.gatewayIP, _networkSettings.mac);
                _networkSettings = null;
                cb();
            }.bindenv(this);
        }
        if (_isReady) _cb();
        else _readyCb = _cb;
        return this;
    }

    // ***************************************************************************
    // configureNetworkSettings
    // Returns: this
    // Parameters:
    //      sourceIP    -   ip adress of the Wiznet
    //      subnetMask  -   subnetMask for the Wiznet
    //      gatewayIP   -   gatewayIP for the Wiznet
    //      mac         -   mac adress for the wiznet
    // ***************************************************************************
    function configureNetworkSettings(sourceIP, subnetMask = null, gatewayIP = null, mac = null) {
        if (_isReady) {
            if (gatewayIP) _driver.setGatewayAddr(gatewayIP);
            if (mac) _driver.setSourceHWAddr(mac);
            else _driver.setSourceHWAddr(imp.getmacaddress(), true);
            if (subnetMask) _driver.setSubnetMask(subnetMask);
            if (sourceIP) _driver.setSourceIP(sourceIP);
            _networkSettings = null;
        } else {
            _networkSettings = {};
            _networkSettings.sourceIP <- sourceIP;
            _networkSettings.subnetMask <- subnetMask;
            _networkSettings.gatewayIP <- gatewayIP;
            _networkSettings.mac <- mac;
        }

        return this;
    }

    // ***************************************************************************
    // openConnection
    // Returns: connection instance
    // Parameters:
    //      ip - the ip address of the destination
    //      port - the port of the destination
    //      mode - TCP or UDP
    //      cb - function to be called when connection successfully
    //                     established or a timeout has occurred
    // ****************************************************************************
    function openConnection(ip, port, mode = W5500_SOCKET_MODE_TCP, cb = null) {
        if (!_isReady) throw "Wiznet driver not ready";

        if ((mode == null && cb == null) || (typeof mode != "function" && cb == null)) {
            if (cb) cb(W5500_INVALID_PARAMETERS, null);
            else throw W5500_INVALID_PARAMETERS;
            return;
        } else if (typeof mode == "function") {
            cb = mode;
            mode = W5500_SOCKET_MODE_TCP;
        }

        // Create a socket, a connection object & a handler
        _driver.openConnection(ip, port, mode, cb);
    }

    // ***************************************************************************
    // reset, note this is blocking for 0.2s
    // Returns: this
    // Parameters:
    //          sw(optional) - boolean if true forces a software reset
    //          Note: Datasheet states that SW reset should not be used
    //                 on the W5500.
    // ***************************************************************************
    function reset(sw = false) {
        _driver.reset(sw);
    }


    // PRIVATE FUNCTIONS
    // ---------------------------------------------

    // ***************************************************************************
    // _interruptHandler, checks interrupt registers and calls appropriate handlers
    // Returns: null
    // Parameters: none
    // ***************************************************************************
    function _interruptHandler() {
        // Handle the main interrupt
        local interrupt = _driver.getInterruptStatus();
        if (interrupt.CONFLICT) _handleConflictInt();

        // Handle the socket interrupts
        _driver.socketInterruptHandler();
    }

    // ***************************************************************************
    // _handleConflictInt, logs conflict error message & clears interrupt
    // Returns: null
    // Parameters: none
    // ***************************************************************************
    function _handleConflictInt() {
        _driver.clearInterrupt(W5500_CONFLICT_INT_TYPE);
        server.error("Conflict interrupt occured. Please check IP source and destination addresses");
    }

}


// ==============================================================================
// CLASS: W5500.Driver
// ==============================================================================

class W5500.Driver {

    // Chip can support 8 sockets
    static TOTAL_SUPPORTED_SOCKETS = 8;
    static MAX_TX_MEM_BUFFER = 16;
    static MAX_RX_MEM_BUFFER = 16;

    // CLASS VARIABLES
    _spi = null;
    _cs = null;
    _resetPin = null;

    _connections = null; // open connections
    _availableSockets = null; // array of sockets available
    _maxNoOfSockets = 0; // max number of sockets wiznet may use
    _noOfSockets = 0; // number of sockets
    _socketMemory = null; // amount of memeory each socket has

    // ***************************************************************************
    // Constructor
    // Returns: null
    // Parameters:
    //      spi - configured spi, W5500 supports spi mode 0 or 3
    //      cs(optional) - configured chip select pin
    //      reset(optional) - configured reset pin
    // ***************************************************************************
    constructor(spi, cs = null, resetPin = null) {
        _spi = spi;
        _cs = cs;
        _resetPin = resetPin;
        _connections = {};
        _availableSockets = [];

        // Check the pins
        if (resetPin) _resetPin.configure(DIGITAL_OUT, 1);

        local imp005 = ("spi0" in hardware);
        if (_cs != null) {
            _cs.configure(DIGITAL_OUT, 1);
        } else if (!imp005) {
            throw "You must pass in a chip select pin."
        }

        // Reset the hardware
        reset();

        // server.log("Wiznet chip version: " + getChipVersion());

    }

    // ***************************************************************************
    // init(cb)
    // Returns: nothing
    // Parameters:
    //        cb                        - callback function
    //        remaining(optional)       - for first time Initialise == null
    //                                  - subseuqent goes to to else
    //        closes all sockets and fires the callback when complete
    // ***************************************************************************
    function init(cb, remaining = null) {

        if (remaining == null) {

            // Initialise the number of sockets
            _maxNoOfSockets = getTotalSupportedSockets();

            // The first time through, check what needs to be dealt with
            remaining = [];
            for (local socket = 0; socket < _maxNoOfSockets; socket++) {
                local status = getSocketStatus(socket);
                if (status == W5500_SOCKET_STATUS_ESTABLISHED) {
                    sendSocketCommand(socket, W5500_SOCKET_DISCONNECT);
                    remaining.push({ socket = socket, status = status });
                } else if (status != W5500_SOCKET_STATUS_CLOSED) {
                    remaining.push({ socket = socket, status = status });
                }
            }

        } else {

            // The second+ time through
            local oldremaining = remaining;
            remaining = [];
            foreach (prev in oldremaining) {

                local socket = prev.socket;
                local prevstatus = prev.status;
                local newstatus = getSocketStatus(socket);

                if (newstatus == W5500_SOCKET_STATUS_CLOSED) {
                    sendSocketCommand(socket, W5500_SOCKET_CLOSE);
                } else {
                    remaining.push({ socket = socket, status = newstatus });
                }

            }

        }

        if (remaining.len() == 0) {

            // Set the defaults
            _availableSockets = setNumberOfAvailableSockets(4);

            // Let the sockets settle down before starting anything
            imp.wakeup(1, cb);
        } else {
            imp.wakeup(0.1, function() {
                init(cb, remaining);
            }.bindenv(this));
        }

    }


    // ***************************************************************************
    // getPhysicalLinkStatus
    // Returns: true or false
    // Parameters:
    //      none
    // ***************************************************************************
    function getPhysicalLinkStatus() {
        local status = readReg(W5500_PHYSICAL_CONFIG, W5500_COMMON_REGISTER);
        return (status & 0x01);
    }

    // ***************************************************************************
    // openConnection
    // Returns: this
    // Parameters:
    //      destIP - the ip address of the destination
    //      destPort - the port of the destination 
    //      mode - TCP or UDP
    //      sendPort(optional) - the port to send from
    //      cb - function to be called when connection successfully established 
    // ****************************************************************************
    function openConnection(destIP, destPort, mode, sendPort = null, cb = null) {

        if (typeof sendPort == "function") {
            cb = sendPort;
            sendPort = null;
        }

        // check for required parameters
        if (_availableSockets.len() == 0) {
            if (cb) return cb(W5500_CANNOT_CONNECT_SOCKETS_IN_USE, null);
            else throw W5500_CANNOT_CONNECT_SOCKETS_IN_USE;
        }

        local socket = _availableSockets.pop();
        _connections[socket] <- W5500.Connection(this, socket, destIP, destPort, mode);

        if (typeof sendPort == "integer") _connections[socket].setSourcePort(sendPort);

        _connections[socket].open(cb);

    }


    // ***************************************************************************
    // closeConnection
    // Returns: this
    // Parameters:
    //      socket              - the socket of the connection to close
    //      cb(optional)        - function
    // ***************************************************************************
    function closeConnection(socket, cb = null) {

        if (getSocketStatus(socket) == W5500_SOCKET_STATUS_ESTABLISHED) {
            sendSocketCommand(socket, W5500_SOCKET_DISCONNECT);
        } else {
            sendSocketCommand(socket, W5500_SOCKET_CLOSE);
        }

        local started = hardware.millis();
        waitForSocketStatus(socket, W5500_SOCKET_STATUS_CLOSED, function(success) {

            // Wait a second from the start
            local waitfor = 1000 - (hardware.millis() - started);
            if (waitfor < 0) waitfor = 0;

            imp.wakeup(waitfor / 1000.0, function() {

                deregisterSocket(socket);
                if (cb) cb();

            }.bindenv(this));

        }.bindenv(this));

        return this;
    }


    // ***************************************************************************
    // deregisterSocket
    // Returns:
    // Parameters:
    //      socket - the socket of the connection to deregister
    // ***************************************************************************
    function deregisterSocket(socket) {
        // Return this to the available pool
        if (_availableSockets.find(socket) == null) {
            _availableSockets.push(socket);
        }
        if (socket in _connections) {
            _connections.rawdelete(socket);
        }
    }



    // GETTERS AND SETTERS
    // ---------------------------------------------

    // ***************************************************************************
    // setMemory
    // Returns: this
    // Parameters:
    //      memory - an array of four integers with the desired transmit memory
    //               allotment for each socket (supported values are 0, 1, 2, 4, 8, 16)
    //      dir - a string containing the transmition direction, accepted values
    //            are "tx" or "rx"
    // ***************************************************************************
    function setMemory(memory, dir) {
        local memoryBufferSize = 16;
        local addr = (dir == "rx") ? W5500_SOCKET_RX_BUFFER_SIZE : W5500_SOCKET_TX_BUFFER_SIZE;

        local bits = 0x00;
        local total = 0;

        foreach (socket, mem_size in memory) {
            local socket_mem = 0x00;
            local bytes = 0;

            // adjust memory size if total memory is used up
            if (total + mem_size > memoryBufferSize) {
                mem_size = memoryBufferSize - total;
                if (mem_size < 0) mem_size = 0;
            }

            if (mem_size == memoryBufferSize) {
                bytes = 16384;
            } else if (mem_size >= 8) {
                mem_size = 8;
                bytes = 8192;
            } else if (mem_size >= 4) {
                mem_size = 4;
                bytes = 4096;
            } else if (mem_size >= 2) {
                mem_size = 2;
                bytes = 2048;
            } else if (mem_size >= 1) {
                mem_size = 1;
                bytes = 1024;
            } else {
                mem_size = 0;
                bytes = 0;
            }

            total += mem_size;
            _socketMemory[dir][socket] = bytes;
            local bsb = _getSocketRegBlockSelectBit(socket);
            writeReg(addr, bsb, mem_size);
        }
        return this;
    }


    // ***************************************************************************
    // getMemory
    // Returns: the buffer size
    // Parameters:
    //      dir - a string containing the transmition direction, accepted values
    //            are "tx" or "rx"
    // ***************************************************************************
    function getMemory(dir, socket) {
        return _socketMemory[dir][socket];
    }

    // ***************************************************************************
    // setMode
    // Returns: this
    // Parameters:
    //      mode - select mode using MODE constants or-ed together
    // ***************************************************************************
    function setMode(mode) {
        writeReg(W5500_MODE, W5500_COMMON_REGISTER, mode);
        return this;
    }

    // ***************************************************************************
    // setSocketMode
    // Returns: this
    // Parameters:
    //      socket - select the socket using an integer 0-3
    //      mode - select mode using W5500_SOCKET_MODE constant
    // ***************************************************************************
    function setSocketMode(socket, mode) {
        local bsb = _getSocketRegBlockSelectBit(socket)
        writeReg(W5500_SOCKET_MODE, bsb, mode);
        return this;
    }

    // ***************************************************************************
    // setGatewayAddr
    // Returns: this
    // Parameters:
    //      addr - an array of four integers with the gateway IP address
    // ***************************************************************************
    function setGatewayAddr(addr) {
        local addr = _addrToIP(addr);
        writeReg(W5500_GATEWAY_ADDR_0, W5500_COMMON_REGISTER, addr[0]);
        writeReg(W5500_GATEWAY_ADDR_1, W5500_COMMON_REGISTER, addr[1]);
        writeReg(W5500_GATEWAY_ADDR_2, W5500_COMMON_REGISTER, addr[2]);
        writeReg(W5500_GATEWAY_ADDR_3, W5500_COMMON_REGISTER, addr[3]);
        return this;
    }

    // ***************************************************************************
    // getGatewayAddr
    // Returns:  an array of four integers with the gateway IP address
    // Parameters:
    //        none
    // **************************************************************************
    function getGatewayAddr() {
        local addr = array(4);
        // server.log((hardware.millis() - started) + ": DBG setGatewayAddr: " + pformat(addr));
        addr[0] = readReg(W5500_GATEWAY_ADDR_0, W5500_COMMON_REGISTER);
        addr[1] = readReg(W5500_GATEWAY_ADDR_1, W5500_COMMON_REGISTER);
        addr[2] = readReg(W5500_GATEWAY_ADDR_2, W5500_COMMON_REGISTER);
        addr[3] = readReg(W5500_GATEWAY_ADDR_3, W5500_COMMON_REGISTER);
        return addr;
    }

    // ***************************************************************************
    // setSubnetMask
    // Returns: this
    // Parameters:
    //      addr - an array of four integers with the subnet mask 
    // **************************************************************************
    function setSubnetMask(addr) {
        local addr = _addrToIP(addr);
        writeReg(W5500_SUBNET_MASK_ADDR_0, W5500_COMMON_REGISTER, addr[0]);
        writeReg(W5500_SUBNET_MASK_ADDR_1, W5500_COMMON_REGISTER, addr[1]);
        writeReg(W5500_SUBNET_MASK_ADDR_2, W5500_COMMON_REGISTER, addr[2]);
        writeReg(W5500_SUBNET_MASK_ADDR_3, W5500_COMMON_REGISTER, addr[3]);
        return this;
    }

    // ***************************************************************************
    // getSubnet
    // Returns: an array of four integers with the subnet address
    // Parameters:
    //         none 
    // **************************************************************************
    function getSubnetMask() {
        local addr = array(4);
        // server.log((hardware.millis() - started) + ": DBG setSubnet: " + pformat(addr));
        addr[0] = readReg(W5500_SUBNET_MASK_ADDR_0, W5500_COMMON_REGISTER);
        addr[1] = readReg(W5500_SUBNET_MASK_ADDR_1, W5500_COMMON_REGISTER);
        addr[2] = readReg(W5500_SUBNET_MASK_ADDR_2, W5500_COMMON_REGISTER);
        addr[3] = readReg(W5500_SUBNET_MASK_ADDR_3, W5500_COMMON_REGISTER);
        return addr;
    }

    // ***************************************************************************
    // setSourceHWAddr
    // Returns: this
    // Parameters:
    //      addr - an array of 6 integers with the mac address for the
    //             source hardware
    // **************************************************************************
    function setSourceHWAddr(addr, flip_public_bit = false) {

        if (typeof addr == "string") {
            // Convert from a string
            addr = _addrToMac(addr);
        }

        // Flip the public bit if required
        if (flip_public_bit) {
            addr[0] = addr[0] | 0x02;
        }

        writeReg(W5500_SOURCE_HW_ADDR_0, W5500_COMMON_REGISTER, addr[0]);
        writeReg(W5500_SOURCE_HW_ADDR_1, W5500_COMMON_REGISTER, addr[1]);
        writeReg(W5500_SOURCE_HW_ADDR_2, W5500_COMMON_REGISTER, addr[2]);
        writeReg(W5500_SOURCE_HW_ADDR_3, W5500_COMMON_REGISTER, addr[3]);
        writeReg(W5500_SOURCE_HW_ADDR_4, W5500_COMMON_REGISTER, addr[4]);
        writeReg(W5500_SOURCE_HW_ADDR_5, W5500_COMMON_REGISTER, addr[5]);
        return this;
    }

    // ***************************************************************************
    // getSourceHWAddr
    // Returns: addr - an array of 6 integers with the mac address for the
    //             source hardware
    // Parameters:
    //      none
    // **************************************************************************
    function getSourceHWAddr() {
        // server.log((hardware.millis() - started) + ": DBG setSourceHWAddr: " + pformat(addr));
        local addr = array(6);
        addr[0] = readReg(W5500_SOURCE_HW_ADDR_0, W5500_COMMON_REGISTER);
        addr[1] = readReg(W5500_SOURCE_HW_ADDR_1, W5500_COMMON_REGISTER);
        addr[2] = readReg(W5500_SOURCE_HW_ADDR_2, W5500_COMMON_REGISTER);
        addr[3] = readReg(W5500_SOURCE_HW_ADDR_3, W5500_COMMON_REGISTER);
        addr[4] = readReg(W5500_SOURCE_HW_ADDR_4, W5500_COMMON_REGISTER);
        addr[5] = readReg(W5500_SOURCE_HW_ADDR_5, W5500_COMMON_REGISTER);

        return addr;
    }

    // ***************************************************************************
    // setSourceIP
    // Returns: this
    // Parameters:
    //      addr - an array of 4 integers with the IP address for the
    //             source hardware
    // **************************************************************************
    function setSourceIP(addr) {
        local addr = _addrToIP(addr);
        writeReg(W5500_SOURCE_IP_ADDR_0, W5500_COMMON_REGISTER, addr[0]);
        writeReg(W5500_SOURCE_IP_ADDR_1, W5500_COMMON_REGISTER, addr[1]);
        writeReg(W5500_SOURCE_IP_ADDR_2, W5500_COMMON_REGISTER, addr[2]);
        writeReg(W5500_SOURCE_IP_ADDR_3, W5500_COMMON_REGISTER, addr[3]);
        return this;
    }

    // ***************************************************************************
    // getSourceIP
    // Returns: addr - an array of 4 integers with the IP address for the
    //                 source hardware
    // Parameters:
    //          none    
    // **************************************************************************
    function getSourceIP() {
        local addr = array(4);
        // server.log((hardware.millis() - started) + ": DBG setSourceIP: " + pformat(addr));
        addr[0] = readReg(W5500_SOURCE_IP_ADDR_0, W5500_COMMON_REGISTER);
        addr[1] = readReg(W5500_SOURCE_IP_ADDR_1, W5500_COMMON_REGISTER);
        addr[2] = readReg(W5500_SOURCE_IP_ADDR_2, W5500_COMMON_REGISTER);
        addr[3] = readReg(W5500_SOURCE_IP_ADDR_3, W5500_COMMON_REGISTER);
        return addr;
    }

    // ***************************************************************************
    // setSourcePort
    // Returns: this
    // Parameters:
    //      socket - select the socket using an integer 0-3
    //      addr   - an array of 2 integers with the port for the
    //               source hardware (ex: for port 4242, addr = [0x10, 0x92])
    // **************************************************************************
    function setSourcePort(socket, port) {
        // Convert the type
        if (typeof port == "integer") {
            local newport = array(2, 0);
            newport[0] = (port & 0xFF00) >> 8;
            newport[1] = (port & 0x00FF);
            port = newport;
        }

        local bsb = _getSocketRegBlockSelectBit(socket);
        writeReg(W5500_SOCKET_SOURCE_PORT_0, bsb, port[0]);
        writeReg(W5500_SOCKET_SOURCE_PORT_1, bsb, port[1]);
        return this;
    }

    // ***************************************************************************
    // setDestHWAddr
    // Returns: this
    // Parameters:
    //      socket - select the socket using an integer 0-3
    //      addr - an array of 6 integers with the mac address for the
    //             destination hardware
    // **************************************************************************
    function setDestHWAddr(socket, addr) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        writeReg(W5500_SOCKET_DEST_HW_ADDR_0, bsb, addr[0]);
        writeReg(W5500_SOCKET_DEST_HW_ADDR_1, bsb, addr[1]);
        writeReg(W5500_SOCKET_DEST_HW_ADDR_2, bsb, addr[2]);
        writeReg(W5500_SOCKET_DEST_HW_ADDR_3, bsb, addr[3]);
        writeReg(W5500_SOCKET_DEST_HW_ADDR_4, bsb, addr[4]);
        writeReg(W5500_SOCKET_DEST_HW_ADDR_5, bsb, addr[5]);
        return this;
    }

    // ***************************************************************************
    // setDestIP
    // Returns: this
    // Parameters:
    //      socket - select the socket using an integer 0-3
    //      addr - an array of 4 integers with the IP address for the
    //             destination hardware
    // **************************************************************************
    function setDestIP(socket, addr) {

        // Convert the type
        local addr = _addrToIP(addr);
        if (typeof addr == "array") {
            local bsb = _getSocketRegBlockSelectBit(socket);
            writeReg(W5500_SOCKET_DEST_IP_ADDR_0, bsb, addr[0]);
            writeReg(W5500_SOCKET_DEST_IP_ADDR_1, bsb, addr[1]);
            writeReg(W5500_SOCKET_DEST_IP_ADDR_2, bsb, addr[2]);
            writeReg(W5500_SOCKET_DEST_IP_ADDR_3, bsb, addr[3]);
        } else {
            // Send to the DNS and require a callback
            throw "DNS not available yet";
        }

        return this;
    }

    // ***************************************************************************
    // setDestPort
    // Returns: this
    // Parameters:
    //      socket - select the socket using an integer 0-3
    //      addr - an array of 2 integers with the port for the
    //             destination hardware
    //             (ex: for port 4242, addr = [0x10, 0x92])
    // **************************************************************************
    function setDestPort(socket, port) {

        // Convert the type
        if (typeof port == "integer") {
            local newport = array(2, 0);
            newport[0] = (port & 0xFF00) >> 8;
            newport[1] = (port & 0x00FF);
            port = newport;
        }

        local bsb = _getSocketRegBlockSelectBit(socket);
        writeReg(W5500_SOCKET_DEST_PORT_0, bsb, port[0]);
        writeReg(W5500_SOCKET_DEST_PORT_1, bsb, port[1]);
        return this;
    }

    // ***************************************************************************
    // setRxReadPointer
    // Returns: this
    // Parameters:
    //      socket - select the socket using an integer 0-3
    //      value - new RX read pointer value
    // **************************************************************************
    function setRxReadPointer(socket, value) {
        local rx_pointer_r1 = (value & 0xFF00) >> 8;
        local rx_pointer_r2 = value & 0x00FF;
        local bsb = _getSocketRegBlockSelectBit(socket);
        writeReg(W5500_SOCKET_RX_RP_R1, bsb, rx_pointer_r1);
        writeReg(W5500_SOCKET_RX_RP_R2, bsb, rx_pointer_r2);
        return this;
    }

    // ***************************************************************************
    // setTxWritePointer
    // Returns: this
    // Parameters:
    //      socket - select the socket using an integer 0-3
    //      value - new TX write pointer value
    // **************************************************************************
    function setTxWritePointer(socket, value) {
        local tx_pointer_r1 = (value & 0xFF00) >> 8;
        local tx_pointer_r2 = value & 0x00FF;
        local bsb = _getSocketRegBlockSelectBit(socket);
        writeReg(W5500_SOCKET_TX_WP_R1, bsb, tx_pointer_r1);
        writeReg(W5500_SOCKET_TX_WP_R2, bsb, tx_pointer_r2);
        return this;
    }

    // ***************************************************************************
    // getRxReadPointer
    // Returns: value of read pointer
    // Parameters:
    //      socket - select the socket using an integer 0-3
    // **************************************************************************
    function getRxReadPointer(socket) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        local rx_pointer_pt1 = readReg(W5500_SOCKET_RX_RP_R1, bsb) << 8;
        local rx_pointer_pt2 = readReg(W5500_SOCKET_RX_RP_R2, bsb);

        return rx_pointer_pt1 | rx_pointer_pt2;
    }

    // ***************************************************************************
    // getTxReadPointer
    // Returns: value of read pointer
    // Parameters:
    //      socket - select the socket using an integer 0-3
    // **************************************************************************
    function getTxReadPointer(socket) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        local tx_pointer_pt1 = readReg(W5500_SOCKET_TX_RP_R1, bsb) << 8;
        local tx_pointer_pt2 = readReg(W5500_SOCKET_TX_RP_R2, bsb);

        return tx_pointer_pt1 | tx_pointer_pt2;
    }

    // ***************************************************************************
    // getRxDataSize
    // Returns: value of received data size register
    // Parameters:
    //      socket - select the socket using an integer 0-3
    // **************************************************************************
    function getRxDataSize(socket) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        local rx_pt1 = readReg(W5500_SOCKET_RX_SIZE_R1, bsb) << 8;
        local rx_pt2 = readReg(W5500_SOCKET_RX_SIZE_R2, bsb);

        return rx_pt1 | rx_pt2;
    }

    // ***************************************************************************
    // getFreeTxDataSize
    // Returns: value of TX data free size register
    // Parameters:
    //      socket - select the socket using an integer 0-3
    // **************************************************************************
    function getFreeTxDataSize(socket) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        local tx_fd_pt1 = readReg(W5500_SOCKET_TX_SIZE_R1, bsb) << 8;
        local tx_fd_pt2 = readReg(W5500_SOCKET_TX_SIZE_R2, bsb);

        return tx_fd_pt1 | tx_fd_pt2;
    }

    // ***************************************************************************
    // getSocketRXBufferSize
    // Returns: value of RX data buffer size register
    // Parameters:
    //      socket - select the socket using an integer 0-3
    // **************************************************************************
    function getSocketRXBufferSize(socket) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        return readReg(W5500_SOCKET_RX_BUFFER_SIZE, bsb);
    }

    // ***************************************************************************
    // getSocketTXBufferSize
    // Returns: value of TX data buffer size register
    // Parameters:
    //      socket - select the socket using an integer 0-3
    // **************************************************************************
    function getSocketTXBufferSize(socket) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        return readReg(W5500_SOCKET_TX_BUFFER_SIZE, bsb);
    }

    // ***************************************************************************
    // getChipVersion
    // Returns: chip version (should be 0x04 for the W5500)
    // Parameters: none
    // **************************************************************************
    function getChipVersion() {
        return readReg(W5500_CHIP_VERSION, W5500_COMMON_REGISTER);
    }

    // ***************************************************************************
    // getTotalSupportedSockets
    // Returns: number of sockets the driver code currently supports
    // Parameters: none
    // **************************************************************************
    function getTotalSupportedSockets() {
        return TOTAL_SUPPORTED_SOCKETS;
    }

    // ***************************************************************************
    // getMemoryInfo
    // Returns: table with memory maximums and supported memory block sizes
    // Parameters: none
    // **************************************************************************
    function getMemoryInfo() {
        // mem_block_sizes - an array with supported values highest to lowest
        return { "tx_max": MAX_TX_MEM_BUFFER, "rx_max": MAX_RX_MEM_BUFFER, "mem_block_sizes": [16, 8, 4, 2, 1, 0] }
    }

    // ***************************************************************************
    // getSocketStatus
    // Returns: integer with the connection status for the socket passed in
    // Parameters:
    //      socket - select the socket using an integer 0-3
    // **************************************************************************
    function getSocketStatus(socket) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        local status = readReg(W5500_SOCKET_STATUS, bsb);
        return status;
    }

    // ***************************************************************************
    // waitForSocketStatus
    // Returns: nothing
    // Parameters:
    //      socket - select the socket using an integer 0-3
    //      state - the state we are waiting for
    //      callback - the callback to execute when the state is reached
    //      timeout - the number of seconds after which we will give up
    // **************************************************************************
    function waitForSocketStatus(socket, state, callback, timeout = 10) {
        if (getSocketStatus(socket) == state) {
            return callback(true);
        } else if (timeout <= 0) {
            return callback(false);
        } else {
            imp.wakeup(0.1, function() {
                return waitForSocketStatus(socket, state, callback, timeout - 0.1);
            }.bindenv(this))
        }
    }

    // ***************************************************************************
    // getSocketMode
    // Returns: socketMode
    // Parameters:
    //      socket - select the socket using an integer 0-3
    // **************************************************************************
    function getSocketMode(socket) {
        local bsb = _getSocketRegBlockSelectBit(socket)
        local mode = readReg(W5500_SOCKET_MODE, bsb);
        return mode;
    }

    // ***************************************************************************
    // sendSocketCommand
    // Returns: this
    // Parameters:
    //      socket - select the socket using an integer 0-3
    //      command - select command using SOCKET_COMMANDS constant
    // **************************************************************************
    function sendSocketCommand(socket, command) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        writeReg(W5500_SOCKET_COMMAND, bsb, command);
        return this;
    }

    // ***************************************************************************
    // setNumSockets - configures interrupts and memory for each connection
    // Returns: number of actual connections configured
    // Parameters:
    //      numSockets - number of desired connections
    // **************************************************************************
    function setNumberOfAvailableSockets(numSockets = null) {

        // limit number of sockets to what driver can support
        if (numSockets == null) numSockets = _maxNoOfSockets;
        else if (numSockets < 1) numSockets = 1;
        else if (numSockets > _maxNoOfSockets) numSockets = _maxNoOfSockets;

        // Store this for later
        _noOfSockets = numSockets;

        // calculate max memory for number of sockets
        local memoryInfo = getMemoryInfo();
        local tx_mem = _getMaxMemValue(numSockets, memoryInfo.tx_max, memoryInfo.mem_block_sizes);
        local rx_mem = _getMaxMemValue(numSockets, memoryInfo.rx_max, memoryInfo.mem_block_sizes);

        // Enable interrupt for each connection
        // Set max equal memory across sockets
        local sockets = [], interrupts = 0, txmem = array(numSockets, 0), rxmem = array(numSockets, 0);
        for (local c = 0; c < numSockets; ++c) {
            sockets.insert(0, c);
            interrupts = interrupts | (0x01 << c);
            txmem[c] = tx_mem;
            rxmem[c] = rx_mem;
        }

        setSocketInterrupt(interrupts);
        setMemory(txmem, "tx");
        setMemory(rxmem, "rx");

        return sockets;
    }

    // ***************************************************************************
    // readRxData
    // Returns: data from received data register
    // Parameters:
    //      socket - select the socket using an integer 0-3
    // **************************************************************************
    function readRxData(socket) {

        // get the received data size
        local dataSize = getRxDataSize(socket);
        // TODO: check dataSize is within range of avail memory - throw error

        // select RX memory
        local cntl_byte = getSocketRXBufferSize(socket);
        // Get offset address
        local src_ptr = getRxReadPointer(socket);
        // get Block select bit for RX buffer
        local bsb = _getSocketRXBufferBlockSelectBit(socket);

        // use cntl_byte and src_ptr to get addr??
        // read transmitted data here
        local data = _readData(src_ptr, bsb, dataSize);

        // increase Sn_RX_RD as length of len
        src_ptr += dataSize;
        setRxReadPointer(socket, src_ptr);

        // set RECV command
        sendSocketCommand(socket, W5500_SOCKET_RECEIVE);

        return data;
    }

    // ***************************************************************************
    // sendTxData
    // Returns: length of data to transmit
    // Parameters:
    //      socket - select the socket using an integer 0-3
    //      transmitData - data to be sent
    // **************************************************************************
    function sendTxData(socket, transmitData) {

        local tx_length = transmitData.len();

        // select TX memory
        local cntl_byte = getSocketTXBufferSize(socket);
        // Get offset address
        local dst_ptr = getTxReadPointer(socket); // Sn_TX_RD;
        //  get Block select bit for RX buffer
        local bsb = _getSocketTXBufferBlockSelectBit(socket);

        // write transmit data
        _writeData(dst_ptr, bsb, transmitData);

        // increase Sn_TX_WR as length of send_size
        dst_ptr += tx_length; // adjust write pointer get first??
        setTxWritePointer(socket, dst_ptr);

        // set SEND command
        sendSocketCommand(socket, W5500_SOCKET_SEND);

        return tx_length;
    }


    // INTERRUPT FUNCTIONS
    // ---------------------------------------------

    // ***************************************************************************
    // setInterrupt
    // Returns: this
    // Parameters:
    //      type - select interrupt type using interrupt type
    //             constants or-ed together
    // **************************************************************************
    function setInterrupt(type) {
        writeReg(W5500_INTERRUPT_MASK, W5500_COMMON_REGISTER, type);
        return this;
    }

    // ***************************************************************************
    // clearInterrupt
    // Returns: this
    // Parameters:
    //      type(optional) - clear specified interrupt type
    //                               if nothing passed in clears all interrupts
    // **************************************************************************
    function clearInterrupt(type = 0xF0) {
        writeReg(W5500_INTERRUPT, W5500_COMMON_REGISTER, type);
        return this;
    }

    // ***************************************************************************
    // setSocketInterrupt
    // Returns: this
    // Parameters:
    //      socketInt - select the sockets to enable interrupts on using
    //                  SOCKET INTERRUPTS constants or-ed together
    //      type(optional) - select SOCKET INTERRUPT TYPES using constants
    //              or-ed together, if type not passed in all type interrupts
    //              will be cleared.
    // **************************************************************************
    function setSocketInterrupt(socketInt, type = 0x1F) {
        writeReg(W5500_SOCKET_INTERRUPT_MASK, W5500_COMMON_REGISTER, socketInt);
        // default enables all socket interrupt types
        writeReg(W5500_SOCKET_N_INTERRUPT_MASK, W5500_COMMON_REGISTER, type);
        return this;
    }

    // ***************************************************************************
    // clearSocketInterrupt
    // Returns: this
    // Parameters:
    //      socket : socket (selected by integer) to clear interrupt on
    //      type(optional) - clear specified interrupt type
    //                       if nothing passed in clears all interrupts
    // **************************************************************************
    function clearSocketInterrupt(socket, type = 0x1F) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        writeReg(W5500_SOCKET_N_INTERRUPT, bsb, type);
        return this;
    }

    // ***************************************************************************
    // clearSocketInterrupts
    // Returns: clears the Sockets Interrupt
    // Parameters:
    //      none
    // **************************************************************************
    function clearSocketInterrupts() {
        for (local socket = 0; socket < _noOfSockets; socket++) {
            clearSocketInterrupt(socket);
        }
    }

    // ***************************************************************************
    // getInterruptStatus
    // Returns: interrupt status table
    // Parameters: none
    // **************************************************************************
    function getInterruptStatus() {
        local status = readReg(W5500_INTERRUPT, W5500_COMMON_REGISTER);
        local intStatus = {
            "CONFLICT": status & W5500_CONFLICT_INT_TYPE ? true : false,
            "UNREACH": status & W5500_UNREACH_INT_TYPE ? true : false,
            "PPPoE": status & W5500_PPPoE_INT_TYPE ? true : false,
            "MAGIC_PACKET": status & W5500_MAGIC_PACKET_TYPE ? true : false,
            "REGISTER_VALUE": status
        };
        return intStatus;
    }

    // ***************************************************************************
    // socketInterruptHandler
    // Returns: processes a socket interrupt
    // Parameters: none
    // **************************************************************************
    function socketInterruptHandler() {
        local status = readReg(W5500_SOCKET_INTERRUPT, W5500_COMMON_REGISTER);
        local intStatus = array(8, false);
        // Split the byte into bits
        for (local i = 0; i < 8; ++i) {
            if (status & (0x01 << i)) {
                if (i < _connections.len()) {
                    _connections[i].interruptHandler();
                } else {
                    // This connection has already been closed
                }
            }
        }
    }

    // ***************************************************************************
    // getSocketInterruptTypeStatus
    // Returns: socket interrupt status table
    // Parameters:
    //      socket - select the socket using an integer 0-3
    // **************************************************************************
    function getSocketInterruptTypeStatus(socket) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        local status = readReg(W5500_SOCKET_N_INTERRUPT, bsb);
        local intStatus = {
            "SEND_COMPLETE": status & W5500_SEND_COMPLETE_INT_TYPE ? true : false,
            "TIMEOUT": status & W5500_TIMEOUT_INT_TYPE ? true : false,
            "DATA_RECEIVED": status & W5500_DATA_RECEIVED_INT_TYPE ? true : false,
            "DISCONNECTED": status & W5500_DISCONNECTED_INT_TYPE ? true : false,
            "CONNECTED": status & W5500_CONNECTED_INT_TYPE ? true : false,
            "REGISTER_VALUE": status
        };
        return intStatus;
    }

    // ***************************************************************************
    // getTimeoutCount
    // Returns: Connection timeout count
    // Parameters:
    //      none
    // **************************************************************************
    function getTimeoutCount() {
        return readReg(W5500_RETRY_COUNT, 0x00);
    }

    // ***************************************************************************
    // setTimeoutCount
    // Returns: none
    // Parameters:
    //      count - number of times to retry on timeout
    // **************************************************************************
    function setTimeoutCount(count) {
        writeReg(W5500_RETRY_COUNT, 0x00, count);
    }


    // SPI FUNCTIONS
    // ---------------------------------------------

    // ***************************************************************************
    // readReg
    // Returns: data stored at the specified register
    // Parameters:
    //      reg - register to read
    // **************************************************************************
    function readReg(addr, bsb) {
        local b = blob();
        local cp = bsb | W5500_READ_COMMAND | W5500_VARIABLE_DATA_LENGTH;
        local res = blob();

        (_cs) ? _cs.write(0): _spi.chipselect(1);

        b.writen(addr >> 8, 'b');
        b.writen(addr & 0xFF, 'b');
        b.writen(cp, 'b');
        b.writen(0x00, 'b');

        res = _spi.writeread(b);

        (_cs) ? _cs.write(1): _spi.chipselect(0);

        return res[3];
    }

    // ***************************************************************************
    // writeReg
    // Returns: null
    // Parameters:
    //      reg - register to write to
    //      value - data to write to register
    // **************************************************************************
    function writeReg(addr, bsb, value) {
        local b = blob();
        local cp = bsb | W5500_WRITE_COMMAND | W5500_VARIABLE_DATA_LENGTH;

        (_cs) ? _cs.write(0): _spi.chipselect(1);

        b.writen(addr >> 8, 'b');
        b.writen(addr & 0xFF, 'b');
        b.writen(cp, 'b');
        b.writen(value, 'b');

        _spi.write(b);

        (_cs) ? _cs.write(1): _spi.chipselect(0);
    }


    // ***************************************************************************
    // reset, note this is blocking for 0.2s
    // Returns: this
    // Parameters:
    //          sw(optional) - boolean if true forces a software reset
    //          Note: datasheet for W5500 states that software reset is
    //                unreliable - don't use
    // **************************************************************************
    function reset(sw = false) {
        // Reset chip to default state, blocks for 0.2s
        // Note: Datasheet states that W5500 software reset
        //       is not reliable, use hardware reset.
        if (sw || _resetPin == null) {
            setMode(W5500_SW_RESET);
            imp.sleep(0.2);
        } else {
            _resetPin.write(0);
            imp.sleep(0.001); // hold at least 500us after assert low
            _resetPin.write(1);
            imp.sleep(0.2); // wait at least 150ms before configuring
        }

        // Reset the default memory allocation
        _setMemDefaults();
        return this;
    }


    // PRIVATE FUNCTIONS
    // ---------------------------------------------

    // ***************************************************************************
    // _hexToInt
    // Returns: an integer representation of the string passed in
    // Parameters:
    //      hexString - A string representing a hexadecimal number
    // **************************************************************************
    function _hexToInt(hexString) {
        // Does the string start with '0x'? If so, remove it
        if (hexString.slice(0, 2) == "0x") hexString = hexString.slice(2);

        // Get the integer value of the remaining string
        local intValue = 0;

        foreach (character in hexString) {
            local nibble = character - '0';
            if (nibble > 9) nibble = ((nibble & 0x1F) - 7);
            intValue = (intValue << 4) + nibble;
        }

        return intValue;
    }

    // ***************************************************************************
    // _addrToIP
    // Returns: an array of four numbers representing an ip address or false if it is a string for the DNS
    // Parameters:
    //      addr - a string or array representing an IP address
    // **************************************************************************
    function _addrToIP(addr) {

        if (typeof addr == "string" && addr.len() > 0) {

            try {
                local parts = split(addr, ".");
                if (parts.len() == 4) {
                    foreach (part in parts) {
                        local ipart = part.tointeger();
                        if (ipart.tostring() != part || ipart < 0 || ipart >= 256) {
                            return false;
                        }
                    }

                    return [parts[0].tointeger(), parts[1].tointeger(), parts[2].tointeger(), parts[3].tointeger()];
                } else {
                    return false;
                }
            } catch (e) {
                return false;
            }

        } else if (typeof addr == "blob" && addr.len() == 4) {
            local parts = array();
            addr.seek(0, 'b');
            while (!addr.eos()) {
                parts.push(addr.readn('b'))
            }
            return parts;
        } else if (typeof addr == "array" && addr.len() == 4) {
            return addr;
        } else {
            throw "Bad IP address";
        }

    }


    // ***************************************************************************
    // _addrToIP
    // Returns: an array of four numbers representing an ip address or false if it is a string for the DNS
    // Parameters:
    //      addr - a string or array representing an IP address
    // **************************************************************************
    function _addrToMac(addr) {

        if (typeof addr == "string" && addr.len() == 12) {
            // Convert a string address to an array
            local mac = [];
            for (local i = 0; i < addr.len(); i += 2) {
                local byte = addr.slice(i, i + 2);
                mac.push(_hexToInt(byte));
            }
            return mac;
        } else if (typeof addr == "blob" && addr.len() == 6) {
            local parts = array();
            addr.seek(0, 'b');
            while (!addr.eos()) {
                parts.push(addr.readn('b'))
            }
            return parts;
        } else if (typeof addr == "array" && addr.len() == 6) {
            return addr;
        } else {
            throw "Bad Mac address";
        }
    }

    // ***************************************************************************
    // _getSocketRegBlockSelectBit
    // Returns: the socket register Control Phase Block Select Bit for the socket passed in
    // Parameters:
    //      socket - select the socket using an integer 0-3
    // **************************************************************************
    function _getSocketRegBlockSelectBit(socket) {
        switch (socket) {
            case 0:
                return W5500_S0_REGISTER;
            case 1:
                return W5500_S1_REGISTER;
            case 2:
                return W5500_S2_REGISTER;
            case 3:
                return W5500_S3_REGISTER;
            case 4:
                return W5500_S4_REGISTER;
            case 5:
                return W5500_S5_REGISTER;
            case 6:
                return W5500_S6_REGISTER;
            case 7:
                return W5500_S7_REGISTER;
        }
        return null;
    }

    // ***************************************************************************
    // _getSocketRXBufferBlockSelectBit
    // Returns: the socket RX buffer Control Phase Block Select Bit for the socket passed in
    // Parameters:
    //      socket - select the socket using an integer 0-3
    // **************************************************************************
    function _getSocketRXBufferBlockSelectBit(socket) {
        switch (socket) {
            case 0:
                return W5500_S0_RX_BUFFER;
            case 1:
                return W5500_S1_RX_BUFFER;
            case 2:
                return W5500_S2_RX_BUFFER;
            case 3:
                return W5500_S3_RX_BUFFER;
            case 4:
                return W5500_S4_RX_BUFFER;
            case 5:
                return W5500_S5_RX_BUFFER;
            case 6:
                return W5500_S6_RX_BUFFER;
            case 7:
                return W5500_S7_RX_BUFFER;
        }
        return null;
    }

    // ***************************************************************************
    // _getSocketRXBufferBlockSelectBit
    // Returns: the socket TX buffer Control Phase Block Select Bit for the socket passed in
    // Parameters:
    //      socket - select the socket using an integer 0-3
    // **************************************************************************
    function _getSocketTXBufferBlockSelectBit(socket) {
        switch (socket) {
            case 0:
                return W5500_S0_TX_BUFFER;
            case 1:
                return W5500_S1_TX_BUFFER;
            case 2:
                return W5500_S2_TX_BUFFER;
            case 3:
                return W5500_S3_TX_BUFFER;
            case 4:
                return W5500_S4_TX_BUFFER;
            case 5:
                return W5500_S5_TX_BUFFER;
            case 6:
                return W5500_S6_TX_BUFFER;
            case 7:
                return W5500_S7_TX_BUFFER;
        }
        return null;
    }


    // ***************************************************************************
    // _setMemDefaults, sets locally stored default socket memory info
    // Returns: null
    // Parameters: none
    // **************************************************************************
    function _setMemDefaults() {
        _socketMemory = {
            "rx": [2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048],
            "tx": [2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048]
        }
    }


    // ***************************************************************************
    // _writeData, writes data to transmit memory buffer
    // Returns: size of data written
    // Parameters:
    //      addr - offset address to start the data write
    //      bsb - socket tx buffer block select bit
    //      data - data to be written
    // **************************************************************************
    function _writeData(addr, bsb, data) {
        foreach (item in data) {
            writeReg(addr, bsb, item);
            addr++;
        }

        return data.len();
    }

    // ***************************************************************************
    // _readData
    // Returns: blob containing data from memory buffer
    // Parameters:
    //      addr - offset address to start the read
    //      bsb - block select bit for the socket rx buffer
    //      size - size of data to be written
    // **************************************************************************
    function _readData(addr, bsb, size) {
        local b = blob();

        while (size != 0) {
            b.writen(readReg(addr, bsb), 'b');
            addr++;
            size--;
        }

        return b
    }

    // ***************************************************************************
    // _getMaxMemValue
    // Returns: max memory value
    // Parameters:
    //      numValues - number of memory slots
    //      max - max memory available
    //      blockSizes - array of supported memory sizes
    // **************************************************************************
    function _getMaxMemValue(numValues, max, blockSizes) {
        // make sure memory values are in desending order
        blockSizes.sort();
        blockSizes.reverse();

        local memory = max / numValues;

        foreach (value in blockSizes) {
            if (memory >= value) {
                memory = value;
                break;
            }
        }
        return memory;
    }

}


// ==============================================================================
// CLASS: W5500.Connection
// ==============================================================================

class W5500.Connection {

    _driver = null;
    _socket = null;
    _state = null;
    _handlers = null;
    _ip = null;
    _port = null;
    _mode = null;
    _sourcePort = null;
    _transmitQueue = null;
    _transmitting = false;

    // ***************************************************************************
    // Constructor
    // Returns: null
    // Parameters:
    //      driver  - the instance of the W5500.driver class
    //      socket  - socket number of the connection (integer)
    //      ip      - the ip address of the destination
    //      port    - the port of the destination
    //      mode    - TCP or UDP
    //      handlers(optional) - table of callback functions
    //                              (connect, disconnect, transmit, receive)
    // **************************************************************************
    constructor(driver, socket, ip, port, mode, handlers = {}) {
        _driver = driver;
        _socket = socket;
        _state = W5500_SOCKET_STATES.CLOSED;
        _ip = ip;
        _port = port;
        _mode = mode;
        _handlers = handlers;
        _transmitQueue = [];
    }


    // ***************************************************************************
    // open
    // Returns: this
    // Parameters:
    //      cb - callback to be called when the connection is opened
    // **************************************************************************
    function open(cb = null) {

        // Open socket connection
        _driver.setSocketMode(_socket, _mode);

        if (_sourcePort == null) {
            local sourcePort = _returnRandomPort(1024, 65535); // creates a random port between 1024-65535
            _driver.setSourcePort(_socket, sourcePort);
        } else {
            _driver.setSourcePort(_socket, _sourcePort);
        }

        _driver.sendSocketCommand(_socket, W5500_SOCKET_OPEN);
        _state = W5500_SOCKET_STATES.INIT;

        // Setup the connection
        _driver.setDestIP(_socket, _ip);
        _driver.setDestPort(_socket, _port);
        _driver.sendSocketCommand(_socket, W5500_SOCKET_CONNECT);
        _state = W5500_SOCKET_STATES.CONNECTING;

        if (cb) {
            if (_mode == W5500_SOCKET_MODE_UDP) {
                _state = W5500_SOCKET_STATES.ESTABLISHED
                cb(null, this);
            } else {
                onConnect(cb);
            }
        }

        return this;
    }


    // ***************************************************************************
    // close
    // Returns: close connection
    // Parameters:
    //      none
    // **************************************************************************
    function close(cb = null) {
        if (_state == W5500_SOCKET_STATES.DISCONNECTING) {
            if (cb) imp.wakeup(1, cb);
        } else {
            _state = W5500_SOCKET_STATES.DISCONNECTING;
            _driver.closeConnection(_socket, cb);
        }
    }


    // ***************************************************************************
    // getIP
    // Returns: the destination ip address
    // Parameters:
    //      none
    // **************************************************************************
    function getIP() {
        return _ip;
    }

    // ***************************************************************************
    // getPort
    // Returns: the destination port
    // Parameters:
    //      none
    // **************************************************************************
    function getPort() {
        return _port;
    }

    // ***************************************************************************
    // onConnect
    // Returns: this
    // Parameters:
    //      cb - function to called when connect/timeout interrupt triggered
    // **************************************************************************
    function onConnect(cb) {
        _handlers["connect"] <- cb;
        return this;
    }

    // ***************************************************************************
    // onDisconnect
    // Returns: this
    // Parameters:
    //      cb - function to called when disconnect interrupt triggered
    // **************************************************************************
    function onDisconnect(cb) {
        _handlers["disconnect"] <- cb;
        return this;
    }

    // ***************************************************************************
    // onReceive
    // Returns: this
    // Parameters:
    //      cb - function to called when data received interrupt triggered
    // **************************************************************************
    function onReceive(cb) {
        _handlers["receive"] <- cb;
        return this;
    }

    // ***************************************************************************
    // onTransmitted
    // Returns: this
    // Parameters:
    //      cb - function to called when transmit/timeout interrupt triggered
    // **************************************************************************
    function onTransmitted(cb) {
        _handlers["transmit"] <- cb;
        return this;
    }

    // ***************************************************************************
    // setSourcePort
    // Returns: this
    // Parameters:
    //      port - source port
    // **************************************************************************
    function setSourcePort(port) {
        _sourcePort = port;
        return this;
    }

    // ***************************************************************************
    // _getHandler
    // Returns: handler function or null
    // Parameters:
    //      handlerName - name of handler
    // **************************************************************************
    function _getHandler(handlerName) {
        return (handlerName in _handlers) ? _handlers[handlerName] : null;
    }


    // ***************************************************************************
    // getSocket
    // Returns: the socket id
    // Parameters: none
    // **************************************************************************
    function getSocket() {
        return _socket;
    }


    // ***************************************************************************
    // _dataWaiting
    // Returns: boolean
    // Parameters:
    //      socket - connection socket
    // **************************************************************************
    function _dataWaiting() {
        return (_driver.getRxDataSize(_socket) == 0x00) ? false : true;
    }

    // ***************************************************************************
    // isEstablished
    // Returns: boolean
    // Parameters:
    //      none
    // **************************************************************************
    function isEstablished() {
        return (_driver.getSocketStatus(_socket) == W5500_SOCKET_STATUS_ESTABLISHED) ? true : false;
    }

    // ***************************************************************************
    // _handleSocketInt, handles/clears the specified socket interrupt
    // Returns: null
    // Parameters: socket the interrupt occurred on
    // **************************************************************************
    function interruptHandler() {
        local status = _driver.getSocketInterruptTypeStatus(_socket);

        if (status.CONNECTED) {
            // server.log("Connection established on socket " + _socket);
            _driver.clearSocketInterrupt(_socket, W5500_CONNECTED_INT_TYPE);

            _state = W5500_SOCKET_STATES.ESTABLISHED;

            local _connectionCallback = _getHandler("connect");
            if (_connectionCallback) {
                onConnect(null);

                imp.wakeup(0, function() {
                    _connectionCallback(null, this);
                }.bindenv(this))
            }
        }

        if (status.TIMEOUT) {
            // server.log("Timeout occurred on socket " + _socket);
            _driver.clearSocketInterrupt(_socket, W5500_TIMEOUT_INT_TYPE);

            if (_state == W5500_SOCKET_STATES.CONNECTING) {

                local _connectionCallback = _getHandler("connect");
                if (_connectionCallback) {
                    onConnect(null);

                    imp.wakeup(0, function() {
                        _connectionCallback("timeout", null);
                    }.bindenv(this))
                }

                // Deregister this socket
                _driver.deregisterSocket(_socket);

            } else {

                local _transmitCallback = _getHandler("transmit");
                if (_transmitCallback) {
                    onTransmitted(null);

                    imp.wakeup(0, function() {
                        _transmitCallback("Transmission timeout");
                    }.bindenv(this))
                } else {
                    // server.error("No timeout handler")
                }
            }
        }

        if (status.SEND_COMPLETE) {
            // server.log("Send complete on socket " + _socket);
            _driver.clearSocketInterrupt(_socket, W5500_SEND_COMPLETE_INT_TYPE);

            // call transmitting callback
            local _transmitCallback = _getHandler("transmit");
            if (_transmitCallback) {
                onTransmitted(null);

                imp.wakeup(0, function() {
                    _transmitCallback(null);
                }.bindenv(this))
            }
        }

        if (status.DATA_RECEIVED) {
            // server.log("Data received on socket " + _socket);
            _driver.clearSocketInterrupt(_socket, W5500_DATA_RECEIVED_INT_TYPE);
            receive(); // process incoming data
        }

        if (status.DISCONNECTED) {

            // server.log("Connection disconnected on socket " + _socket);
            _driver.clearSocketInterrupt(_socket, W5500_DISCONNECTED_INT_TYPE);

            if (_state == W5500_SOCKET_STATES.CONNECTING) {

                // call connected (failed) callback
                local _connectionCallback = _getHandler("connect");
                if (_connectionCallback) {
                    onConnect(null);

                    imp.wakeup(0, function() {
                        _connectionCallback("failed", null);
                    }.bindenv(this))
                }

            } else {

                // call disconnected callback
                local _disconnectCallback = _getHandler("disconnect");
                if (_disconnectCallback) {
                    imp.wakeup(0, function() {
                        _disconnectCallback(null);
                    }.bindenv(this));
                }

            }

            // Deregister the socket
            _driver.deregisterSocket(_socket);

            // clear transmit and connection callbacks
            onTransmitted(null);
            onConnect(null);
            onDisconnect(null);

        }

    }



    // ***************************************************************************
    // transmit
    // Returns: this
    // Parameters:
    //      transmitData - blob/string of data to transmit
    //      cb(optional) - function to be called when data successfully
    //                      sent or timeout has occurred
    // **************************************************************************
    function transmit(transmitData, cb = null) {

        local _transmitNextInQueue, _transmit;

        // Function to perform the transmission of one data packet broken into chunks
        _transmit = function(transmitData, _cb = null) {

            local __cb, transmit_timer, _transmitNextChunk;

            // Prepare for a timeout
            transmit_timer = imp.wakeup(W5500_TRANSMIT_TIMEOUT, function() {
                __cb(W5500_TRANSMIT_TIMEOUT)
            }.bindenv(this));

            // Prepare a dummy callback to clear the timer before calling the real callback
            __cb = function(err = null) {
                if (transmit_timer) {
                    imp.cancelwakeup(transmit_timer);
                    transmit_timer = null;
                }
                if (_cb) {
                    imp.wakeup(0, function() {
                        _cb(err);
                    }.bindenv(this));
                }
            }.bindenv(this);


            // Chunking data that is greater than buffer size. check transmission data size.
            // If larger than socket transmit bufffer, break data into chunks before sending.
            local txBufferSize = _driver.getMemory("tx", _socket);
            local tx_length = transmitData.len();
            local chunks = [];

            if ((tx_length * 8) > txBufferSize) {
                local startPointer = 0;
                local endPointer = txBufferSize / 8;

                // Loop over data and create chunks
                while (endPointer < tx_length) {

                    chunks.push(transmitData.slice(startPointer, endPointer));
                    startPointer = endPointer;
                    endPointer += (txBufferSize / 8);

                }

                // Create final, partially full chunk
                if (startPointer < tx_length) {
                    chunks.push(transmitData.slice(startPointer));
                }
            } else {
                chunks.push(transmitData);
            }


            // Receive any waiting data first
            local receiveHandler = _getHandler("receive");
            if (receiveHandler && _dataWaiting()) {
                receiveHandler(null, _driver.readRxData(_socket));
            }


            // Finally, loop thru a queue of chunks
            _transmitNextChunk = function(chunk) {

                // Setup the temporary callback
                onTransmitted(function(err) {
                    if (!err && chunks.len() > 0) {
                        // Send the next chunk
                        _transmitNextChunk(chunks.remove(0));
                    } else {
                        // All done.
                        __cb(err);
                    }
                }.bindenv(this));

                // Send the chunk
                _driver.sendTxData(_socket, chunk);
            }

            // Send the first chunk
            _transmitNextChunk(chunks.remove(0));
        }


        // Function to loop thru a queue of transmissions
        _transmitNextInQueue = function() {
            if (!_transmitting && _transmitQueue.len() > 0) {
                _transmitting = true;
                local task = _transmitQueue.remove(0);
                _transmit(task.data, function(err) {
                    _transmitting = false;
                    imp.wakeup(0, _transmitNextInQueue.bindenv(this));
                    if (task.cb) task.cb(err);
                }.bindenv(this));
            }
        }


        // Check types are valid and convert otherwise
        if (transmitData == null) {
            throw "transmit() requires a string or blob";
        } else if (typeof transmitData != "string") {
            transmitData = transmitData.tostring();
        }
        if (typeof transmitData != "string") {
            throw "transmit() requires a string or blob";
        }

        // Check the socket is ready
        if (_state != W5500_SOCKET_STATES.ESTABLISHED) {
            throw "Connection not established";
        }

        // Append to the queue and start the transmission.
        _transmitQueue.push({ "data": transmitData, "cb": cb });
        _transmitNextInQueue();

        return this;
    }


    // ***************************************************************************
    // receive
    // Returns: this
    // Parameters:
    //      cb(optional) - callback to pass receive data to
    //                     (note: if callback is passed in it will superceede
    //                     the callback set by setReceiveCallback, and will be
    //                     used only for during this check for data)
    // **************************************************************************
    function receive(cb = null) {

        local receiveHandler = _getHandler("receive");
        local callback = cb ? cb : receiveHandler;
        local err = null, data = null;

        if (cb) {

            // Temporarily take over the callback
            onReceive(function(err, data) {
                cb(err, data);
                onReceive(receiveHandler);
            }.bindenv(this));

        } else {
            // Handle a normal callback here
            if (_state == W5500_SOCKET_STATES.ESTABLISHED) {
                if (_dataWaiting()) {
                    data = _driver.readRxData(_socket);
                }
            } else {
                err = "Connection not established in receive()";
            }

            if (callback) {
                imp.wakeup(0, function() {
                    callback(err, data);
                }.bindenv(this));
            } else if (err) {
                server.error(err);
            }
        }

        return this;
    }


    // ***************************************************************************
    // _returnRandomPort
    // Returns: an array with a random port between min and max
    // Parameters:
    //      min - lowest possible port number
    //      max - highest possible port number
    // **************************************************************************
    function _returnRandomPort(min, max) {
        local port = (1.0 * math.rand() / RAND_MAX) * (max + 1 - min);
        port = port.tointeger() + min;
        return [(port >> 8) & 0xFF, port & 0xFF];
    }

}

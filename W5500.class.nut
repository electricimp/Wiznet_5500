// CONTROL PHASE
// --------------------------------------------------

// BLOCK SELECT BITS
const COMMON_REGISTER = 0x00;

const S0_REGISTER = 0x08;
const S0_TX_BUFFER = 0x10;
const S0_RX_BUFFER = 0x18;

const S1_REGISTER = 0x28;
const S1_TX_BUFFER = 0x30;
const S1_RX_BUFFER = 0x38;

const S2_REGISTER = 0x48;
const S2_TX_BUFFER = 0x50;
const S2_RX_BUFFER = 0x58;

const S3_REGISTER = 0x68;
const S3_TX_BUFFER = 0x70;
const S3_RX_BUFFER = 0x78;

const S4_REGISTER = 0x88;
const S4_TX_BUFFER = 0x90;
const S4_RX_BUFFER = 0x98;

const S5_REGISTER = 0xA8;
const S5_TX_BUFFER = 0xB0;
const S5_RX_BUFFER = 0xB8;

const S6_REGISTER = 0xC8;
const S6_TX_BUFFER = 0xD0;
const S6_RX_BUFFER = 0xD8;

const S7_REGISTER = 0xE8;
const S7_TX_BUFFER = 0xF0;
const S7_RX_BUFFER = 0xF8;

// READ/WRITE BIT
const READ_COMMAND = 0x00;
const WRITE_COMMAND = 0x04;

// SPI OPPERATION MODE
const VARIABLE_DATA_LENGTH = 0x00;
const FIXED_DATA_LENGTH_1 = 0x01;
const FIXED_DATA_LENGTH_2 = 0x02;
const FIXED_DATA_LENGTH_4 = 0x03;


// COMMON REGISTERS OFFSET ADDRESSES
// --------------------------------------------------
// MR
const MODE = 0x0000;

//GWR
const GATEWAY_ADDR_0 = 0x0001;
const GATEWAY_ADDR_1 = 0x0002;
const GATEWAY_ADDR_2 = 0x0003;
const GATEWAY_ADDR_3 = 0x0004;

//SUBR
const SUBNET_MASK_ADDR_0 = 0x0005;
const SUBNET_MASK_ADDR_1 = 0x0006;
const SUBNET_MASK_ADDR_2 = 0x0007;
const SUBNET_MASK_ADDR_3 = 0x0008;

//SHAR
const SOURCE_HW_ADDR_0 = 0x0009;
const SOURCE_HW_ADDR_1 = 0x000A;
const SOURCE_HW_ADDR_2 = 0x000B;
const SOURCE_HW_ADDR_3 = 0x000C;
const SOURCE_HW_ADDR_4 = 0x000D;
const SOURCE_HW_ADDR_5 = 0x000E;

//SIPR
const SOURCE_IP_ADDR_0 = 0x000F;
const SOURCE_IP_ADDR_1 = 0x0010;
const SOURCE_IP_ADDR_2 = 0x0011;
const SOURCE_IP_ADDR_3 = 0x0012;

// INTLEVEL
const INTERRUPT_LOW_LEVEL_TIMER_0 = 0x0013;
const INTERRUPT_LOW_LEVEL_TIMER_1 = 0x0014;

//IR
const INTERRUPT = 0x0015;
// IMR
const INTERRUPT_MASK = 0x0016;

// SIR
const SOCKET_INTERRUPT = 0x0017;
// SIMR
const SOCKET_INTERRUPT_MASK = 0x0018;

// RTR
const RETRY_TIME_0 = 0x0019;
const RETRY_TIME_1 = 0x001A;
// RCR
const RETRY_COUNT = 0x001B;

const CHIP_VERSION = 0x0039;


// SOCKET REGISTER OFFSET ADDRESSES
// --------------------------------------------------

const SOCKET_MODE = 0x0000;
const SOCKET_COMMAND = 0x0001;
const SOCKET_N_INTERRUPT = 0x0002;
const SOCKET_STATUS = 0x0003;

const SOCKET_SOURCE_PORT_0 = 0x0004;
const SOCKET_SOURCE_PORT_1 = 0x0005;

const SOCKET_DEST_HW_ADDR_0 = 0x0006;
const SOCKET_DEST_HW_ADDR_1 = 0x0007;
const SOCKET_DEST_HW_ADDR_2 = 0x0008;
const SOCKET_DEST_HW_ADDR_3 = 0x0009;
const SOCKET_DEST_HW_ADDR_4 = 0x000A;
const SOCKET_DEST_HW_ADDR_5 = 0x000B;

const SOCKET_DEST_IP_ADDR_0 = 0x000C;
const SOCKET_DEST_IP_ADDR_1 = 0x000D;
const SOCKET_DEST_IP_ADDR_2 = 0x000E;
const SOCKET_DEST_IP_ADDR_3 = 0x000F;

const SOCKET_DEST_PORT_0 = 0x0010;
const SOCKET_DEST_PORT_1 = 0x0011;

const SOCKET_RX_BUFFER_SIZE = 0x001E;
const SOCKET_TX_BUFFER_SIZE = 0x001F;

// SOCKET TX FREE SIZE REGISTER (Sn_TX_FREE_SIZE)
const SOCKET_TX_SIZE_R1 = 0x0020;
const SOCKET_TX_SIZE_R2 = 0x0021;

// SOCKET TX READ POINTER
const SOCKET_TX_RP_R1 = 0x0022;
const SOCKET_TX_RP_R2 = 0x0023;

// SOCKET TX WRITE POINTER
const SOCKET_TX_WP_R1 = 0x0024;
const SOCKET_TX_WP_R2 = 0x0025;

// SOCKET RX RECEIVED SIZE REGISTER (Sn_RX_RSR)
const SOCKET_RX_SIZE_R1 = 0x0026;
const SOCKET_RX_SIZE_R2 = 0x0027;

// SOCKET RX READ POINTER (Sn_RX_RD)
const SOCKET_RX_RP_R1 = 0x0028;
const SOCKET_RX_RP_R2 = 0x0029;

// SOCKET N INTERRUPT MASK (Sn_IMR)
const SOCKET_N_INTERRUPT_MASK = 0x002C;

// --------------------------------------------------

// MODES
const SW_RESET = 0x80;
const WAKE_ON_LAN = 0x20;
const PING_BLOCK = 0x10;
const PPPoE = 0x08;
const FORCE_ARP = 0x01;
const DEFAULT_MODE = 0x00;

// SOCKET MODES (Sn_MR)
const SOCKET_MODE_MULTI = 0x80;
const SOCKET_MODE_BROADCAST_BLOCKING = 0x40;
const SOCKET_MODE_NO_DELAY_ACK = 0x20;
const SOCKET_MODE_UNICAST_BLOCKING = 0x10;
const SOCKET_MODE_CLOSED = 0x00;
const SOCKET_MODE_TCP = 0x01;
const SOCKET_MODE_UDP = 0x02;
const SOCKET_MODE_MACRAW = 0x03;

// SOCKET COMMANDS (Sn_CR)
const SOCKET_OPEN = 0x01;
const SOCKET_LISTEN = 0x02;
const SOCKET_CONNECT = 0x04;
const SOCKET_DISCONNECT = 0x08;
const SOCKET_CLOSE = 0x10;
const SOCKET_SEND = 0x20;
const SOCKET_SEND_MAC = 0x21;
const SOCKET_SEND_KEEP = 0x22;
const SOCKET_RECEIVE = 0x40;

// SOCKET STATUS (Sn_SR)
const SOCKET_STATUS_CLOSED = 0x00;
const SOCKET_STATUS_INIT = 0x13;
const SOCKET_STATUS_LISTEN = 0x14;
const SOCKET_STATUS_ESTABLISHED = 0x17;
const SOCKET_STATUS_CLOSE_WAIT = 0x1C;
const SOCKET_STATUS_UDP = 0x22;
const SOCKET_STATUS_MACRAW = 0x42;
const SOCKET_STATUS_SYNSENT = 0x15;
const SOCKET_STATUS_SYNRECV = 0x16;
const SOCKET_STATUS_FIN_WAIT = 0x18;
const SOCKET_STATUS_CLOSING = 0x1A;
const SOCKET_STATUS_TIME_WAIT = 0x1B;
const SOCKET_STATUS_LAST_ACK = 0x1D;

// INTERRUPT TYPES
const CONFLICT_INT_TYPE = 0x80;
const UNREACH_INT_TYPE = 0x40;
const PPPoE_INT_TYPE = 0x20;
const MAGIC_PACKET_TYPE = 0x10;
const NONE_INT_TYPE = 0x00;

// SOCKET INTERRUPTS
const S0_INTERRUPT = 0x01;
const S1_INTERRUPT = 0x02;
const S2_INTERRUPT = 0x04;
const S3_INTERRUPT = 0x08;
const S4_INTERRUPT = 0x10;
const S5_INTERRUPT = 0x20;
const S6_INTERRUPT = 0x40;
const S7_INTERRUPT = 0x80;
const DISABLE_SOCKET_INTERRUPTS = 0x00;

// SOCKET INTERRUPT TYPES
const SEND_COMPLETE_INT_TYPE = 0x10;
const TIMEOUT_INT_TYPE = 0x08;
const DATA_RECEIVED_INT_TYPE = 0x04;
const DISCONNECTED_INT_TYPE = 0x02;
const CONNECTED_INT_TYPE = 0x01;

/* --------------------------------------------------
 *  W5500 driver
 *  this driver supports only the first 4 sockets (0-3)
   -------------------------------------------------- */
class W5500 {
    static VERSION = [0, 1, 0];
}

class W5500.Connection {
    socket = null;
    state = null;
    handlers = null;
    settings = null;

    /***************************************************************************
     * Constructor
     * Returns: null
     * Parameters:
     *      _socket - socket number of the connection (integer)
     *      _state - current state of the connection (string)
     *      _settings - table of connection settings
     *      _handlers(optional) - table of callback functions
     *                              (connect, disconnect, transmit, receive)
     **************************************************************************/
    constructor(_socket, _state, _settings, _handlers = {}) {
        socket = _socket;
        state = _state;
        handlers = _handlers;
        settings = _settings;
    }

    /***************************************************************************
     * setDisconnectHandler
     * Returns: this
     * Parameters:
     *      cb - function to called when disconnect interrupt triggered
     **************************************************************************/
    function setDisconnectHandler(cb) {
        handlers["disconnect"] <- cb;
        return this;
    }

    /***************************************************************************
     * setReceiveHandler
     * Returns: this
     * Parameters:
     *      cb - function to called when data received interrupt triggered
     **************************************************************************/
    function setReceiveHandler(cb) {
        handlers["receive"] <- cb;
        return this;
    }

    /***************************************************************************
     * setTransmitHandler
     * Returns: this
     * Parameters:
     *      cb - function to called when transmit/timeout interrupt triggered
     **************************************************************************/
    function setTransmitHandler(cb) {
        handlers["transmit"] <- cb;
        return this;
    }

    /***************************************************************************
     * setConnectHandler
     * Returns: this
     * Parameters:
     *      cb - function to called when connect/timeout interrupt triggered
     **************************************************************************/
    function setConnectHandler(cb) {
        handlers["connect"] <- cb;
        return this;
    }

    /***************************************************************************
     * setState
     * Returns: this
     * Parameters:
     *      state - new conneciton state
     **************************************************************************/
    function setState(state) {
        state = state;
        return this;
    }

    /***************************************************************************
     * setSourcePort
     * Returns: this
     * Parameters:
     *      port - source port
     **************************************************************************/
    function setSourcePort(port) {
        settings["sourcePort"] <- port;
        return this;
    }

    /***************************************************************************
     * setSourcePort
     * Returns: handler function or null
     * Parameters:
     *      handlerName - name of handler
     **************************************************************************/
    function getHandler(handlerName) {
        return (handlerName in handlers) ? handlers[handlerName] : null;
    }
}

class W5500.Driver {

    // Chip can support 8, only 4 supported in the driver code
    static TOTAL_SUPPORTED_SOCKETS = 4;
    static MAX_TX_MEM_BUFFER = 16;
    static MAX_RX_MEM_BUFFER = 16;

    // CLASS VARIABLES
    _spi = null;
    _cs = null;
    _resetPin = null;

    socketMemory = null;

    /***************************************************************************
     * Constructor
     * Returns: null
     * Parameters:
     *      spi - configured spi, W5500 supports spi mode 0 or 3
     *      cs(optional) - configured chip select pin
     *      reset(optional) - configured reset pin
     **************************************************************************/
    constructor(spi, cs = null, resetPin = null) {
        _spi = spi;
        _cs = cs;
        _resetPin = resetPin;

        _setMemDefaults();
    }

    // GETTERS AND SETTERS
    // ---------------------------------------------

    /***************************************************************************
     * setMode
     * Returns: this
     * Parameters:
     *      mode - select mode using MODE constants or-ed together
     **************************************************************************/
    function setMode(mode) {
        writeReg(MODE, COMMON_REGISTER, mode);
        return this;
    }

    /***************************************************************************
     * setSocketMode
     * Returns: this
     * Parameters:
     *      socket - select the socket using an integer 0-3
     *      mode - select mode using SOCKET_MODE constant
     **************************************************************************/
    function setSocketMode(socket, mode) {
        local bsb = _getSocketRegBlockSelectBit(socket)
        writeReg(SOCKET_MODE, bsb, mode);
        return this;
    }

    /***************************************************************************
     * setMemory
     * Returns: this
     * Parameters:
     *      memory - an array of four integers with the desired transmit memory
     *               allotment for each socket (supported values are 0, 1, 2, 4, 8, 16)
     *      dir - a string containing the transmition direction, accepted values
     *            are "tx" or "rx"
     **************************************************************************/
    function setMemory(memory, dir) {
        local memoryBufferSize = 16;
        local addr = (dir == "rx") ? SOCKET_RX_BUFFER_SIZE : SOCKET_TX_BUFFER_SIZE;

        local bits = 0x00;
        local total = 0;

        foreach (socket, mem_size in memory) {
            local socket_mem = 0x00;
            local bytes = 0;

            // adjust memory size if total memory is used up
            if ( total + mem_size > memoryBufferSize) {
                mem_size = memoryBufferSize - total;
                if (mem_size < 0) mem_size = 0;
            }

            if(mem_size == memoryBufferSize) {
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
            socketMemory[dir][socket] = bytes;
            local bsb = _getSocketRegBlockSelectBit(socket);
            writeReg(addr, bsb, mem_size);
        }
        return this;
    }

    /***************************************************************************
     * setGatewayAddr
     * Returns: this
     * Parameters:
     *      addr - an array of four integers with the gateway IP address
     **************************************************************************/
    function setGatewayAddr(addr) {
        writeReg(GATEWAY_ADDR_0, COMMON_REGISTER, addr[0]);
        writeReg(GATEWAY_ADDR_1, COMMON_REGISTER, addr[1]);
        writeReg(GATEWAY_ADDR_2, COMMON_REGISTER, addr[2]);
        writeReg(GATEWAY_ADDR_3, COMMON_REGISTER, addr[3]);
        return this;
    }

     /***************************************************************************
     * setSubnet
     * Returns: this
     * Parameters:
     *      addr - an array of four integers with the subnet address
     **************************************************************************/
    function setSubnet(addr) {
        writeReg(SUBNET_MASK_ADDR_0, COMMON_REGISTER, addr[0]);
        writeReg(SUBNET_MASK_ADDR_1, COMMON_REGISTER, addr[1]);
        writeReg(SUBNET_MASK_ADDR_2, COMMON_REGISTER, addr[2]);
        writeReg(SUBNET_MASK_ADDR_3, COMMON_REGISTER, addr[3]);
        return this;
    }

    /***************************************************************************
     * setSourceHWAddr
     * Returns: this
     * Parameters:
     *      addr - an array of 6 integers with the mac address for the
     *             source hardware
     **************************************************************************/
    function setSourceHWAddr(addr) {
        writeReg(SOURCE_HW_ADDR_0, COMMON_REGISTER, addr[0]);
        writeReg(SOURCE_HW_ADDR_1, COMMON_REGISTER, addr[1]);
        writeReg(SOURCE_HW_ADDR_2, COMMON_REGISTER, addr[2]);
        writeReg(SOURCE_HW_ADDR_3, COMMON_REGISTER, addr[3]);
        writeReg(SOURCE_HW_ADDR_4, COMMON_REGISTER, addr[4]);
        writeReg(SOURCE_HW_ADDR_5, COMMON_REGISTER, addr[5]);
        return this;
    }

    /***************************************************************************
     * setSourceIP
     * Returns: this
     * Parameters:
     *      addr - an array of 4 integers with the IP address for the
     *             source hardware
     **************************************************************************/
    function setSourceIP(addr) {
        writeReg(SOURCE_IP_ADDR_0, COMMON_REGISTER, addr[0]);
        writeReg(SOURCE_IP_ADDR_1, COMMON_REGISTER, addr[1]);
        writeReg(SOURCE_IP_ADDR_2, COMMON_REGISTER, addr[2]);
        writeReg(SOURCE_IP_ADDR_3, COMMON_REGISTER, addr[3]);
        return this;
    }

    /***************************************************************************
     * setSourceIP
     * Returns: this
     * Parameters:
     *      socket - select the socket using an integer 0-3
     *      addr - an array of 2 integers with the port for the
     *             source hardware
     *             (ex: for port 4242, addr = [0x10, 0x92])
     **************************************************************************/
    function setSourcePort(socket, port) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        writeReg(SOCKET_SOURCE_PORT_0, bsb, port[0]);
        writeReg(SOCKET_SOURCE_PORT_1, bsb, port[1]);
        return this;
    }

    /***************************************************************************
     * setDestHWAddr
     * Returns: this
     * Parameters:
     *      socket - select the socket using an integer 0-3
     *      addr - an array of 6 integers with the mac address for the
     *             destination hardware
     **************************************************************************/
    function setDestHWAddr(socket, addr) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        writeReg(SOCKET_DEST_HW_ADDR_0, bsb, addr[0]);
        writeReg(SOCKET_DEST_HW_ADDR_1, bsb, addr[1]);
        writeReg(SOCKET_DEST_HW_ADDR_2, bsb, addr[2]);
        writeReg(SOCKET_DEST_HW_ADDR_3, bsb, addr[3]);
        writeReg(SOCKET_DEST_HW_ADDR_4, bsb, addr[4]);
        writeReg(SOCKET_DEST_HW_ADDR_5, bsb, addr[5]);
        return this;
    }

    /***************************************************************************
     * setDestIP
     * Returns: this
     * Parameters:
     *      socket - select the socket using an integer 0-3
     *      addr - an array of 4 integers with the IP address for the
     *             destination hardware
     **************************************************************************/
    function setDestIP(socket, addr) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        writeReg(SOCKET_DEST_IP_ADDR_0, bsb, addr[0]);
        writeReg(SOCKET_DEST_IP_ADDR_1, bsb, addr[1]);
        writeReg(SOCKET_DEST_IP_ADDR_2, bsb, addr[2]);
        writeReg(SOCKET_DEST_IP_ADDR_3, bsb, addr[3]);
        return this;
    }

    /***************************************************************************
     * setDestPort
     * Returns: this
     * Parameters:
     *      socket - select the socket using an integer 0-3
     *      addr - an array of 2 integers with the port for the
     *             destination hardware
     *             (ex: for port 4242, addr = [0x10, 0x92])
     **************************************************************************/
    function setDestPort(socket, port) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        writeReg(SOCKET_DEST_PORT_0, bsb, port[0]);
        writeReg(SOCKET_DEST_PORT_1, bsb, port[1]);
        return this;
    }

    /***************************************************************************
     * setRxReadPointer
     * Returns: this
     * Parameters:
     *      socket - select the socket using an integer 0-3
     *      value - new RX read pointer value
     **************************************************************************/
    function setRxReadPointer(socket, value) {
        local rx_pointer_r1 = (value & 0xFF00) >> 8;
        local rx_pointer_r2 = value & 0x00FF;
        local bsb = _getSocketRegBlockSelectBit(socket);
        writeReg(SOCKET_RX_RP_R1, bsb, rx_pointer_r1);
        writeReg(SOCKET_RX_RP_R2, bsb, rx_pointer_r2);
        return this;
    }

    /***************************************************************************
     * setTxWritePointer
     * Returns: this
     * Parameters:
     *      socket - select the socket using an integer 0-3
     *      value - new TX write pointer value
     **************************************************************************/
    function setTxWritePointer(socket, value) {
        local tx_pointer_r1 = (value & 0xFF00) >> 8;
        local tx_pointer_r2 = value & 0x00FF;
        local bsb = _getSocketRegBlockSelectBit(socket);
        writeReg(SOCKET_TX_WP_R1, bsb, tx_pointer_r1);
        writeReg(SOCKET_TX_WP_R2, bsb, tx_pointer_r2);
        return this;
    }

    /***************************************************************************
     * getSocketStatus
     * Returns: integer with the connection status for the socket passed in
     * Parameters:
     *      socket - select the socket using an integer 0-3
     **************************************************************************/
    function getSocketStatus(socket) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        return readReg(SOCKET_STATUS, bsb);
    }

    /***************************************************************************
     * getRxReadPointer
     * Returns: value of read pointer
     * Parameters:
     *      socket - select the socket using an integer 0-3
     **************************************************************************/
    function getRxReadPointer(socket) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        local rx_pointer_pt1 = readReg(SOCKET_RX_RP_R1, bsb) << 8;
        local rx_pointer_pt2 = readReg(SOCKET_RX_RP_R2, bsb);

        return rx_pointer_pt1 | rx_pointer_pt2;
    }

    /***************************************************************************
     * getTxReadPointer
     * Returns: value of read pointer
     * Parameters:
     *      socket - select the socket using an integer 0-3
     **************************************************************************/
    function getTxReadPointer(socket) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        local tx_pointer_pt1 = readReg(SOCKET_TX_RP_R1, bsb) << 8;
        local tx_pointer_pt2 = readReg(SOCKET_TX_RP_R2, bsb);

        return tx_pointer_pt1 | tx_pointer_pt2;
    }

    /***************************************************************************
     * getRxDataSize
     * Returns: value of received data size register
     * Parameters:
     *      socket - select the socket using an integer 0-3
     **************************************************************************/
    function getRxDataSize(socket) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        local rx_pt1 = readReg(SOCKET_RX_SIZE_R1, bsb) << 8;
        local rx_pt2 = readReg(SOCKET_RX_SIZE_R2, bsb);

        return rx_pt1 | rx_pt2;
    }

    /***************************************************************************
     * getFreeTxDataSize
     * Returns: value of TX data free size register
     * Parameters:
     *      socket - select the socket using an integer 0-3
     **************************************************************************/
    function getFreeTxDataSize(socket) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        local tx_fd_pt1 = readReg(SOCKET_TX_SIZE_R1, bsb) << 8;
        local tx_fd_pt2 = readReg(SOCKET_TX_SIZE_R2, bsb);

        return tx_fd_pt1 | tx_fd_pt2;
    }

    /***************************************************************************
     * getSocketRXBufferSize
     * Returns: value of RX data buffer size register
     * Parameters:
     *      socket - select the socket using an integer 0-3
     **************************************************************************/
    function getSocketRXBufferSize(socket) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        return readReg(SOCKET_RX_BUFFER_SIZE, bsb);
    }

    /***************************************************************************
     * getSocketTXBufferSize
     * Returns: value of TX data buffer size register
     * Parameters:
     *      socket - select the socket using an integer 0-3
     **************************************************************************/
    function getSocketTXBufferSize(socket) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        return readReg(SOCKET_TX_BUFFER_SIZE, bsb);
    }

    /***************************************************************************
     * getChipVersion
     * Returns: chip version (should be 0x04 for the W5500)
     * Parameters: none
     **************************************************************************/
    function getChipVersion() {
        server.log("getting chip version");
        return readReg(CHIP_VERSION, COMMON_REGISTER);
    }

    /***************************************************************************
     * getTotalSupportedSockets
     * Returns: number of sockets the driver code currently supports
     * Parameters: none
     **************************************************************************/
    function getTotalSupportedSockets() {
        return TOTAL_SUPPORTED_SOCKETS;
    }

    /***************************************************************************
     * getMemoryInfo
     * Returns: table with memory maximums and supported memory block sizes
     * Parameters: none
     **************************************************************************/
    function getMemoryInfo() {
        // mem_block_sizes - an array with supported values highest to lowest
        return {"tx_max" : MAX_TX_MEM_BUFFER, "rx_max": MAX_RX_MEM_BUFFER, "mem_block_sizes" : [16, 8, 4, 2, 1, 0]}
    }


    // TRANSMISSION FUNCTIONS
    // ---------------------------------------------

    /***************************************************************************
     * sendSocketCommand
     * Returns: this
     * Parameters:
     *      socket - select the socket using an integer 0-3
     *      command - select command using SOCKET_COMMANDS constant
     **************************************************************************/
    function sendSocketCommand(socket, command) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        writeReg(SOCKET_COMMAND, bsb, command);
        return this;
    }

    /***************************************************************************
     * readRxData
     * Returns: data from received data register
     * Parameters:
     *      socket - select the socket using an integer 0-3
     **************************************************************************/
    function readRxData(socket) {
        // get the received data size
        local dataSize = getRxDataSize(socket);
        // TODO: check dataSize is within range of avail memory - throw error

        // select RX memory
        local cntl_byte = getSocketRXBufferSize(socket);
        // Get offset address
        local src_ptr = getRxReadPointer(socket);
        //  get Block select bit for RX buffer
        local bsb = _getSocketRXBufferBlockSelectBit(socket);

        // use cntl_byte and src_ptr to get addr??
        // read transmitted data here
        local data = _readData(src_ptr, bsb, dataSize);

        // increase Sn_RX_RD as length of len
        src_ptr += dataSize;
        setRxReadPointer(socket, src_ptr);

        // set RECV command
        sendSocketCommand(socket, SOCKET_RECEIVE);

        return data;
    }

    /***************************************************************************
     * sendTxData
     * Returns: length of data to transmit
     * Parameters:
     *      socket - select the socket using an integer 0-3
     *      transmitData - data to be sent
     **************************************************************************/
    function sendTxData(socket, transmitData) {
        local tx_length = transmitData.len();

        // check transmission data size
        if (tx_length > socketMemory.tx[socket]) {
            server.error("Transmit data larger than socket transmit buffer.");
            return
            // TODO: if data is too large chunk and send
        }

        // select TX memory
        local cntl_byte = getSocketTXBufferSize(socket);
        // Get offset address
        local dst_ptr = getTxReadPointer(socket); //Sn_TX_RD;
        //  get Block select bit for RX buffer
        local bsb = _getSocketTXBufferBlockSelectBit(socket);

        // write transmit data
        _writeData(dst_ptr, bsb, transmitData);

        // increase Sn_TX_WR as length of send_size
        dst_ptr += tx_length; // adjust write pointer get first??
        setTxWritePointer(socket, dst_ptr);

        // set SEND command
        sendSocketCommand(socket, SOCKET_SEND);

        return tx_length;
    }


    // INTERRUPT FUNCTIONS
    // ---------------------------------------------

    /***************************************************************************
     * setInterrupt
     * Returns: this
     * Parameters:
     *      type - select interrupt type using interrupt type
     *             constants or-ed together
     **************************************************************************/
    function setInterrupt(type) {
        writeReg(INTERRUPT_MASK, COMMON_REGISTER, type);
        return this;
    }

    /***************************************************************************
     * clearInterrupt
     * Returns: this
     * Parameters:
     *      type(optional) - clear specified interrupt type
     *                               if nothing passed in clears all interrupts
     **************************************************************************/
    function clearInterrupt(type = 0xF0) {
        writeReg(INTERRUPT, COMMON_REGISTER, type);
        return this;
    }

    /***************************************************************************
     * setSocketInterrupt
     * Returns: this
     * Parameters:
     *      socketInt - select the sockets to enable interrupts on using
     *                  SOCKET INTERRUPTS constants or-ed together
     *      type(optional) - select SOCKET INTERRUPT TYPES using constants
     *              or-ed together, if type not passed in all type interrupts
     *              will be cleared.
     **************************************************************************/
    function setSocketInterrupt(socketInt, type = 0x1F) {
        writeReg(SOCKET_INTERRUPT_MASK, COMMON_REGISTER, socketInt);
        // default enables all socket interrupt types
        writeReg(SOCKET_N_INTERRUPT_MASK, COMMON_REGISTER, type);
        return this;
    }


    /***************************************************************************
     * clearSocketInterrupt
     * Returns: this
     * Parameters:
     *      socket : socket (selected by integer) to clear interrupt on
     *      type(optional) - clear specified interrupt type
     *                       if nothing passed in clears all interrupts
     **************************************************************************/
    function clearSocketInterrupt(socket, type = 0x1F) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        writeReg(SOCKET_N_INTERRUPT, bsb, type);
        return this;
    }

    /***************************************************************************
     * getInterruptStatus
     * Returns: interrupt status table
     * Parameters: none
     **************************************************************************/
    function getInterruptStatus() {
        local status = readReg(INTERRUPT, COMMON_REGISTER);
        local intStatus = {
            "CONFLICT" : status & CONFLICT_INT_TYPE ? true : false,
            "UNREACH" : status & UNREACH_INT_TYPE ? true : false,
            "PPPoE" : status & PPPoE_INT_TYPE ? true : false,
            "MAGIC_PACKET" : status & MAGIC_PACKET_TYPE ? true : false,
            "REGISTER_VALUE" : status
        };
        return intStatus;
    }

    /***************************************************************************
     * getSocketInterruptStatus
     * Returns: interrupt status table
     * Parameters: none
     **************************************************************************/
    function getSocketInterruptStatus() {
        local status = readReg(SOCKET_INTERRUPT, COMMON_REGISTER);
        local intStatus = {
            "SOCKET_7" : status & S7_INTERRUPT ? true : false,
            "SOCKET_6" : status & S6_INTERRUPT ? true : false,
            "SOCKET_5" : status & S5_INTERRUPT ? true : false,
            "SOCKET_4" : status & S4_INTERRUPT ? true : false,
            "SOCKET_3" : status & S3_INTERRUPT ? true : false,
            "SOCKET_2" : status & S2_INTERRUPT ? true : false,
            "SOCKET_1" : status & S1_INTERRUPT ? true : false,
            "SOCKET_0" : status & S0_INTERRUPT ? true : false,
            "REGISTER_VALUE" : status
        };
        return intStatus;
    }

    /***************************************************************************
     * getSocketInterruptTypeStatus
     * Returns: socket interrupt status table
     * Parameters:
     *      socket - select the socket using an integer 0-3
     **************************************************************************/
    function getSocketInterruptTypeStatus(socket) {
        local bsb = _getSocketRegBlockSelectBit(socket);
        local status = readReg(SOCKET_N_INTERRUPT,  bsb);
        local intStatus = {
            "SEND_COMPLETE" : status & SEND_COMPLETE_INT_TYPE ? true : false,
            "TIMEOUT" : status & TIMEOUT_INT_TYPE ? true : false,
            "DATA_RECEIVED" : status & DATA_RECEIVED_INT_TYPE ? true : false,
            "DISCONNECTED" : status & DISCONNECTED_INT_TYPE ? true : false,
            "CONNECTED" : status & CONNECTED_INT_TYPE ? true : false,
            "REGISTER_VALUE" : status
        };
        return intStatus;
    }


    // SPI FUNCTIONS
    // ---------------------------------------------

     /***************************************************************************
     * readReg
     * Returns: data stored at the specified register
     * Parameters:
     *      reg - register to read
     **************************************************************************/
    function readReg(addr, bsb) {
        local b = blob();
        local cp = bsb | READ_COMMAND | VARIABLE_DATA_LENGTH;
        local res = blob();

        (_cs) ? _cs.write(0) : _spi.chipselect(1);

        b.writen(addr >> 8, 'b');
        b.writen(addr & 0xFF, 'b');
        b.writen(cp, 'b');
        b.writen(0x00, 'b');

        res = _spi.writeread(b);

        (_cs) ? _cs.write(1) : _spi.chipselect(0);

        return res[3];
    }

    /***************************************************************************
     * writeReg
     * Returns: null
     * Parameters:
     *      reg - register to write to
     *      value - data to write to register
     **************************************************************************/
    function writeReg(addr, bsb, value) {
        local b = blob();
        local cp = bsb | WRITE_COMMAND | VARIABLE_DATA_LENGTH;

        (_cs) ? _cs.write(0) : _spi.chipselect(1);

        b.writen(addr >> 8, 'b');
        b.writen(addr & 0xFF, 'b');
        b.writen(cp, 'b');
        b.writen(value, 'b');

        _spi.write(b);

        (_cs) ? _cs.write(1) : _spi.chipselect(0);
    }


    // RESET FUNCTION
    // ---------------------------------------------

    /***************************************************************************
     * reset, note this is blocking for 0.2s
     * Returns: this
     * Parameters:
     *          sw(optional) - boolean if true forces a software reset
     *          Note: datasheet for W5500 states that software reset is
     *                unreliable - don't use
     **************************************************************************/
    function reset(sw = false) {
        if (sw || _resetPin == null) {
            setMode(SW_RESET);
            imp.sleep(0.2);
        } else {
            _resetPin.write(0);
            imp.sleep(0.001); // hold at least 500us after assert low
            _resetPin.write(1);
            imp.sleep(0.2); // wait at least 150ms before configuring
        }
        _setMemDefaults();
        return this;
    }


    // PRIVATE FUNCTIONS
    // ---------------------------------------------

    /***************************************************************************
     * _getSocketRegBlockSelectBit
     * Returns: the socket register Control Phase Block Select Bit for the socket passed in
     * Parameters:
     *      socket - select the socket using an integer 0-3
     **************************************************************************/
    function _getSocketRegBlockSelectBit(socket) {
        local bsb = null;
        switch(socket) {
            case 0:
                bsb = S0_REGISTER;
                break;
            case 1:
                bsb = S1_REGISTER;
                break;
            case 2:
                bsb = S2_REGISTER;
                break;
            case 3:
                bsb = S3_REGISTER;
                break;
        }
        return bsb;
    }

    /***************************************************************************
     * _getSocketRXBufferBlockSelectBit
     * Returns: the socket RX buffer Control Phase Block Select Bit for the socket passed in
     * Parameters:
     *      socket - select the socket using an integer 0-3
     **************************************************************************/
    function _getSocketRXBufferBlockSelectBit(socket) {
        local bsb = null;
        switch(socket) {
            case 0:
                bsb = S0_RX_BUFFER;
                break;
            case 1:
                bsb = S1_RX_BUFFER;
                break;
            case 2:
                bsb = S2_RX_BUFFER;
                break;
            case 3:
                bsb = S3_RX_BUFFER;
                break;
        }
        return bsb;
    }

    /***************************************************************************
     * _getSocketRXBufferBlockSelectBit
     * Returns: the socket TX buffer Control Phase Block Select Bit for the socket passed in
     * Parameters:
     *      socket - select the socket using an integer 0-3
     **************************************************************************/
    function _getSocketTXBufferBlockSelectBit(socket) {
        local bsb = null;
        switch(socket) {
            case 0:
                bsb = S0_TX_BUFFER;
                break;
            case 1:
                bsb = S1_TX_BUFFER;
                break;
            case 2:
                bsb = S2_TX_BUFFER;
                break;
            case 3:
                bsb = S3_TX_BUFFER;
                break;
        }
        return bsb;
    }


    // MEMORY FUNCTIONS

    /***************************************************************************
     * _setMemDefaults, sets locally stored default socket memory info
     * Returns: null
     * Parameters: none
     **************************************************************************/
    function _setMemDefaults() {
        socketMemory = { "rx" : [2048, 2048, 2048, 2048],
                         "tx" : [2048, 2048, 2048, 2048]
                       }
    }


    // TRANSMITION FUNCTIONS

    /***************************************************************************
     * _writeData, writes data to transmit memory buffer
     * Returns: size of data written
     * Parameters:
     *      addr - offset address to start the data write
     *      bsb - socket tx buffer block select bit
     *      data - data to be written
     **************************************************************************/
    function _writeData(addr, bsb, data) {
        foreach (item in data) {
            writeReg(addr, bsb, item);
            addr++;
        }

        return data.len();
    }

    /***************************************************************************
     * _readData
     * Returns: blob containing data from memory buffer
     * Parameters:
     *      addr - offset address to start the read
     *      bsb - block select bit for the socket rx buffer
     *      size - size of data to be written
     **************************************************************************/
    function _readData(addr, bsb, size) {
        local b = blob();

        while (size != 0) {
            b.writen(readReg(addr, bsb), 'b');
            addr++;
            size--;
        }

        return b
    }


    // DEBUG/LOGGING FUNCTIONS

    function _logGatewayIP() {
        server.log("----------------------------------")
        server.log( format("Gateway IP: %i.%i.%i.%i", readReg(GATEWAY_ADDR_0, COMMON_REGISTER), readReg(GATEWAY_ADDR_1, COMMON_REGISTER), readReg(GATEWAY_ADDR_2, COMMON_REGISTER), readReg(GATEWAY_ADDR_3, COMMON_REGISTER)) )
        server.log("----------------------------------")
    }

    function _logSourceAddr() {
        server.log("----------------------------------")
        server.log( format("Source Mac Addr: %02X %02X %02X %02X %02X %02X", readReg(SOURCE_HW_ADDR_0, COMMON_REGISTER), readReg(SOURCE_HW_ADDR_1, COMMON_REGISTER), readReg(SOURCE_HW_ADDR_2, COMMON_REGISTER), readReg(SOURCE_HW_ADDR_3, COMMON_REGISTER), readReg(SOURCE_HW_ADDR_4, COMMON_REGISTER), readReg(SOURCE_HW_ADDR_5, COMMON_REGISTER)) )
        server.log("----------------------------------")
    }

    function _logSubnet() {
        server.log("----------------------------------")
        server.log( format("Subnet Addr: %i.%i.%i.%i", readReg(SUBNET_MASK_ADDR_0, COMMON_REGISTER), readReg(SUBNET_MASK_ADDR_1, COMMON_REGISTER), readReg(SUBNET_MASK_ADDR_2, COMMON_REGISTER), readReg(SUBNET_MASK_ADDR_3, COMMON_REGISTER)) )
        server.log("----------------------------------")
    }

    function _logSourceIP() {
        server.log("----------------------------------")
        server.log( format("Source IP: %i.%i.%i.%i", readReg(SOURCE_IP_ADDR_0, COMMON_REGISTER), readReg(SOURCE_IP_ADDR_1, COMMON_REGISTER), readReg(SOURCE_IP_ADDR_2, COMMON_REGISTER), readReg(SOURCE_IP_ADDR_3, COMMON_REGISTER)) )
        server.log("----------------------------------")
    }

    function _logS0SourcePort() {
        local bsb = _getSocketRegBlockSelectBit(0);
        local p1 = readReg(SOCKET_SOURCE_PORT_0, bsb);
        local p2 = readReg(SOCKET_SOURCE_PORT_1, bsb);
        local port = (p1 * 256) + p2;
        server.log("----------------------------------")
        server.log( format("Source Port: %i", port) )
        server.log("----------------------------------")
    }

    function _logS0DestPort() {
        local bsb = _getSocketRegBlockSelectBit(0);
        local p1 = readReg(SOCKET_DEST_PORT_0, bsb);
        local p2 = readReg(SOCKET_DEST_PORT_1, bsb);
        local port = (p1 * 256) + p2;
        server.log("----------------------------------")
        server.log( format("Destination Port: %i", port) )
        server.log("----------------------------------")
    }

    function _logS0DestIP() {
        local bsb = _getSocketRegBlockSelectBit(0);
        server.log("----------------------------------")
        server.log( format("Destination IP: %i.%i.%i.%i", readReg(SOCKET_DEST_IP_ADDR_0, bsb), readReg(SOCKET_DEST_IP_ADDR_1, bsb), readReg(SOCKET_DEST_IP_ADDR_2, bsb), readReg(SOCKET_DEST_IP_ADDR_3, bsb)) )
        server.log("----------------------------------")
    }
}

class W5500.API {

    _wiz = null;
    _interruptPin = null;

    timer = null;

    _totalSockets = null;
    _avaiableConnections = null; // number of sockets available
    _connections = null;
    _socketConnectionState = null;
    _cleanupCounter = null;

    /***************************************************************************
     * Constructor
     * Returns: null
     * Parameters:
     *      spi - configured spi bus, chip supports spi mode 0 or 3
     *      interruptPin - inerrupt pin
     *      cs(optional) -  chip select pin, pass in if not using imp005
     *      reset(optional) - reset pin
     **************************************************************************/
    constructor(spi, interruptPin, csPin = null, resetPin = null) {
        local imp005 = ("spi0" in hardware);

        if (csPin != null) {
            csPin.configure(DIGITAL_OUT, 1);
        } else if (!imp005) {
            throw "Error: You must pass in a chip select pin."
            return;
        }

        if (resetPin) resetPin.configure(DIGITAL_OUT, 1);

        _wiz = W5500.Driver(spi, csPin, resetPin);

        _createConnectionStateArray();
        _cleanupCounter = 0;
        _cleanup(); // close stale connections

        _cleanupWatchdog(function() {
            // Reset chip to default state, blocks for 0.2s
            // Note: Datasheet states that W5500 software reset
            //       is not reliable, use hardware reset.
            reset();

            // Configure number of connections (sets up default memory and interrupts)
            _connections = {};
            setNumberOfAvailbleConnections(1);

            // Configure interrupts
            _setDefaultInterrupts();
            _clearAllInterrupts();
            _interruptPin = interruptPin.configure(DIGITAL_IN_PULLUP, _interruptHandler.bindenv(this));
        })
    }

    // SETUP FUNCTIONS
    // ---------------------------------------------

    /***************************************************************************
     * configureNetworkSettings
     * Returns: this
     * Parameters:
     *      networkSettings - table with keys: gatewayIP, sourceAddr, subnet, sourceIP
     *                        values are arrays of integers
     **************************************************************************/
    function configureNetworkSettings(networkSettings) {
        if ("gatewayIP" in networkSettings) _wiz.setGatewayAddr(networkSettings.gatewayIP);
        if ("sourceAddr" in networkSettings) _wiz.setSourceHWAddr(networkSettings.sourceAddr);
        if ("subnet" in networkSettings) _wiz.setSubnet(networkSettings.subnet);
        if ("sourceIP" in networkSettings) _wiz.setSourceIP(networkSettings.sourceIP);
        return this;
    }

    /***************************************************************************
     * setReceiveCallback
     * Returns: this
     * Parameters:
     *      connection - connection instance to set callback on
     *      cb - function to be called when data is received
     **************************************************************************/
    function setReceiveCallback(connection, cb) {
        connection.setReceiveHandler(cb);
        return this;
    }

    /***************************************************************************
     * setDisconnectCallback
     * Returns: this
     * Parameters:
     *      connection - connection instance to set callback on
     *      cb - function to be called when disconnect interrupt triggered
     **************************************************************************/
    function setDisconnectCallback(connection, cb) {
        connection.setDisconnectHandler(cb);
        return this;
    }

    /***************************************************************************
     * setNumConnections - configures interrupts and memory for each connection
     * Returns: number of actual connections configured
     * Parameters:
     *      numConnections - number of desired connections
     **************************************************************************/
    function setNumberOfAvailbleConnections(numConnections) {
        // limit number of connections to what driver can support
        if (numConnections < 1) numConnections = 1;
        if (numConnections > _totalSockets ) numConnections = _totalSockets;

        // calculate max memory for number of connections
        local memoryInfo = _wiz.getMemoryInfo();
        local tx_mem = _getMaxMemValue(numConnections, memoryInfo.tx_max, memoryInfo.mem_block_sizes);
        local rx_mem = _getMaxMemValue(numConnections, memoryInfo.rx_max, memoryInfo.mem_block_sizes);

        // Enable interrupt for each connection
        // Set max equal memory accross connections
        switch (numConnections) {
            case 1:
                _avaiableConnections = [0];
                _wiz.setSocketInterrupt(S0_INTERRUPT);
                _configureSocketMemory([tx_mem, 0, 0, 0], [rx_mem, 0, 0, 0]);
                break;
            case 2:
                _avaiableConnections = [1, 0];
                _wiz.setSocketInterrupt(S0_INTERRUPT | S1_INTERRUPT);
                _configureSocketMemory([tx_mem, tx_mem, 0, 0], [rx_mem, rx_mem, 0, 0]);
                break;
            case 3:
                _avaiableConnections = [2, 1, 0];
                _wiz.setSocketInterrupt(S0_INTERRUPT | S1_INTERRUPT | S2_INTERRUPT);
                _configureSocketMemory([tx_mem, tx_mem, tx_mem, 0], [rx_mem, rx_mem, rx_mem, 0]);
                break;
            case 4:
                _avaiableConnections = [3, 2, 1, 0];
                _wiz.setSocketInterrupt(S0_INTERRUPT | S1_INTERRUPT | S2_INTERRUPT | S3_INTERRUPT);
                _configureSocketMemory([tx_mem, tx_mem, tx_mem, tx_mem], [rx_mem, rx_mem, rx_mem, rx_mem]);
                break;
        }
        return numConnections;
    }


    // CONNECTION FUNCTIONS
    // ---------------------------------------------

    /***************************************************************************
     * openConnection
     * Returns: connection instance
     * Parameters:
     *      connectionSettings - table with keys: socket, destIP, destPort,
     *                                            mode(optional - only TCP supported)
     *      cb(optional) - function to be called when connection successfully
     *                     established or a timeout has occurred
     **************************************************************************/
    function openConnection(connectionSettings, cb = null) {
        // check for required parameters
        if (_avaiableConnections.len() < 1) throw "Cannot open a connection.  All connection sockets in use.";
        if (!("destIP" in connectionSettings)) throw "Cannot open a connection. Missing: Destination IP Address.";
        if (!("destPort" in connectionSettings)) throw "Cannot open a connection. Missing: Destination Port.";

        local socket = _avaiableConnections.pop();
        connectionSettings.sourcePort <- _returnRandomPort(1024, 65535); // creates a random port between 1024-65535

        if ("socketMode" in connectionSettings) {
            _wiz.setSocketMode(socket, connectionSettings.socketMode);
        }  else {
            _wiz.setSocketMode(socket, SOCKET_MODE_TCP);
        }

        // Open socket connection
        _socketConnectionState[socket] = "CONNECTING";
        _wiz.setSourcePort(socket, connectionSettings.sourcePort);
        _wiz.sendSocketCommand(socket, SOCKET_OPEN);

        // Connect
        _wiz.setDestIP(socket, connectionSettings.destIP);
        _wiz.setDestPort(socket, connectionSettings.destPort);
        imp.sleep(1);
        _wiz.sendSocketCommand(socket, SOCKET_CONNECT);

        // Create connection object & handler
        local connection = W5500.Connection(socket, _socketConnectionState[socket], connectionSettings);
        _connections[socket] <- connection;
        if (cb) connection.setConnectHandler(cb);

        return connection;
    }


    /***************************************************************************
     * closeConnection
     * Returns: this
     * Parameters:
     *      connection - connection instance to close the connection on
     **************************************************************************/
    function closeConnection(connection) {
        _wiz.sendSocketCommand(connection.socket, SOCKET_DISCONNECT);
        _updateConnectionState(connection, "DISCONNECTING");
        return this;
    }


    // TRANSMISSION FUNCTIONS
    // ---------------------------------------------

    /***************************************************************************
     * transmit
     * Returns: this
     * Parameters:
     *      connection - connection instance to transmit data on
     *      transmitData - array/blob of data to transmit
     *      cb(optional) - function to be called when data successfully
     *                      sent or timeout has occurred
     **************************************************************************/
    function transmit(connection, transmitData, cb = null) {
        local socket = connection.socket;
        local receiveHandler = connection.getHandler("receive");

        if (_socketConnectionState[socket] == "ESTABLISHED") {
            connection.setTransmitHandler(cb);
            if (dataWaiting(socket) && receiveHandler) {
                receiveHandler(null, socket, _wiz.readRxData(socket));
            }
            _wiz.sendTxData(socket, transmitData);
        } else {
            if (cb) {
                imp.wakeup(0, function() {
                    cb("Error: Connection not established.", connection);
                }.bindenv(this));
            }
        }
        return this;
    }

    /***************************************************************************
     * receive
     * Returns: this
     * Parameters:
     *      connection - connection instance to check for received data on
     *      cb(optional) - callback to pass receive data to
     *                     (note: if callback is passed in it will superceede
     *                     the callback set by setReceiveCallback, and will be
     *                     used only for during this check for data)
     **************************************************************************/
    function receive(connection, cb = null) {
        local socket = connection.socket;
        local receiveHandler = connection.getHandler("receive");

        if (_socketConnectionState[socket] == "ESTABLISHED") {
            if ( dataWaiting(socket) ) {
                if(cb) {
                    imp.wakeup(0, function() {
                        cb(null, socket, _wiz.readRxData(socket));
                    }.bindenv(this));
                } else if (receiveHandler) {
                    imp.wakeup(0, function() {
                        receiveHandler(null, socket, _wiz.readRxData(socket));
                    }.bindenv(this));
                }
            }
        } else {
             if (cb) {
                imp.wakeup(0, function() {
                    cb("Error: Connection not established.", connection, null);
                }.bindenv(this));
            } else if (receiveHandler) {
                imp.wakeup(0, function() {
                    receiveHandler("Error: Connection not established.", connection, null);
                }.bindenv(this));
            }
        }
        return this;
    }


    // HELPER FUNCTIONS
    // ---------------------------------------------

    /***************************************************************************
     * reset, note this is blocking for 0.2s
     * Returns: this
     * Parameters:
     *          sw(optional) - boolean if true forces a software reset
     *          Note: Datasheet states that SW reset should not be used
     *                 on the W5500.
     **************************************************************************/
    function reset(sw = false) {
        _wiz.reset(sw);
    }

    /***************************************************************************
     * dataWaiting
     * Returns: boolean
     * Parameters:
     *      socket - connection socket
     **************************************************************************/
    function dataWaiting(socket) {
        return (_wiz.getRxDataSize(socket) == 0x00) ? false : true;
    }

    /***************************************************************************
     * connectionEstablished
     * Returns: boolean
     * Parameters:
     *      socket - connection socket
     **************************************************************************/
    function connectionEstablished(socket) {
        return (_wiz.getSocketStatus(socket) == SOCKET_STATUS_ESTABLISHED) ? true : false;
    }


    // PRIVATE FUNCTIONS
    // ---------------------------------------------

    /***************************************************************************
     * _setDefaultInterrupts: conflict
     * Returns: this
     * Parameters: NONE
     **************************************************************************/
    function _setDefaultInterrupts() {
        _wiz.setInterrupt(CONFLICT_INT_TYPE);
        return this;
    }

    /***************************************************************************
     * _getMaxMemValue
     * Returns: max memory value
     * Parameters:
     *      numValues - number of memory slots
     *      max - max memory available
     *      blockSizes - array of supported memory sizes
     **************************************************************************/
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

    /***************************************************************************
     * _configureSocketMemory
     * Returns: this
     * Parameters:
     *      txMem - an array of four integers with the desired transmit memory
     *                    allotment for each socket
     *      rxMem - an array of four integers with the desired receive memory
     *                    allotment for each socket
     **************************************************************************/
    function _configureSocketMemory(txMem, rxMem) {
        _wiz.setMemory(txMem, "tx");
        _wiz.setMemory(rxMem, "rx");
        return this;
    }

    /***************************************************************************
     * _returnRandomPort
     * Returns: an array with a random port between min and max
     * Parameters:
     *      min - lowest possible port number
     *      max - highest possible port number
     **************************************************************************/
    function _returnRandomPort(min, max) {
        local port = (1.0 * math.rand() / RAND_MAX) * (max + 1 - min);
        port = port.tointeger() + min;

        local p1 = port >> 8;
        local p2 = port & 0xFF;

        return [p1, p2];
    }

    /***************************************************************************
     * _createConnectionStateArray, sets local connection state for all sockets
     *                              to null
     * Returns: this
     * Parameters: none
     **************************************************************************/
    function _createConnectionStateArray() {
        _socketConnectionState = [];
        _totalSockets = _wiz.getTotalSupportedSockets();
        for (local socket = 0; socket < _totalSockets ; socket++) {
            _socketConnectionState.push(null);
        }
        return this;
    }

    /***************************************************************************
     * _cleanup, if any sockets have open connections it disconnects them
     * Returns: null
     * Parameters: none
     **************************************************************************/
    function _cleanup() {
        // close any sockets that have open connections
        for (local socket = 0; socket < _totalSockets ; socket++) {
            if( connectionEstablished(socket) ) {
                _wiz.sendSocketCommand(socket, SOCKET_DISCONNECT);
                imp.sleep(0.01);
                _closeSocket(socket);
            } else {
                _socketConnectionState[socket] = "CLOSED";
                _cleanupCounter++;
            }
        }

    }

    /***************************************************************************
     * _closeSocket, confirms socket has been successfully disconnected
     *               then closes(will loop until disconnect successful)
     * Returns: null
     * Parameters:
     *      socket - connection socket to close connection on
     **************************************************************************/
    function _closeSocket(socket) {
        if ( _wiz.getSocketStatus(socket) != SOCKET_STATUS_CLOSED) {
            imp.sleep(0.01);
            _closeSocket(socket);
        } else {
            _wiz.sendSocketCommand(socket, SOCKET_CLOSE);
            _socketConnectionState[socket] = "CLOSED";
            _cleanupCounter++;
        }
    }

    /***************************************************************************
     * _cleanupWatchdog, confirms all sockets have been disconnected before
     *                   executing callback
     * Returns: null
     * Parameters:
     *      cb - function to run when all connections have been closed.
     **************************************************************************/
    function _cleanupWatchdog(cb) {
        if (_cleanupCounter < _totalSockets) {
            imp.sleep(0.01);
            _cleanupWatchdog(cb);
        } else {
            _cleanupCounter = 0;
            cb();
        }
    }

    /***************************************************************************
     * _updateConnectionState - updates locally and connection instance
     * Returns: this
     * Parameters:
     *      conneciton - conneciton instance
     *      state - new state of connection
     **************************************************************************/
    function _updateConnectionState(connection, state) {
        _socketConnectionState[connection.socket] = state;
        connection.setState(state);
        return this;
    }


    // PRIVATE INTERRUPT FUNCTIONS
    // ---------------------------------------------

    /***************************************************************************
     * _interruptHandler, checks interrupt registers and calls appropriate
     *                    handlers
     * Returns: null
     * Parameters: none
     **************************************************************************/
    function _interruptHandler() {
        local status = _wiz.getInterruptStatus();
        if (status.CONFLICT) _handleConflictInt();

        local status = _wiz.getSocketInterruptStatus();
        if (status.SOCKET_0) _handleSocketInt(0);
        if (status.SOCKET_1) _handleSocketInt(1);
        if (status.SOCKET_2) _handleSocketInt(2);
        if (status.SOCKET_3) _handleSocketInt(3);
    }

    /***************************************************************************
     * _handleConflictInt, logs conflict error message & clears interrupt
     * Returns: null
     * Parameters: none
     **************************************************************************/
    function _handleConflictInt() {
        _wiz.clearInterrupt(CONFLICT_INT_TYPE);
        server.error("Conflict Interrupt Occured.  Please check IP Source and Destination addressess.");
    }

    /***************************************************************************
     * _handleSocketInt, handles/clears the specified socket interrupt
     * Returns: null
     * Parameters: socket the interrupt occurred on
     **************************************************************************/
    function _handleSocketInt(socket) {
        local status = _wiz.getSocketInterruptTypeStatus(socket);
        local connection = _connections[socket];

        if (status.CONNECTED) {
            server.log("Connection established on socket " + socket);
            _wiz.clearSocketInterrupt(socket, CONNECTED_INT_TYPE);

            _updateConnectionState(connection, "ESTABLISHED");

            local _connectionCallback = connection.getHandler("connect");
            if (_connectionCallback) {
                connection.setConnectHandler(null);

                imp.wakeup(0, function() {
                    _connectionCallback(null, connection);
                }.bindenv(this))
            }
        }
        if (status.DISCONNECTED) {
            server.log("Connection disconnected on socket " + socket);
            _wiz.clearSocketInterrupt(socket, DISCONNECTED_INT_TYPE);

            _wiz.sendSocketCommand(socket, SOCKET_CLOSE);
            _updateConnectionState(connection, "CLOSED");
            _connections.rawdelete(connection.socket);
            _avaiableConnections.push(socket);

            // clear transmit and connection callbacks
            connection.setTransmitHandler(null);
            connection.setConnectHandler(null);

            local _disconnectCallback = connection.getHandler("disconnect");
            // call disconnected callback
            if (_disconnectCallback) {
                imp.wakeup(0, function() {
                    _disconnectCallback(connection);
                }.bindenv(this));
            }
        }
        if (status.SEND_COMPLETE) {
            server.log("Send complete on socket " + socket);
            _wiz.clearSocketInterrupt(socket, SEND_COMPLETE_INT_TYPE);

            // call transmitting callback
            local _transmitCallback = connection.getHandler("transmit");
            if (_transmitCallback) {
                connection.setTransmitHandler(null);

                imp.wakeup(0, function() {
                    _transmitCallback(null, connection);
                }.bindenv(this))
            }
        }
        if (status.TIMEOUT) {
            server.log("Timeout occurred on socket " + socket);
            _wiz.clearSocketInterrupt(socket, TIMEOUT_INT_TYPE);

            if (_socketConnectionState[socket] == "CONNECTING") {
                _wiz.sendSocketCommand(socket, SOCKET_CLOSE);
                _updateConnectionState(connection, "CLOSED");
                _connections.rawdelete(connection.socket);
                _avaiableConnections.push(socket);

                local _connectionCallback = connection.getHandler("connect");
                if (_connectionCallback) {
                    connection.setConnectHandler(null);

                    imp.wakeup(0, function() {
                        _connectionCallback("Error: Connection Timeout on socket " + socket, connection);
                    }.bindenv(this))
                }
            } else {
                local _transmitCallback = connection.getHandler("transmit");
                if (_transmitCallback) {
                    connection.setTransmitHandler(null);

                    imp.wakeup(0, function() {
                        _transmitCallback("Error: Transmission Timeout on socket " + socket, connection);
                    }.bindenv(this))
                }
            }
        }
        if (status.DATA_RECEIVED) {
            server.log("Data received on socket " + socket);
            _wiz.clearSocketInterrupt(socket, DATA_RECEIVED_INT_TYPE);
            receive(connection); // process incoming data
        }
    }

    /***************************************************************************
     * _clearAllInterrupts, clears all interrupt registers
     * Returns: this
     * Parameters: none
     **************************************************************************/
    function _clearAllInterrupts() {
        _wiz.clearInterrupt();
        for(local socket = 0; socket < _totalSockets; socket++) {
            _wiz.clearSocketInterrupt(socket);
        }
        return this;
    }

    // DEBUG/LOGGING FUNCTIONS
    // ---------------------------------------------

    /***************************************************************************
     * _logSocketInterruptStatus
     * Returns: null
     * Parameters:
     *      socket - select the socket using an integer 0-3
     **************************************************************************/
    function _logSocketInterruptStatus(socket) {
        local status = _wiz.getSocketInterruptTypeStatus(socket);
        foreach (k, v in status) {
            server.log(k + ": " + v)
        }
    }

    /***************************************************************************
     * _logConnectionState
     * Returns: null
     * Parameters:
     *      socket - select the socket using an integer 0-3
     **************************************************************************/
    function _logConnectionState(socket) {
        local status = _wiz.getSocketStatus(socket);

        switch(status) {
            case SOCKET_STATUS_ESTABLISHED:
                server.log("SOCKET_STATUS_ESTABLISHED");
                break;
            case SOCKET_STATUS_SYNSENT:
                server.log("SOCKET_STATUS_SYNSENT");
                break;
            case SOCKET_STATUS_SYNRECV:
                server.log("SOCKET_STATUS_SYNRECV");
                break;
            case SOCKET_STATUS_CLOSED:
                server.log("SOCKET_STATUS_CLOSED");
                break;
            default :
                server.log(status);
                break;
        }
    }

    /***************************************************************************
     * _debugLogging_Interruprts
     * Returns: null
     * Parameters: none
     **************************************************************************/
    function _debugLogging_Interruprts() {
        server.log(format("Interrupt reg: 0x%02X", _wiz.readReg(INTERRUPT, COMMON_REGISTER)));
        server.log(format("Interrupt Mask: 0x%02X", _wiz.readReg(INTERRUPT_MASK, COMMON_REGISTER)));
        server.log(format("Socket Interrupt reg: 0x%02X", _wiz.readReg(SOCKET_INTERRUPT, COMMON_REGISTER)));
        server.log(format("Socket Interrupt Mask: 0x%02X", _wiz.readReg(SOCKET_INTERRUPT_MASK, COMMON_REGISTER)));
    }

     /***************************************************************************
     * _debugLogging_NetworkSettings
     * Returns: null
     * Parameters: none
     **************************************************************************/
    function _debugLogging_NetworkSettings() {
        _wiz._logGatewayIP();
        _wiz._logSourceAddr();
        _wiz._logSubnet();
        _wiz._logSourceIP();
        _wiz._logS0SourcePort();
        _wiz._logS0DestPort();
        _wiz._logS0DestIP();
    }
}
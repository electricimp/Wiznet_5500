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

// DHCP SETTINGS
const W5500_DHCP_DEST_IP = "255.255.255.255"
const W5500_DHCP_DEST_PORT = 67
const W5500_DHCP_SRC_PORT = 68

// DHCP MESSAGE OP ODE
const W5500_DHCP_BOOTREQUEST = 01; // /< Request Message used in op of @ref RIP_MSG
const W5500_DHCP_BOOTREPLY = 02; // /< Reply Message used i op of @ref RIP_MSG

// DHCP MESSAGE TYPE
const W5500_DHCP_MSG_DISCOVER = 1; // /< DISCOVER message in OPT of @ref RIP_MSG
const W5500_DHCP_MSG_OFFER = 2; // /< OFFER message in OPT of @ref RIP_MSG
const W5500_DHCP_MSG_REQUEST = 3; // /< REQUEST message in OPT of @ref RIP_MSG
const W5500_DHCP_MSG_DECLINE = 4; // /< DECLINE message in OPT of @ref RIP_MSG
const W5500_DHCP_MSG_ACK = 5; // /< ACK message in OPT of @ref RIP_MSG
const W5500_DHCP_MSG_NAK = 6; // /< NACK message in OPT of @ref RIP_MSG
const W5500_DHCP_MSG_RELEASE = 7; // /< RELEASE message in OPT of @ref RIP_MSG. No use
const W5500_DHCP_MSG_INFORM = 8; // /< INFORM message in OPT of @ref RIP_MSG. No use

const W5500_DHCP_MSGTYPE_LEN = 1;
const W5500_DHCP_MAGIC_COOKIE = "\x63\x82\x53\x63";

const W5500_DHCP_HTYPE10MB = 01; // /< Used in type of @ref RIP_MSG
const W5500_DHCP_HTYPE100MB = 2; // /< Used in type of @ref RIP_MSG

const W5500_DHCP_HLENETHERNET = 06; // /< Used in hlen of @ref RIP_MSG
const W5500_DHCP_HOPS = 00; // /< Used in hops of @ref RIP_MSG
const W5500_DHCP_SECS = 00; // /< Used in secs of @ref RIP_MSG

const W5500_DHCP_OPT_SIZE = 212;

// DHCP State Machine
const W5500_DHCP_STATE_DISCONNECTED = 0x00;
const W5500_DHCP_STATE_INITIALIZE = 0x01;
const W5500_DHCP_STATE_SENDING_DISCOVERY = 0x02;
const W5500_DHCP_STATE_OFFER_RECEIVED = 0x03;
const W5500_DHCP_STATE_SENDING_DECLINE = 0x04;
const W5500_DHCP_STATE_SENDING_REQUEST = 0x05;
const W5500_DHCP_STATE_LEASE_RECEIVED = 0x06;

// Time Constants
const W5500_DHCP_RESEND = 5;
const W5500_DHCP_MAX_INT = 2147483647;
const W5500_DHCP_MAX_RESEND = 5;
const W5500_DHCP_LEASEOFFSET = 1800;

// Options
enum W5500_DHCP_OPTIONS {
    padOption = 0,
        subnetMask = 1,
        timerOffset = 2,
        routersOnSubnet = 3,
        timeServer = 4,
        nameServer = 5,
        dns = 6,
        logServer = 7,
        cookieServer = 8,
        lprServer = 9,
        impressServer = 10,
        resourceLocationServer = 11,
        hostName = 12,
        bootFileSize = 13,
        meritDumpFile = 14,
        domainName = 15,
        swapServer = 16,
        rootPath = 17,
        extentionsPath = 18,
        IPforwarding = 19,
        nonLocalSourceRouting = 20,
        policyFilter = 21,
        maxDgramReasmSize = 22,
        defaultIPTTL = 23,
        pathMTUagingTimeout = 24,
        pathMTUplateauTable = 25,
        ifMTU = 26,
        allSubnetsLocal = 27,
        broadcastAddr = 28,
        performMaskDiscovery = 29,
        maskSupplier = 30,
        performRouterDiscovery = 31,
        routerSolicitationAddr = 32,
        staticRoute = 33,
        trailerEncapsulation = 34,
        arpCacheTimeout = 35,
        ethernetEncapsulation = 36,
        tcpDefaultTTL = 37,
        tcpKeepaliveInterval = 38,
        tcpKeepaliveGarbage = 39,
        nisDomainName = 40,
        nisServers = 41,
        ntpServers = 42,
        vendorSpecificInfo = 43,
        netBIOSnameServer = 44,
        netBIOSdgramDistServer = 45,
        netBIOSnodeType = 46,
        netBIOSscope = 47,
        xFontServer = 48,
        xDisplayManager = 49,
        dhcpRequestedIPaddr = 50,
        dhcpIPaddrLeaseTime = 51,
        dhcpOptionOverload = 52,
        dhcpMessageType = 53,
        dhcpServerIdentifier = 54,
        dhcpParamRequest = 55,
        dhcpMsg = 56,
        dhcpMaxMsgSize = 57,
        dhcpT1value = 58,
        dhcpT2value = 59,
        dhcpClassIdentifier = 60,
        dhcpClientIdentifier = 61,
        endOption = 255
};



// ==============================================================================
// CLASS: W5500.DHCP
// ==============================================================================

class W5500.DHCP {

    static VERSION = "2.0.1";

    _driver = null;
    _wiz = null;
    _timeout = 0;
    _connection = null;

    _state = null;
    _isLeased = false;
    _isRenewing = false;
    _nextLoopTime = null;
    _resendCount = 0;

    // Timers
    _runLoopTimer = null;
    _renewTimer = null;
    _timeoutTimer = null;

    // Callbacks
    _leasedCb = null;
    _timeoutCb = null;
    _errorCb = null;

    // Data Packaging
    _headerPacket = null;
    _packetRecipe = null;
    _serverID = null;
    _dhcpXID = null;

    // Contain Parsed Info
    _offeredIP = null;

    // Returned Info
    _leasedIP = null;
    _leasedSubnetMask = null;
    _leasedRouterAddress = null;
    _leasedDNS = null;
    _leaseTime = null;

    // Packet Format
    W5500_DHCP_STRUCT = [
        { "k": "op", "s": 1, "v": W5500_DHCP_BOOTREQUEST },
        { "k": "htype", "s": 1, "v": W5500_DHCP_HTYPE10MB },
        { "k": "hlen", "s": 1, "v": W5500_DHCP_HLENETHERNET },
        { "k": "hops", "s": 1, "v": W5500_DHCP_HOPS },
        { "k": "xid", "s": 4, "v": null },
        { "k": "secs1", "s": 2, "v": "\x00\x00" },
        { "k": "flags", "s": 2, "v": "\x80\x00" },
        { "k": "ciaddr", "s": 4, "v": null },
        { "k": "yiaddr", "s": 4, "v": null },
        { "k": "siaddr", "s": 4, "v": null },
        { "k": "giaddr", "s": 4, "v": null },
        { "k": "chaddr", "s": 16, "v": null },
        { "k": "sname", "s": 64, "v": null },
        { "k": "file", "s": 128, "v": null },
        { "k": "cookie", "s": 4, "v": W5500_DHCP_MAGIC_COOKIE },
        { "k": "OPT", "s": W5500_DHCP_OPT_SIZE, "v": null }
    ];


    constructor(wiz) {
        _wiz = wiz;
        _driver = wiz._driver;
        _state = W5500_DHCP_STATE_DISCONNECTED;
        _packetRecipe = W5500_DHCP_STRUCT;
        _nextLoopTime = W5500_DHCP_RESEND;
    }

    // Public Functions

    // ***************************************************************************
    // onLease
    // Returns: none
    // Parameters:
    //      cb -   callback function to be called when a DHCP lease is received
    // ***************************************************************************
    function onLease(cb) {
        _leasedCb = cb;
        return this;
    }

    // ***************************************************************************
    // renewLease
    // Returns: none
    // Parameters:
    //      timeout - number of seconds to allow for the lease to try before giving up (0 = infinite)
    // ***************************************************************************
    function renewLease(timeout = 0) {
        // Request a new lease when the wiznet driver is ready
        _timeout = timeout;
        if (!_isRenewing) {
            _isRenewing = true;
            _wiz.onReady(_renewLease.bindenv(this));
        }
        return this;
    }


    // ***************************************************************************
    // getIP
    // Returns: array containing the leased ip
    // Parameters:
    //          none
    // ***************************************************************************
    function getIP() {
        if (_leasedIP) return _blobtoAddrStr(_leasedIP);
    }

    // ***************************************************************************
    // getSubnetMaskMask
    // Returns: array containing the subnet mask
    // Parameters:
    //          none
    // ***************************************************************************
    function getSubnetMask() {
        if (_leasedRouterAddress) return _blobtoAddrStr(_leasedSubnetMask);
    }

    // ***************************************************************************
    // getRouterAddress
    // Returns: array containing the router address
    // Parameters:
    //          none
    // ***************************************************************************
    function getRouterAddress() {
        if (_leasedRouterAddress) return _blobtoAddrStr(_leasedRouterAddress);
    }

    // ***************************************************************************
    // getDNS
    // Returns: array of arrays, each containing a DNS entry
    // Parameters:
    //          none
    // ***************************************************************************
    function getDNS() {
        if (_leasedDNS) {
            local dns = array();
            _leasedDNS.seek(0);
            while (!_leasedDNS.eos()) {
                dns.push(_blobtoAddrStr(_leasedDNS.readblob(4)));
            }
            return dns;
        }
    }

    // ***************************************************************************
    // getLeaseTime
    // Returns: lease time in seconds
    // Parameters:
    //          none
    // ***************************************************************************
    function getLeaseTime() {
        if (_leaseTime) return _leaseTime;
    }

    // ***************************************************************************
    // _renewLease
    // Returns: none
    // Parameters:  none
    // ***************************************************************************
    function _renewLease() {

        // Setup the global timeout
        if (!_timeoutTimer && _timeout > 0) {
            _timeoutTimer = imp.wakeup(_timeout, _cancelRenewLease.bindenv(this));
        }

        // Cancel the renew timer
        if (_renewTimer) imp.cancelwakeup(_renewTimer);
        _renewTimer = null;

        // Setup the network for DHCP (UDP)
        _driver.openConnection(W5500_DHCP_DEST_IP, W5500_DHCP_DEST_PORT, W5500_SOCKET_MODE_UDP, W5500_DHCP_SRC_PORT, function(err, connection) {

            if (err) {
                // Couldn't spare a socket for a DHCP request
                if (_renewTimer) imp.cancelwakeup(_renewTimer);
                _renewTimer = imp.wakeup(10, _renewLease.bindenv(this));
            } else {
                // Ready to start
                _connection = connection;
                _connection.onReceive(_receiveDHCP.bindenv(this));
                _runLoopDHCP();
            }

        }.bindenv(this));
    }


    // ***************************************************************************
    // _cancelRenewLease
    // Returns: none
    // Parameters:  none
    // ***************************************************************************
    function _cancelRenewLease() {

        // Close the DHCP connection
        if (_connection) _connection.close();
        _connection = null;
        _isRenewing = false;
        _state = W5500_DHCP_STATE_DISCONNECTED;

        // Stop the DHCP loop / state machine altogether
        if (_runLoopTimer) {
            imp.cancelwakeup(_runLoopTimer);
            _runLoopTimer = null;
        }

        // Stop the timeout timer
        if (_timeoutTimer) {
            imp.cancelwakeup(_timeoutTimer);
            _timeoutTimer = null;
        }

        // Fire the event handler!
        imp.wakeup(0, function() {
            if (_leasedCb) _leasedCb("Timeout");
        }.bindenv(this));

    }

    // ***************************************************************************
    // _runLoopDHCP
    // Returns: none
    // Parameters:
    //      none
    // ***************************************************************************
    function _runLoopDHCP() {

        // Cancel any running timers to prevent reentry
        if (_runLoopTimer) {
            imp.cancelwakeup(_runLoopTimer);
            _runLoopTimer = null;
        }

        local stateBefore = _state;

        if (false && !_driver.getPhysicalLinkStatus()) {

            // server.log("Ethernet Disconnected");
            _state = W5500_DHCP_STATE_DISCONNECTED;
            _nextLoopTime = 1;

        } else {

            switch (_state) {
                case W5500_DHCP_STATE_DISCONNECTED:
                case W5500_DHCP_STATE_INITIALIZE:
                    // Prebuilds the header for the packets
                    _headerPacket = _initializePacket();
                    _state = W5500_DHCP_STATE_SENDING_DISCOVERY;
                    _nextLoopTime = 0;
                    _resendCount = 0;
                    break;

                case W5500_DHCP_STATE_SENDING_DISCOVERY:
                    // Exponential backoff
                    if (_nextLoopTime <= 0) _nextLoopTime = 5;
                    else if (_nextLoopTime < 60) _nextLoopTime *= 1.25;

                    // Send the DHCP Discover Packet
                    _sendDHCP(W5500_DHCP_MSG_DISCOVER);
                    break;

                case W5500_DHCP_STATE_OFFER_RECEIVED:
                    _nextLoopTime = 20;
                    _resendCount = 0;

                    // HACK: Skip the validity check for now
                    // _checkValidIP(_offeredIP);
                    _state = W5500_DHCP_STATE_SENDING_REQUEST;
                    _nextLoopTime = 0;
                    break;

                case W5500_DHCP_STATE_SENDING_REQUEST:
                    if (_resendCount++ < W5500_DHCP_MAX_RESEND) {
                        // Send the DHCP Request Packet
                        _sendDHCP(W5500_DHCP_MSG_REQUEST, _offeredIP, _serverID);
                        _nextLoopTime = 5;
                    } else {
                        // Start again, we have lost the plot
                        _state = W5500_DHCP_STATE_INITIALIZE;
                        _isLeased = false;
                        _nextLoopTime = 1;
                        _resendCount = 0;
                    }
                    break;

                case W5500_DHCP_STATE_SENDING_DECLINE:
                    // We don't want what was offered, decline it.
                    _sendDHCP(W5500_DHCP_MSG_DECLINE, _offeredIP, _serverID);
                    _state = W5500_DHCP_STATE_SENDING_DISCOVERY;
                    _nextLoopTime = 1;
                    break;

            }
        }

        // Run the same function again soon
        _runLoopTimer = imp.wakeup(_nextLoopTime, _runLoopDHCP.bindenv(this));
    }

    // Private Functions

    // ***************************************************************************
    // _receiveDHCP
    // Returns: none
    // Parameters:
    //      err  - error message
    //      data - blob containing the received packet
    // ***************************************************************************
    function _receiveDHCP(err, data) {
        // Callback function for data received

        if (data == null) return;

        local offer = _parsePacket(data, W5500_DHCP_STRUCT);
        local oldXID = offer[4].v.tostring();
        local newXID = offer[4].r.tostring();

        if (oldXID == newXID) {

            // Parse W5500_DHCP_OPTIONS
            local options = _parseOptions(offer[offer.len() - 1].r);

            // Check Message Type
            options[W5500_DHCP_OPTIONS.dhcpMessageType].seek(0, 'b');

            local msgtype = options[W5500_DHCP_OPTIONS.dhcpMessageType].readn('b');

            switch (msgtype) {
                case W5500_DHCP_MSG_OFFER:
                    if (_state == W5500_DHCP_STATE_SENDING_DISCOVERY) {
                        // Get the offered IP and server ID
                        _offeredIP = offer[8].r;
                        _state = W5500_DHCP_STATE_OFFER_RECEIVED;
                        _runLoopDHCP();
                    }
                    break;

                case W5500_DHCP_MSG_ACK:
                    // Grab Connection Settings
                    _leasedIP = _offeredIP;
                    _leasedSubnetMask = (W5500_DHCP_OPTIONS.subnetMask in options) ? options[W5500_DHCP_OPTIONS.subnetMask] : null;
                    _leasedRouterAddress = (W5500_DHCP_OPTIONS.routersOnSubnet in options) ? options[W5500_DHCP_OPTIONS.routersOnSubnet] : null;
                    _leasedDNS = (W5500_DHCP_OPTIONS.dns in options) ? options[W5500_DHCP_OPTIONS.dns] : null;

                    // Give 60 second margin on DHCP lease
                    _leaseTime = _parseLeaseTime(options[W5500_DHCP_OPTIONS.dhcpIPaddrLeaseTime]) - W5500_DHCP_LEASEOFFSET;

                    // Close the DHCP connection
                    if (_connection) _connection.close();
                    _connection = null;
                    _isRenewing = false;
                    _isLeased = true;

                    // Stop the DHCP loop / state machine altogether
                    if (_runLoopTimer) {
                        imp.cancelwakeup(_runLoopTimer);
                        _runLoopTimer = null;
                    }

                    // Stop the timeout timer
                    if (_timeoutTimer) {
                        imp.cancelwakeup(_timeoutTimer);
                        _timeoutTimer = null;
                    }

                    // Schedule a renewal
                    local renewTime = _leaseTime >= 60 ? _leaseTime : 60; // at least 60 seconds
                    if (_renewTimer) imp.cancelwakeup(_renewTimer);
                    _renewTimer = imp.wakeup(renewTime, _renewLease.bindenv(this));

                    // Fire the event handler!
                    imp.wakeup(0, function() {
                        if (_leasedCb) _leasedCb(null);
                    }.bindenv(this));

                    break;

                case W5500_DHCP_MSG_NAK:
                    _isLeased = false;
                    _nextLoopTime = 0;
                    _state = W5500_DHCP_STATE_SENDING_DISCOVERY;
                    _runLoopDHCP();
                    break;
            }

        }

    }

    // ***************************************************************************
    // _checkValidIP
    // Returns: none
    // Parameters:
    //      ip - Blob containing the offered IP Address
    // ***************************************************************************
    function _checkValidIP(ip) {

        // Shorten the timeouts
        _driver.setRetries(1000, 3);

        // Open TCP Connection (to send ARP). Should get timeout.
        // server.log("*** Checking valid IP");
        _wiz.openConnection(ip, W5500_DHCP_DEST_PORT, W5500_SOCKET_MODE_TCP, function(err, conn) {

            // Close the connection immediately
            if (conn) conn.close();
            // server.log("*** Finished checking valid IP");

            if (err == null) {

                // We got a connection. This is bad.
                // server.log("*** IP in use, requesting another");
                _state = W5500_DHCP_STATE_SENDING_DECLINE;

            } else if (err.find(W5500_CANNOT_CONNECT_SOCKETS_IN_USE) != null) {

                // We can't validate it but we will accept it anyway
                // server.log("*** No sockets free, accepting anyway");
                _state = W5500_DHCP_STATE_SENDING_REQUEST;

            } else if (err.find("timeout") == null) {

                // This isn't a timeout, so there is something else responding to the arp
                // server.log("*** IP in use, requesting another");
                _state = W5500_DHCP_STATE_SENDING_DECLINE;

            } else {

                // Nobody else has this IP, let's accept it and move on.
                // server.log("*** Valid IP address accepted");
                _state = W5500_DHCP_STATE_SENDING_REQUEST;

            }

            // Start the loop again
            _runLoopDHCP();

        }.bindenv(this));

    }

    // ***************************************************************************
    // _makeXID
    // Returns: integer containing a random integer from 0 to W5500_DHCP_MAX_INT
    // Parameters:
    //      none
    // ***************************************************************************
    function _makeXID() {
        local XID = (1.0 * math.rand() / RAND_MAX) * (W5500_DHCP_MAX_INT + 1);
        return XID.tointeger();
    }

    // ***************************************************************************
    // _incrementXID
    // Returns: none
    // Parameters:  none
    // ***************************************************************************
    function _incrementXID() {
        local updatedXID = blob(4);
        updatedXID.writen(_dhcpXID++, 'i');
        _packetRecipe[4].v = updatedXID;
        _headerPacket = _initializePacket();
    }


    // ***************************************************************************
    // _parseLeaseTime
    // Returns: parsedLeaseTime, int containing the lease time
    // Parameters:
    //      leasetime - 4 byte blob containing the time when the DHCP lease expires
    // ***************************************************************************
    function _parseLeaseTime(leasetime) {
        // Swap for Little Endian
        leasetime.swap4();
        leasetime.seek(0, 'b');
        local parsedLeaseTime = leasetime.readn('i');

        // server.log("leaseTime: " + parsedLeaseTime);
        if (parsedLeaseTime < 0) {
            // If the leasetime is too big for the IMP005, use largest number IMP can support
            parsedLeaseTime = W5500_DHCP_MAX_INT;
        }
        return parsedLeaseTime;
    }

    // ***************************************************************************
    // _parseOptions
    // Returns: options - array with index being the DHCP Option number
    // Parameters:
    //      optionsData - array of tables with received data
    //
    // ***************************************************************************
    function _parseOptions(optionsData) {
        local options = {};
        local opt = null;
        local len = null;

        optionsData.seek(0, 'b');
        while (!optionsData.eos()) {
            // Get Option Type
            opt = optionsData.readn('b');

            if (opt != W5500_DHCP_OPTIONS.endOption) {

                // Get Length
                if (optionsData.eos()) break;
                len = optionsData.readn('b');

                // Read Value
                local value = blob(len);
                if (len > 0) value = optionsData.readblob(len);
                options[opt] <- value;

            }

        }

        return options;
    }

    // ***************************************************************************
    // _parsePacket
    // Returns: _structure
    // Parameters:
    //      packet    - blob containing the packet
    //      structure - array of tables, with each table being a field in the packet
    // ***************************************************************************
    function _parsePacket(packet, structure) {
        local sourceIP = blob(4);
        local destIP = blob(4);
        local _structure = structure;

        packet.seek(0, 'b');
        sourceIP = packet.readblob(4);
        destIP = packet.readblob(4);

        for (local i = 0; i < _structure.len(); i++) {
            if (i == _structure.len() - 1) {
                _structure[i].r <- packet.readblob(packet.len() - packet.tell());
            } else {
                _structure[i].r <- packet.readblob(_structure[i].s);
            }
        }

        return _structure;
    }

    // ***************************************************************************
    // _makePacket
    // Returns: blob containing the fields specified by the packet structure
    // Parameters:
    //      structure - array of tables, with each table being a field in the packet
    // ***************************************************************************
    function _makePacket(structure) {
        local _packetSize = 0;
        local _outputPacket = null;

        // Add up total size
        foreach (item in structure) {
            _packetSize += item.s;
        }

        _outputPacket = blob(_packetSize);

        // Write data into blob
        foreach (item in structure) {
            if (item.v != null) {
                switch (typeof(item.v)) {
                    case "string":
                        _outputPacket.writestring(item.v);
                        break;
                    case "integer":
                        _outputPacket.writen(item.v, 'b');
                        break;
                    case "blob":
                        _outputPacket.writeblob(item.v);
                        break;
                }
            } else {
                _outputPacket.seek(item.s, 'c');
            }
        }
        return _outputPacket;
    }

    // ***************************************************************************
    // _initializePacket
    // Returns: (blob) containing the header part of the packet
    // Parameters:
    //      none
    // ***************************************************************************
    function _initializePacket() {
        local mac = blob(16);
        local xid = blob(4);
        local options = blob();

        // Creates a transaction ID, stores it, converts to blob
        _dhcpXID = _makeXID();
        xid.writen(_dhcpXID, 'i');

        // Get the Source MAC Address
        local _mac = _driver.getSourceHWAddr();
        for (local i = 0; i < _mac.len(); i++) {
            mac.writen(_mac[i], 'b');
        }
        mac.seek(0, 'b');

        // OPTIONS
        // Client identifier
        options.writen(W5500_DHCP_OPTIONS.dhcpClientIdentifier, 'b');
        // Length
        options.writen(0x07, 'b');
        // Type
        options.writen(0x01, 'b');
        // Writes Mac Address
        options.writeblob(mac.readblob(6));

        // Host Name
        options.writen(W5500_DHCP_OPTIONS.hostName, 'b');
        options.writestring("\x03\x4F\x0D\xEB");

        // ParamRequest
        options.writen(W5500_DHCP_OPTIONS.dhcpParamRequest, 'b');
        options.writen(0x06, 'b'); // length?
        options.writen(W5500_DHCP_OPTIONS.subnetMask, 'b');
        options.writen(W5500_DHCP_OPTIONS.routersOnSubnet, 'b');
        options.writen(W5500_DHCP_OPTIONS.dns, 'b');
        options.writen(W5500_DHCP_OPTIONS.domainName, 'b');
        options.writen(W5500_DHCP_OPTIONS.dhcpT1value, 'b');
        options.writen(W5500_DHCP_OPTIONS.dhcpT2value, 'b');

        // Write the blob to the structure
        _packetRecipe[4].v = xid;
        _packetRecipe[_packetRecipe.len() - 5].v = mac;
        _packetRecipe[_packetRecipe.len() - 1].v = options;
        _packetRecipe[_packetRecipe.len() - 1].s = options.len();

        return _makePacket(_packetRecipe);
    }

    // ***************************************************************************
    // _sendDHCP
    // Returns: none
    // Parameters:
    //      packetType                      -constant containing the DHCP message type
    //      yiaddr(optional)                -4 byte blob containing the requested IP
    //      dhcpServerIdentifier(optional)  -4 byte blob containing the DHCP server IP address
    // ***************************************************************************
    function _sendDHCP(packetType, yiaddr = null, dhcpServerIdentifier = null) {
        local options = blob();

        // Requested Address
        if (yiaddr) {
            options.writen(W5500_DHCP_OPTIONS.dhcpRequestedIPaddr, 'b');
            options.writen(0x04, 'b');
            options.writeblob(yiaddr);
        }

        // Server ID
        if (dhcpServerIdentifier) {
            options.writen(W5500_DHCP_OPTIONS.dhcpServerIdentifier, 'b');
            options.writen(0x04, 'b');
            options.writeblob(dhcpServerIdentifier);
        }

        // DHCP Message Type Definition
        options.writen(W5500_DHCP_OPTIONS.dhcpMessageType, 'b');
        options.writen(W5500_DHCP_MSGTYPE_LEN, 'b');
        options.writen(packetType, 'b');

        // End Option
        options.writen(W5500_DHCP_OPTIONS.endOption, 'b');

        // Write the blob to the structure
        local completePacket = blob();
        completePacket.writeblob(_headerPacket);
        completePacket.writeblob(options);

        // Finally, transmit it
        if (_connection) _connection.transmit(completePacket);

    }

    // ***************************************************************************
    // _blobtoAddrStr
    // Returns: array containing the blob converted to an array of numbers
    // Parameters:
    //      data - blob to be converted
    // ***************************************************************************
    function _blobtoAddrStr(addr) {
        return format("%d.%d.%d.%d", addr[0], addr[1], addr[2], addr[3]);
    }

}

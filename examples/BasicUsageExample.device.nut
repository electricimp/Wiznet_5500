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

#require "W5500.device.lib.nut:2.2.0"

//================================================
// Define Settings
//================================================

// Network Settings
const DEST_IP       = "192.168.42.3";
const DEST_PORT     = 6800;
const SOURCE_IP     = "192.168.42.2";
const SUBNET_MASK   = "255.255.255.0";
const GATEWAY_IP    = "192.168.42.1";

// Application Settings
const SEND_LOOP_SEC = 10;

// Application Variables
started     <- 0;
connection  <- null;
wiz         <- null;
sendLoopTmr <- null;

//================================================
// Configure Hardware
//================================================

switch(imp.info().type) {
    case "imp005": 
        // Configure Hardware for imp005 Fieldbus Gateway
        interruptPin <- hardware.pinXC;
        resetPin     <- hardware.pinXA;
        // Initialise SPI port
        spiSpeed     <- 1000;
        spi          <- hardware.spi0;
        cs           <- null;
        spi.configure(CLOCK_IDLE_LOW | MSB_FIRST | USE_CS_L, spiSpeed);
        break;
    case "impC001":
        // Configure Hardware for impC001 breakout with a
        // Wiznet connected to the MikroBUS click and a 
        // solder bridge on W4 to change interrupt pin
        interruptPin <- hardware.pinYL;
        resetPin     <- hardware.pinYC;
        powerGate    <- hardware.pinYG;
        powerGate.configure(DIGITAL_OUT, 0);
        // Initialise SPI port
        spiSpeed     <- 1000;
        spi          <- hardware.spiPQRS;
        cs           <- hardware.pinS;
        spi.configure(CLOCK_IDLE_LOW | MSB_FIRST, spiSpeed);
        break;
    default: 
        server.error("Unsupported hardware, cannot configure Wiznet");
        return;
}

//================================================
// Define functions
//================================================

function cancelSendLoop() {
    if (sendLoopTmr != null) {
        imp.cancelwakeup(sendLoopTmr);
        sendLoopTmr = null;
    }
}

function closeWizConn() {
    if (::connection != null) {
        cancelSendLoop();
        server.log("Closing connection...");
        ::connection.close();
    }
}

function sendLoop() {
    send("Hello again");
    cancelSendLoop();
    sendLoopTmr = imp.wakeup(SEND_LOOP_SEC, sendLoop);
}

function onSent(err) {
    if (err) {
        server.error("Send Error: Send failed " + err);
        closeWizConn();
        return;
    } 
        
    server.log(format("Sent successful to %s:%d", DEST_IP, DEST_PORT));
    server.log("--------------------------------------------------------------------------");
    
    // Schedule next send
    cancelSendLoop();
    sendLoopTmr = imp.wakeup(SEND_LOOP_SEC, sendLoop);
}

function send(msg) {
    if (::connection == null) {
        server.error("Send Error: Connection not established");
        return;
    }
    
    server.log("--------------------------------------------------------------------------");
    server.log("Sending message " + msg + " ...");
    ::connection.transmit(msg, onSent);
}

function onWizConnected(err, _connection) {
    local dur = hardware.millis() - started;
    
    if (err) {
        local errMsg = format("Connection failed to %s:%d in %d ms: %s", DEST_IP, DEST_PORT, dur, err.tostring());
        server.error(errMsg);
        // TODO: Retry connection
        return;
    }
    
    server.log(format("Connection to %s:%d in %d ms", DEST_IP, DEST_PORT, dur));
    ::connection = _connection;
    server.log("--------------------------------------------------------------------------");
    
    // Create event handlers for this connection
    ::connection.onReceive(onMsgReceived);
    ::connection.onDisconnect(onWizDisconnect);
    
    // Configure handler for the next message received
    ::connection.receive(function(err, data) {
        server.log(format("Manual response from %s:%d: " + data, ::connection.getIP(), ::connection.getPort()));
    })
    
    // Send first message
    send("Hello world");
}

function onWizReady() {
    started = hardware.millis();
    server.log("Wiznet isReady: " + wiz._isReady);

    server.log("Configuring network settings");
    wiz.configureNetworkSettings(SOURCE_IP, SUBNET_MASK, GATEWAY_IP);
    
    server.log("--------------------------------------------------------------------------");
    server.log("Attemping to connect...");
    wiz.openConnection(DEST_IP, DEST_PORT, onWizConnected);
}

function onMsgReceived(err, response) {
    if (err) {
        server.error("Receive Error: " + err);
        return;
    } 
    server.log(format("Catchall response from %s:%d: " + response, ::connection.getIP(), ::connection.getPort()));
}

function onWizDisconnect(err) {
    server.log(format("Disconnected from %s:%d", ::connection.getIP(), ::connection.getPort()));
    imp.wakeup(30, function() {
        wiz.onReady(onWizReady);
    })
}

//================================================
// RUN
//================================================

server.log("--------------------------------------------------------------------------");
server.log("Device started...");
server.log(imp.getsoftwareversion());
server.log("--------------------------------------------------------------------------");

// Initialize Wiznet
wiz <- W5500(interruptPin, spi, cs, resetPin);
// Register onReady handler that starts application
wiz.onReady(onWizReady);
server.log("Waiting for Wiznet to be ready ...");
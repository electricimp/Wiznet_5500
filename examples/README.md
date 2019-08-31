# Examples #

These examples show basic usage for the W5500 and W5500.DHCP libraries. 

## Echo Server ##

Both the W5500 and W5500.DHCP library examples make use of an echo server that receives an incoming message and repeats it back to the sender. 

Included in this directory is the [echo_server.js](echo_server.js) file which can be used for running a node echo server from your computer. To launch the server from your computer using this code you must have node installed and have an available ethernet port.

To launch node server navigate to the directory containing the echo_server.js file and run the following command on the command line:

```bash
node echo_server.js
```

## Basic Usage Example ##

This example shows how to open a connection, send and receive messages using the W5500 library. It utilized a very simple network, and an Echo Server connected via an ethernet crossover cable to the Wiznet, no router is required. Included in this directory is a node js file that can be used to run an [Echo Server](#echo-server) from your computer. 

This example code can be run on an imp005 Fieldbus Gateway or an impC001 breakout board with a Wiznet MicroBUS click. If using the MicroBUS click you will need to solder the W4 bridge on the back of the breakout board to update the interrupt pin. 

### Electric Imp Setup ###

- BlinkUp your device
- In the impCentral IDE 
    - Create a Product and Device Group or navigate to a Device Group you wish to use
    - Assign your device to the Device Group
    - Copy and paste the code [Basic Usage Example](/BasicUsageExample.device.nut) into the device code window for your Device Group

### Network Setup ###

You will need to either configure the code to match your [Echo Server's](#echo-server) settings or configure your Echo Server to match the code. The following sections will outline where each the network settings can be found and what the example code defaults to.

#### Network Settings Summery ####

All code examples are setup with the following network settings: 

- The Echo Server has an IP address of `192.168.42.3`
- The imp's Wiznet has an IP address of `192.168.42.2`
- The gateway/router IP is set to `192.168.42.1`
- The port is set to `6800`

#### The Echo Server (ie your Computer Network Settings for Ethernet port) ####

```
Configure IPv4: Manually
IP Address:     192.168.42.3
Subnet Mask:    255.255.255.0
Router:         192.168.42.1
```

#### Network settings from echo_server.js ####

```js
const DEFAULT_PORT = 6800;
const DEFAULT_HOST = "192.168.42.3"; 
```

#### Network settings from BasicUsageExample.device.nut ####

```squirrel
// Network Settings 
const DEST_IP       = "192.168.42.3";
const DEST_PORT     = 6800;
const SOURCE_IP     = "192.168.42.2";
const SUBNET_MASK   = "255.255.255.0";
const GATEWAY_IP    = "192.168.42.1";
```

#### Launch Echo Server ####

Once the settings in your code and on your devices match: 

- Connect your Echo Server to the Wiznet via a crossover ethernet cable
- Launch [Echo Server](#echo-server)

### Start Application ###

Once the echo server is running, navigate to the impCentral IDE and hit `Build and Force Restart` to start the application. You should begin to see logs showing the messages being sent and received from the Echo Server.

## DHCP Example ##

This example shows how to obtain and renew a DHCP lease using the W5500.DHCP library. 

Currently the code only supports an imp005 Fieldbus Gateway, but can easily be modified to run on other imps by updating the hardware configuration settings in the code.

This example requires a network that contains the following: 

- An [Echo Server](#echo-server)
- A network device that can issue a DHCP lease, ie a gateway/router
- The imp with Wiznet ethernet

### Electric Imp Setup ###

- BlinkUp your device
- In the impCentral IDE 
    - Create a Product and Device Group or navigate to a Device Group you wish to use
    - Assign your device to the Device Group
    - Copy and paste the code [DHCP Example](/DHCP_Example.device.nut) into the device code window for your Device Group

### Network Setup ###

You will need to either configure the code to match your gateway/router and [Echo Server's](#echo-server) settings or configure your network devices to match the code. The following sections will outline where each the network settings can be found and what the example code defaults to.

#### Network Settings Summery ####

All code examples are setup with the following network settings: 

- The Echo Server has an IP address of `192.168.42.3`
- The gateway/router IP is set to `192.168.42.1`
- The port is set to `6800`

The imp's Wiznet will obtain an IP address from the gateway/router

#### The Router or Gateway Device ####

```
Router IP Address: 192.168.42.1
```

#### The Echo Server (ie your Computer Network Settings for Ethernet port) ####

```
Configure IPv4: Manually
IP Address:     192.168.42.3
Subnet Mask:    255.255.255.0
Router:         192.168.42.1
```

#### Network settings from echo_server.js ####

```js
const DEFAULT_PORT = 6800;
const DEFAULT_HOST = "192.168.42.3"; 
```

#### Network settings from DHCP_Example.device.nut ####
```squirrel
// Configure Echo Server Settings
const ECHO_SERVER_IP   = "192.168.42.3";
const ECHO_SERVER_PORT = 6800;
```

#### Launch Echo Server ####

Once the settings in your code and on your devices match: 

- Connect your Devices
    - Connect the Echo Server to the gateway/router
    - Connect the Wiznet via a crossover ethernet cable to the gateway/router
- Launch [Echo Server](#echo-server)

### Start Application ###

Once the echo server is running, navigate to the impCentral IDE and hit `Build and Force Restart` to start the application. You should begin to see logs showing the Fieldbus Gateway obtaining and renewing the DHCP lease.

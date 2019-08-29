# Examples #

These examples show basic usage for the W5500 and W5500.DHCP libraries. 

## Echo Server Setup ##

Both these libraries make use of an echo server that receives an incoming message and repeats it back to the sender. Included in this directory is the [echo_server.js](echo_server.js) file which can be used for launching a node echo server. 

The instructions below assume you have node installed on your computer and your computer has an ethernet port available.

- Connect your computer to the Wiznet ethernet port on your imp device via a crossover cable.

- Configure network settings for the ethernet port on the computer to match the settings in the example code. 

    All code examples are setup with the following settings: 

    - The computer has an IP address of `192.168.201.3`
    - The imp's Wiznet has an IP address of `192.168.201.2`
    - The gateway/router IP is set to `192.168.201.1`
    - The port is set to `4242`: 

        Computer Network Settings for Ethernet port
        ```
        Configure IPv4: Manually
        IP Address:     192.168.201.3
        Subnet Mask:    255.255.255.0
        Router:         192.168.201.1
        ```

        Network settings from echo_server.js
        ```js
        const DEFAULT_PORT = 4242;
        const DEFAULT_HOST = "192.168.201.3"; 
        ```

        Network settings from BasicUsageExample.device.nut
        ```squirrel
        // Network Settings 
        const DEST_IP       = "192.168.201.3";
        const DEST_PORT     = 4242;
        const SOURCE_IP     = "192.168.201.2";
        const SUBNET_MASK   = "255.255.255.0";
        const GATEWAY_IP    = "192.168.201.1";
        ```

        Network settings from DHCP_Example.device.nut
        ```squirrel
        // Configure Echo Server Settings
        const ECHO_SERVER_IP   = "192.168.201.3";
        const ECHO_SERVER_PORT = 4242;
        ```

- To launch node server navigate to the directory containing the echo_server.js file and run the following command on the command line:

    ```bash
    node echo_server.js
    ```

## Basic Usage Example ##

This example shows how to open a connection, send and receive messages using the W5500 library. It can be run on an imp005 Fieldbus Gateway or an impC001 breakout board with a Wiznet MicroBUS click. If using the MicroBUS click you will need to solder the W4 bridge on the back of the breakout board to update the interrupt pin. 

- BlinkUp your device
- Create a Product and Device Group
- Assign your device to the Device Group
- Copy and paste the code [Basic Usage Example](/BasicUsageExample.device.nut) into the device code window for your Device Group
- Configure and launch an echo server ([see setup above](#echo-server-setup)) 
- Once the echo server is running, hit `Build and Force Restart` to start the application.

## DHCP Example ##

This example shows how to obtain and renew a DHCP lease using the W5500.DHCP library. It can be run on an imp005 Fieldbus Gateway.

- BlinkUp your device
- Create a Product and Device Group
- Assign your device to the Device Group
- Copy and paste the code [DHCP Example](/DHCP_Example.device.nut) into the device code window for your Device Group
- Configure and launch an echo server ([see setup above](#echo-server-setup)) 
- Once the echo server is running, hit `Build and Force Restart` to start the application.

#Wiznet_5500_DHCP

This library class enables Dynamic Host Configuration Protocol (*DHCP*) functionality for the Wiznet W5500 chip [W5500](http://wizwiki.net/wiki/lib/exe/fetch.php?media=products:w5500:w5500_ds_v106e_141230.pdf). It also requires the Wiznet W5500 driver.  
**To add this code to your project, add ** `#require W5500.DHCP.class.nut` **and**  `#require W5500.class.nut` **to the top of your device code.**

## Class Wiznet_5500_DHCP

### Constructor: W5500.DHCP(*wiz*)
Instantiates a new W5500.DHCP object and passes in the wiznet main driver.

##### Example Code:
```squirrel
// Setup for an Imp 005
// Initialise SPI port
interruptPin <- hardware.pinXA;
resetPin     <- hardware.pinN;
spiSpeed     <- 1000;
spi          <- hardware.spi0;
spi.configure(CLOCK_IDLE_LOW | MSB_FIRST | USE_CS_L, spiSpeed);

// Initialise Wiznet and DHCP
wiz <- W5500(interruptPin, spi, null, resetPin);
dhcp<- W5500.DHCP(wiz);
```

## Class Methods

### onLease(*callback*)
The *onLease()* method sets the function to be called when an IP address is leased. It can be used before or after `dhcp.init()` is called. The callback function has an error parameter which informs the user of timeouts and errors.

#### Parameters
| Key                  | Data Type   | Required | Default Value | Description                                                    |
| -------------------- | ----------- | -------- | ------------- | -------------------------------------------------------------- |
| *callback* | `function`| Yes| N/A| The function to be fired when a DHCP lease is established   |

#### Callback Parameters
| Key        | Data Type   |Description                                       |
| -----------| ----------- |------------------------------------------------- |
| *error*    | `string`    | A string error message                           |

#### Error Messages
|Error Message                  | Description                                 |
|-------------------------------|---------------------------------------------|
|DHCP Offer Timeout             |Discovery message sent with no response      |
|DHCP Ack Timeout               |Request message sent with no response        |
|DHCP Renewal Timeout           |Max Renewal attempts reached. Restart.       |
|Renewal Failed                 |Lease renewal failed                         |
|Request Declined               |Requested IP not able to be leased           |
|IP Invalid                     |Offered IP is currently in use               |
|All connections in use         |All Wiznet sockets are in use                |



####Example Code:
```squirrel
function leaseCallback(error) {
    if (error) {
        server.log(error);
        return;
    }

    // Run this code when IP address is obtained
}
dhcp.onLease(leaseCallback);
```

###renewLease()
The *renewLease()* method renews the lease if an IP address has already been leased or obtains a new IP address if an IP has not been leased. 

####Example Code:
```squirrel
dhcp.renewLease();
```


### getIP()
The *getIP()* method returns the leased IP as an array of four integers. 

####Example Code:
```squirrel
dhcp.getIP();
```


### getDNS()
The *getDNS()* method returns the DNS as an array of four integers. 

####Example Code:
```squirrel
dhcp.getDNS();
```


### getSubnetMask()
The *getSubnetMask()* method returns the DNS as an array of four integers. 

####Example Code:
```squirrel
dhcp.getSubnetMask();
```


### getLeaseTime()
The *getIP()* method returns the lease duration as an integer. 

####Example Code:
```squirrel
dhcp.getLeaseTime();
```


### getRouterAddress()
The *getRouterAddress()* method returns the gateway address as an array of four integers. 
####Example Code:
```squirrel
dhcp.getRouterAddress();
```


## Extended Example on IMP0005
View [example.device.nut](example.device.nut) for an extended example.

## License
The Wiznet code is licensed under the [MIT License](./LICENSE).
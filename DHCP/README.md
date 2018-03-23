# Wiznet 5500 DHCP #

This library class enables Dynamic Host Configuration Protocol (DHCP) functionality for the Wiznet W5500 chip [W5500](http://wizwiki.net/wiki/lib/exe/fetch.php?media=products:w5500:w5500_ds_v106e_141230.pdf). It also requires the Wiznet W5500 driver.

**To add this code to your project, add** `#require W5500.DHCP.device.lib.nut:2.0.0` **after** `#require W5500.device.lib.nut:2.1.0` **at the top of your device code**

## Class W5500.DHCP ##

### Constructor: W5500.DHCP(*wiz*) ###

Instantiates a new W5500.DHCP object and passes in the main Wiznet driver.

#### Example ####

```squirrel
// Setup for an imp005
// Initialize the SPI port
interruptPin <- hardware.pinXC;
resetPin     <- hardware.pinXA;
spiSpeed     <- 1000;
spi          <- hardware.spi0;
spi.configure(CLOCK_IDLE_LOW | MSB_FIRST | USE_CS_L, spiSpeed);

// Initialise Wiznet and DHCP
wiz  <- W5500(interruptPin, spi, null, resetPin);
dhcp <- W5500.DHCP(wiz);
```

## Class Methods ##

### onLease(*callback*) ###

This method sets the function to be called when an IP address is leased. The callback function, which is not optional, has an *error* parameter which informs the user of timeouts and errors, or will be `null`.

#### Error Messages ####

| Error Message | Description |
| --- | --- |
| Offer Timeout | Discovery message sent with no response |
| Ack Timeout | Request message sent with no response |
| Renewal Timeout | Max Renewal attempts reached before a restart |
| Renewal Failed | Lease renewal failed |
| Request Declined | Requested IP not able to be leased |
| IP in use | Offered IP is currently in use |
| All connections in use | All Wiznet sockets are in use |

#### Example ####

```squirrel
dhcp.onLease(function(error) {
  if (error) return server.error(error);
  server.log("DHCP lease obtained");
});
```

### renewLease() ###

This method renews the lease or requests a new lease. When this is complete, the *onLease()* callback will be executed.

#### Example ####

```squirrel
dhcp.onLease(function(error) {
  // Run this code when IP address is obtained
  if (error) return server.error(error);
  server.log("DHCP lease obtained");
});

dhcp.renewLease();
```

### getIP() ###

This method returns the leased IP address as an array of four integers.

#### Example ####

```squirrel
local ip = dhcp.getIP();
server.log(format("IP address = %d.%d.%d.%d", ip[0], ip[1], ip[2], ip[3]));
```

### getSubnetMask() ###

This method returns the subnet mask as an array of four integers.

#### Example ####

```squirrel
local subnet_mask = dhcp.getSubnetMask();
server.log(format("Subnet mask = %d.%d.%d.%d", subnet_mask[0], subnet_mask[1], subnet_mask[2], subnet_mask[3]));
```

### getRouterAddress() ###

This method returns the gateway address as an array of four integers.

#### Example ####

```squirrel
local router = dhcp.getRouterAddress();
server.log(format("Router IP address = %d.%d.%d.%d", router[0], router[1], router[2], router[3]));
```

### getLeaseTime() ###

This method returns the lease duration, in seconds, as an integer.

#### Example Code:

```squirrel
local leaseTime = dhcp.getLeaseTime();
server.log("IP address lease time: " + leaseTime);
```

### getDNS() ###

This method returns an array of DNS entries, each of which is an an array of four integers.

#### Example ####

```squirrel
local dns = dhcp.getDNS();
foreach (index, server in dns) {
  server.log(format("DNS #%d address = %d.%d.%d.%d", (index + 1), server[0], server[1], server[2], server[3]));
}
```

## Extended Example For imp005 ##

Please see [example.device.nut](example.device.nut) for an extended example.

## License ##

The Wiznet code is licensed under the [MIT License](./LICENSE).

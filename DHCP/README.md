# Wiznet 5500 DHCP #

This library class enables Dynamic Host Configuration Protocol (DHCP) functionality for the [Wiznet W5500 chip](http://wizwiki.net/wiki/lib/exe/fetch.php?media=products:w5500:w5500_ds_v106e_141230.pdf). It also requires the Wiznet W5500 driver.

**To include this library in your project, add** `#require W5500.DHCP.device.lib.nut:2.0.0` **after** `#require W5500.device.lib.nut:2.1.1` **at the top of your device code**

## Class Usage ##

### Constructor: W5500.DHCP(*wiz*) ###

Instantiates a new W5500.DHCP object using the main Wiznet driver.

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *wiz* | Wiznet driver | Yes | The driver controlling the W5500 |

#### Returns ####

The instance.

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

This method registers the function that will be called when an IP address is leased.

#### Parameters ####

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *callback* | Function | Yes | The callback has one parameter of its own, *error*, which informs the user of timeouts and errors, or will be `null` |

#### Error Messages ####

| Error&nbsp;Message | Description |
| --- | --- |
| `"Offer Timeout"` | Discovery message sent with no response |
| `"Ack Timeout`" | Request message sent with no response |
| `"Renewal Timeout"` | Maximum Renewal attempts reached before a restart |
| `"Renewal Failed"` | Lease renewal failed |
| `"Request Declined"` | Requested IP not able to be leased |
| `"IP in use"` | Offered IP is currently in use |
| `"All connections in use"` | All Wiznet sockets are in use |

#### Example ####

```squirrel
dhcp.onLease(function(error) {
    if (error) return server.error(error);
    server.log("DHCP lease obtained");
});
```

### renewLease() ###

This method renews the lease or requests a new lease. When this is complete, the callback function registered with [*onLease()*](#onleasecallback) will be executed.

#### Returns ####

The instance (*this*).

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

This method retrieves the leased IP address.

#### Returns ####

Array &mdash; The leased IP address as four integers.

#### Example ####

```squirrel
local ip = dhcp.getIP();
server.log(format("IP address = %d.%d.%d.%d", ip[0], ip[1], ip[2], ip[3]));
```

### getSubnetMask() ###

This method retrieves the network subnet mask.

#### Returns ####

Array &mdash; The subnet mask as four integers.

#### Example ####

```squirrel
local subnetMask = dhcp.getSubnetMask();
server.log(format("Subnet mask = %d.%d.%d.%d", subnetMask[0], subnetMask[1], subnetMask[2], subnetMask[3]));
```

### getRouterAddress() ###

This method retrieves the network gateway address.

#### Returns ####

Array &mdash; The gateway address as four integers.

#### Example ####

```squirrel
local router = dhcp.getRouterAddress();
server.log(format("Router IP address = %d.%d.%d.%d", router[0], router[1], router[2], router[3]));
```

### getLeaseTime() ###

This method retrieves the lease duration in seconds.

#### Returns ####

Integer &mdash; the lease duration (seconds).

#### Example ####

```squirrel
local leaseTime = dhcp.getLeaseTime();
server.log("IP address lease time: " + leaseTime + "s");
```

### getDNS() ###

This method retrieves a set of DNS entries.

#### Returns ####

Array &mdash; The DNS entries, each of which is an array of four integers.

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

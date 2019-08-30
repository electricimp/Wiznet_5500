# Wiznet W5500 Tests #

All tests are configured for an imp005 Fieldbus Gateway. If a different imp device is used please update HardwareConfig.device.nut file taking care not to rename any of the constants or variables.

Test require an Echo Server and a Network configuration that contains a device that can issue a DHCP lease. Please see examples documentation for the [echo server](../examples/README.md#echo-server) and [network setting](../examples/README.md#dhcp-example) setup.

## Supporting Test Files ##

### BaseLibIncludes.device.nut ###

Includes files: W5500 library, WW5500.DHCP library and the testing HardwareConfig. This should be used as the device file in the .impt.config file.

### HardwareConfig.device.nut ###

Defines hardware pin variables and configures spi bus for all tests. 

### EchoNetworkSettings.device.nut ###

Source and echo server network settings. Used for test files 00.W5500, 01.W5500.DHCP, and 03.W5500.Listener.

### MicroTechIIISettings.device.nut ###

Source, router, and MTIII network settings. Used for test files 02.W5500.MicrotechIII.

## Test Setup ##

Update the `.impt.test` config file's "deviceGroupId" value with a device id from your Electric Imp account. 

### 00.W5500 & 01.W5500.DHCP ###

Configure an Echo server with network settings matching those in the EchoNetworkSettings.device.nut file. Connect Fieldbus Gateway to the echo server with a crossover ethernet cable. 

### 02.W5500.MicrotechIII ###

This is very specific hardware, and not intended for general library testing.
Leaving out of .impt.test config file, so will not run the the suite of tests. Setup directions TBD. 

### 03.W5500.Listener ###

As of  8/30/19 - Have not successfully opened a connection to the Source IP from the Source IP, so this test currently does NOT pass tests as written. Leaving out of .impt.test config file, so will not run the the suite of tests.

Setup directions TBD. 

## Running Tests  ##

All tests are run on the command line using impt test commands. Tests 00 & 01 have a similar setup and contain basic test coverage for the W5500 and W5500.DHCP libraries, so the current `.impt.test` config file is configured to run only these 2 test files.  

### Log into you account ###

```
impt auth login --user <user_id> --pwd <password>
```

or 

```
impt auth login --lk <login_key_id>] 
```

### Run tests ###

To run tests 00 & 02:

```
impt test run 
```

To select a specific test file to run. Update the `.impt.test` config file to include all tests by updating the "testFiles" value to the following:

```
    "testFiles": [
        "*.test.nut",
        "tests/**/*.test.nut"
    ],
```

Then select one of the following commands to run the tests in that file: 

```
impt test run --tests "tests/00.W5500.device.test.nut"
```

```
impt test run --tests "tests/01.W5500.DHCP.device.test.nut"
```

```
impt test run --tests "tests/02.W5500.MicroTechIII.device.test.nut"
```

```
impt test run --tests "tests/03.W5500.Listener.device.test.nut"
```
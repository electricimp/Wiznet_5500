# Wiznet W5500 Tests #

All tests are configured for an imp005 Fieldbus Gateway. If a different imp device is used please update HardwareConfig.device.nut file taking care not to rename any of the constants or variables.

## Supporting Test Files ##

### BaseLibIncludes.device.nut ###

Includes files: W5500 library, WW5500.DHCP library and the testing HardwareConfig. This should be used as the device file in the .impt.config file.

### HardwareConfig.device.nut ###

Defines hardware pin variables and configures spi bus for all tests. 

### EchoNetworkSettings.device.nut ###

Source and echo server network settings. Used for test files 00.W5500, 01.W5500.DHCP.

### MicroTechIIISettings.device.nut ###

Source, router, and MTIII network settings. Used for test files 02.W5500.MicrotechIII, 03.W5500.Listener.

## Test Setup ##

Update the `.impt.test` config file's "deviceGroupId" value with a device id from your Electric Imp account. 

### 00.W5500 & 01.W5500.DHCP ###

Configure an Echo server with network settings matching those in the EchoNetworkSettings.device.nut file. Connect Fieldbus Gateway to the echo server with a crossover ethernet cable. 

### 02.W5500.MicrotechIII ###

Setup directions TBD. 

### 03.W5500.Listener ###

Setup directions TBD. 

## Running Tests  ##

All test are run on the command line using impt test commands. Tests 00 & 01 have a similar setup and contain basic test coverage for the W5500 and W5500.DHCP libraries, so the current `.impt.test` config file is set up to run only these 2 test files.  

### Log into you account ###

```
impt auth login --user <user_id> --pwd <password>
```

or 

```
impt auth login --lk <login_key_id>] 
```

### Run tests ###

To run all tests specified in the `.impt.test` config file:

```
impt test run 
```

To select a specific test file to run, ie override the tests specified in the `.impt.test` config file, select one of the following commands: 

```
impt test run --tests "00.W5500.device.test.nut"
```

```
impt test run --tests "01.W5500.DHCP.device.test.nut"
```

```
impt test run --tests "02.W5500.MicrotechIII.device.test.nut"
```

```
impt test run --tests "03.W5500.Listener.device.test.nut"
```
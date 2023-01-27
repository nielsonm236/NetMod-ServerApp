# NetMod-ServerApp

Reprogramming the Web_Relay_Con V2.0 HW-584 Network Module
Did you buy one (or more) of these Network Modules and then find disappointment in the software on the board?
-	In the original from-the-factory firmware all of the modules have the same MAC address. That's a problem if you want more than one module on your network. And the supplier does not give you a way to change the MAC.
-	If you change the IP Address the device returns to its default IP Address when it power cycles. That makes it pretty much useless even if you only put one on your network - unless you're OK with it always having IP Address 192.168.1.4.

I decided to write my own firmware for the device to provide a web server interface that let's you change the IP Address, Gateway (Default Router) Address, Netmask, Port number (a REAL port number), and MAC Address. I also added the ability for the device to remember all these settings through a power cycle. Any Relay settings you make are also optionally saved through a power cycle. In addition the Network Module can be operated as a generic MQTT device or as a Home Assistant device with Auto Discovery.

See the Wiki for links to the Youtube videos on how to install and operate the firmware.

Contact: You can reach me at nielsonm.projects@gmail.com. But questions can also be asked via the Issues section. Sometimes others have the same questions and Q&A in the Issues section might help them out.

Feature Comparison of the MQTT and Browser builds:
|                             |       |         |             |              |             |
|:----------------------------|:-----:|:-------:|:-----------:|:------------:|:-----------:|
|                             | MQTT  | Browser |    MQTT     | Browser Only |   MQTT w/   |
|                             | Build |  Only   | Upgradeable |  Upgradeable |   BME280    |
|                             |       | Build   |    Build    |     Build    | Upgradeable |
| --------- Feature --------- |       |         |             |              |    Build    |
|MQTT Support                 |   x   |         |      x      |              |      x      |
|Home Assistant Support       |   x   |         |      x      |              |      x      |
|Browser IO Control           |   x   |    x    |      x      |       x      |      x      |
|Browser Configuration        |   x   |    x    |      x      |       x      |      x      |
|Full/Half Duplex             |   x   |    x    |      x      |       x      |      x      |
|Link Error Statistics        |   x   |    x    |      x      |       x      |             |
|DS18B20 Temp Sensor          |   x   |    x    |      x      |       x      |             |
|IO Naming                    |       |    x    |             |       x      |             |
|IO Timers                    |       |    x    |             |       x      |             |
|Network Statistics           |       |    x    |             |       x      |             |
|I2C Support                  |       |         |      x      |       x      |      x      |
|Upgradeable over Ethernet  * |       |         |      x      |       x      |      x      |
* "Upgradeable over Ethernet" requires additonal hardware - see Manual

Short summary of recent history:

January 25, 2023 - Addressed Issue #132 “Linked pins Output states not correct after reboot” and Issue #93 “Add BME280 Temperature Humidity Pressure sensor”

December 17, 2022 - Addressed Issues #113 and #118 both related to Home Assistant Header Toggle, deprecated DS18B20 "hot add", addressed Issue #116 “Link Input pin to an Output pin”, addressed Issue #112 “Request to change output pins in “batch mode””, addressed Issue #126 “Malformed REST commands produce garbage Browser page”, addressed Issue #123 “Allow short press of Reset button to reboot the module", fixed several minor bugs.

October 9, 2022 - Fixed Issue #94: “ENC28J60 Revision not always reported in Link Error Statistics”. Added Enhancement Issue #100 “Remove Configuration Button”. This is an option to disable the Configuration button on the IOControl page. Fixed Issue #108 "Temperature sensors loose custom names in HA on NetModule boot". Fixed #110 “Can’t enter full 19 character Device name” – a bug made apparent in the 20220921 release. Fixed #109 “Home Assistant Not Showing Sensors in Fahrenheit” -  a bug made apparent in the 20220921 release

August 31,2022 - Added useability enhancement "Make ON/OFF labels clickable"

August 17, 2022 - Fixed "MQTT state-req returning all zeroes".

February 5, 2022 - Fixed "IOControl Save causes loss of Configuration".

Help is available via a link in the Configuration page that will take you to the GitHub Wiki page. All functionality is described in detail in the "Network Module Manual". I suggest you take a look.

If you upgrade from a pre-January 2021 version you will find that your Device Name, IP Address, Port Numbers, and MAC address entries are retained. However, since pins are now individually assigned your pinout settings will have to be re-entered in the Configuration page. Note that firmware downgrade is not supported in an automated way. Check the Network Module Manual for downgrade instructions.

Videos: See the video links in the Wiki

Many thanks to Carlos Ladeira and Jevgeni Kiski for their many hours of work in the 2021 releases. Their collaboration greatly improved the code for everyone.

Tested with:
- Windows 10 Firefox 104.0.2 (64-bit)
- Windows 10 Chrome 105.0.5195.102 (64-bit)
- Windows 10 Edge 105.0.1343.33 (64-bit)
- Mac Safari Version 14.0.2
- Mac Edge 87.0.664.75
- Mac Opera 73.0.3856.344
- Mac Firefox 84.0.2
- Mac Firefox 72.0.2
- Ubuntu 20.10 - Firefox 84.0.1 (64-bit)
- Ubuntu 20.10 - Chromium 87.0.4280.88 (64-bit)
- iPhone Safari on iOS 15.6.1
- iPhone Chrome 105.0.5195.100 on iOS 15.6.1
- Mosquitto
- Node-Red
- Chrome MQTTLens
- Home Assistant

- IE - NOT SUPPORTED - It won't work with the javascript that is now part of the Browser GUI.

IMPORTANT NOTE: The software provided in this project only works with the “Web_Relays_Con V2.0 HW-584” which is based on the STM8S-005 or STM8S-105 processor and ENC28J60 ethernet controller. I haven't tried it with any other version of the hardware. I think the V.1 FC-160 is based on a Nuvoton processor and this code and the tools are incompatible.

NOTE: I am not in any way associated with the manufacturer of this device. I only wrote code to run on it for my own hobby purposes, and I am making it available for other hobbyists.

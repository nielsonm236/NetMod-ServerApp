# NetMod-ServerApp

Reprogramming the Web_Relay_Con V2.0 HW-584 Network Module
Did you buy one (or more) of these Network Modules and then find disappointment in the software on the board?
-	In the original from-the-factory firmware all of the modules have the same MAC address. That's a problem if you want more than one module on your network. And the supplier does not give you a way to change the MAC.
-	If you change the IP Address the device returns to its default IP Address when it power cycles. That makes it pretty much useless even if you only put one on your network - unless you're OK with it always having IP Address 192.168.1.4.

I decided to write my own firmware for the device to provide a web server interface that let's you change the IP Address, Gateway (Default Router) Address, Netmask, Port number (a REAL port number), and MAC Address. I also added the ability for the device to remember all these settings through a power cycle. Any Relay settings you make are also optionally saved through a power cycle. In addition the Network Module can be operated as a generic MQTT device or as a Home Assistant device with Auto Discovery.

See the Wiki for links to the Youtube videos on how to install and operate the firmware.

Contact: You can reach me at nielsonm.projects@gmail.com. But questions can also be asked via the Issues section. Sometimes others have the same questions and Q&A in the Issues section might help them out.

Feature Comparison of the MQTT and Browser builds:

|                              |       |       |         |       |       |         |        |        |
|:-----------------------------|:-----:|:-----:|:-------:|:-----:|:-----:|:-------:|:------:|:------:|
|                              | MQTT  | MQTT  | Browser | MQTT  | MQTT  | Browser |  MQTT  |  MQTT  |
|                              | Home  | Domo  |  Only   | Home  | Domo  |  Only   |  Home  |  Domo  |
|                              | Asst  | Build |  Build  | Asst  | UPG   |  UPG    |  Asst  | BME280 |
|                              | Build |       |         | UPG   | Build |  Build  | BME280 |  UPG   |
|                              |       |       |         | Build |       |         |  UPG   |  Build |
|                              |       |       |         |       |       |         |  Build |        |
|-------- Feature -------      |       |       |         |       |       |         |        |        |
|SWIM Install                  |   x   |   x   |    x    |       |       |         |        |        |
|Upgradeable (Ethernet) Install|       |       |         |   x   |   x   |    x    |   x    |   x    |
|MQTT Support                  |   x   |   x   |         |   x   |   x   |         |   x    |   x    |
|Home Assistant Support        |   x   |       |         |   x   |       |         |   x    |        |
|Domoticz Support              |       |   x   |         |       |   x   |         |        |   x    |
|Browser IO Control            |   x   |   x   |    x    |   x   |   x   |    x    |   x    |   x    |
|Browser Configuration         |   x   |   x   |    x    |   x   |   x   |    x    |   x    |   x    |
|Full/Half Duplex              |   x   |   x   |    x    |   x   |   x   |    x    |   x    |   x    |
|DS18B20 Temp Sensor           |   x   |   x   |    x    |   x   |   x   |    x    |        |        |
|BME280 Sensor                 |       |       |         |       |       |         |   x    |   x    |
|IO Naming                     |       |       |    x    |       |       |    x    |        |        |
|IO Timers                     |       |       |    x    |       |       |    x    |        |        |
|Link Error Statistics         |   x   |   x   |    x    |   x   |   x   |    x    |        |        |
|Network Statistics            |       |       |    x    |       |       |    x    |        |        |
|I2C Support                   |       |       |         |   x   |   x   |    x    |   x    |   x    |
|Linked Pin Support            |   x   |   x   |    x    |   x   |   x   |    x    |        |        |
|PCF8574 Support               |       |       |         |   x   |   x   |    x    |        |        |
|Alternative Pinout Support    |   x   |   x   |    x    |       |       |         |        |        |
|Response Lockout Support      |       |       |    x    |   x   |   x   |    x    |   x    |   x    |

IMPORTANT: "Upgradeable (Ethernet) Install" requires additonal hardware - see Manual

Short summary of recent history. See the change log in the manual and the Issues List for full descriptions.

June 12, 2024 - Addressed several Issues: Maintenance: #193, #208, User Info: #195, #204. Features: #203, #211, #212, #214, Bugs: #210, #217, #218, #219, #220, #222.

October 9, 2023 - Added Domoticz support and addressed several other Issues: #199, #200, #201, #202, #205, #206, #207.

August 3, 2023 - Addressed numerous issues, most relatively small. Issues: #172, #174, #179, #180, #181, #183, #184, #185, #187, #188, #189, #190, and #191.

June 3, 2023 - Addressed Issues: #175, #176.

April 16, 2023 - Addressed Issues: #159, #167.

March 28, 2023 - Addressed Issue #164.

March 25, 2023 - Addressed Issue #161.

March 24, 2023 - Addressed Issues: #147, #158.

March 12, 2023 - Addressed Issues: #115, #120, #152.

January 25, 2023 - Addressed Issues: #132, #93.

December 17, 2022 - Addressed Issues: #113, #118, #116, #112, #126, #123, fixed several minor bugs.

Help is available via a link in the Configuration page that will take you to the GitHub Wiki page. All functionality is described in detail in the "Network Module Manual". I suggest you take a look.

If you upgrade from a pre-January 2021 version you will find that your Device Name, IP Address, Port Numbers, and MAC address entries are retained. However, since pins are now individually assigned your pinout settings will have to be re-entered in the Configuration page. Note that firmware downgrade is not supported in an automated way. Check the Network Module Manual for downgrade instructions.

Videos: See the video links in the Wiki

Many thanks to Carlos Ladeira and Jevgeni Kiski for their many hours of work in the 2021 releases. Their collaboration greatly improved the code for everyone.

I haven't updated the "Tested with" section in awhile. Suffice it to say that the firmware has continued to work without issues resulting from external application  updates.
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

# NetMod-ServerApp

Reprogramming the Web_Relay_Con V2.0 HW-584 Network Module
Did you buy one (or more) of these Network Modules and then find disappointment in the software on the board?
-	In the original from-the-factory firmware all of the modules have the same MAC address. That's a problem if you want more than one module on your network. And the supplier does not give you a way to change the MAC.
-	If you change the IP Address the device returns to its default IP Address when it power cycles. That makes it pretty much useless even if you only put one on your network - unless you're OK with it always having IP Address 192.168.1.4.

I decided to write my own firmware for the device to provide a web server interface that let's you change the IP Address, Gateway (Default Router) Address, Netmask, Port number (a REAL port number), and MAC Address. I also added the ability for the device to remember all these settings through a power cycle. Any Relay settings you make are also optionally saved through a power cycle. In addition the Network Module can be operated as a generic MQTT device or as a Home Assistant device with Auto Discovery.

Contact: You can reach me at nielsonm.projects@gmail.com. But questions can also be asked via the Issues section. Sometimes others have the same questions and Q&A in the Issues section might help them out.

Feature Comparison of the MQTT and Browser builds:
|Feature                      | MQTT  | Browser |    MQTT     | Browser Only |
|:----------------------------|:-----:|:-------:|:-----------:|:------------:|
|                             | Build |  Only   | Upgradeable |  Upgradeable |
|                             |       | Build   |    Build    |     Build    |
|MQTT Support                 |   x   |         |      x      |              |
|Home Assistant Support       |   x   |         |      x      |              |
|Browser IO Control           |   x   |    x    |      x      |       x      |
|Browser Configuration        |   x   |    x    |      x      |       x      |
|Full/Half Duplex             |   x   |    x    |      x      |       x      |
|Link Error Statistics        |   x   |    x    |      x      |       x      |
|DS18B20 Temp Sensor          |   x   |    x    |      x      |       x      |
|IO Naming                    |       |    x    |             |       x      |
|IO Timers                    |       |    x    |             |       x      |
|Network Statistics           |       |    x    |             |       x      |
|I2C Support                  |       |         |      x      |       x      |
|Upgradeable over Ethernet  * |       |         |      x      |       x      |
* "Upgradeable over Ethernet" requires additonal hardware - see Manual

Short summary of release history:
August 17, 2022 - Fixed "MQTT state-req returning all zeroes".

February 5, 2022 - Fixed "IOControl Save causes loss of Configuration".

August 20, 2021 - Several fixes and added the ability to upgrade firmware over Ethernet via the Browser GUI (requires added EEPROM device - see Manual).

May 9, 2021 - Numerous fixes and improvements for HA Auto Discovery, Temperature Sensors, and Timers

April 12, 2021 - Released a parallel build for "Browser Only" users that does not include MQTT, but adds some requested features for users that do not want MQTT. The "Browser Only" version includes individual IO Names, IO Timers, and restores the Network Statistics page.

February 20, 2021 - Added a UART debug interface for use by developers. Beginning with this release you should obtain Source Code and Executables from the "Release" area of the GitHub page (along the right margin of the page).

February 8, 2021 - Added an interface for up to 5 DS18B20 temperature sensors.

January 23, 2021 - A much improved Browser interface with the ability to define input/output pins individually. As a result there was no longer a need to have separate builds for the various configurations. Auto Discovery was added to the Home Assistant interface.

August 13, 2020 - Added support for 16 outputs, OR 8 outputs / 8 inputs, OR 16 inputs in three separate builds, plus an MQTT build with 8 outputs / 8 inputs, plus support for Home Assistant.

June 13, 2020 - A simple Browser Only GUI supporting 16 output pins with retention of all user settings through reboot and power cycles.

Help is avaialble via a link in the Configuration page that will take you to the GitHub Wiki page. All functionality is described in detail in the "Network Module Manual". I suggest you take a look.

If you upgrade from a pre-January 2021 version you will find that your Device Name, IP Address, Port Numbers, and MAC address entries are retained. However, since pins are now individually assigned your pinout settings will have to be re-entered in the Configuration page. Note that firmware downgrade is not supported in an automated way. Check the Network Module Manual for downgrade instructions.

Videos: See the video links in the Wiki

Many thanks to Carlos Ladeira and Jevgeni Kiski for their many hours of work in the 2021 releases. Their collaboration greatly improved the code for everyone.

Tested with:
- Windows 10 Firefox 91.0 (64-bit)
- Windows 10 Chrome 92.0.4515.131 (64-bit)
- Windows 10 Edge 92.0.902.73 (64-bit)
- Mac Safari Version 14.0.2
- Mac Edge 87.0.664.75
- Mac Opera 73.0.3856.344
- Mac Firefox 84.0.2
- Mac Firefox 72.0.2
- Ubuntu 20.10 - Firefox 84.0.1 (64-bit)
- Ubuntu 20.10 - Chromium 87.0.4280.88 (64-bit)
- iPhone Safari on iOS 14.7.1
- iPhone Chrome 92.0.4515.90 on iOS 14.7.1
- Mosquitto
- Node-Red
- Chrome MQTTLens
- Home Assistant

- IE - NOT SUPPORTED - It won't work with the javascript that is now part of the Browser GUI.

IMPORTANT NOTE: The software provided in this project only works with the “Web_Relays_Con V2.0 HW-584” which is based on the STM8S-005 or STM8S-105 processor and ENC28J60 ethernet controller. I haven't tried it with any other version of the hardware. I think the V.1 FC-160 is based on a Nuvoton processor and this code and the tools are incompatible.

NOTE: I am not in any way associated with the manufacturer of this device. I only wrote code to run on it for my own hobby purposes, and I am making it available for other hobbyists.


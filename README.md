# NetMod-ServerApp

Reprogramming the Web_Relay_Con V2.0 HW-584 Network Module
Did you buy one (or more) of these Network Modules and then find disappointment in the software on the board?
-	In the original from-the-factory firmware all of the modules have the same MAC address. That's a problem if you want more than one module on your network. And the supplier does not give you a way to change the MAC.
-	If you change the IP Address the device returns to its default IP Address when it power cycles. That makes it pretty much useless even if you only put one on your network - unless you're OK with it always having IP Address 192.168.1.4.

I was disappointed enough that I decided to reprogram the device to provide a web server interface that let's you change the IP Address, Gateway (Default Router) Address, Netmask, Port number (a REAL port number), and MAC Address. I also added the ability for the device to remember all these settings through a power cycle. Any Relay settings you make are also saved through a power cycle. In addition the Network Module can be operated as a generic MQTT device or as a Home Assistant device with Auto Discovery.

Short summary of release history:
June 13, 2020 - A simple Browser Only interface was developed with the primary focus being retention of all user settings through reboot and power cycles. The release only supported 16 output pins This release was last updated in August 6, 2020 and was retired at that time but is still available in a zip file named "20200806_retired_release.zip".
August 13, 2020 - Added the ability to support 16 outputs, OR 8 outputs / 8 inputs, OR 16 inputs in three separate builds. Over time MQTT was added to the code, resulting in a 4th separate build of 8 outputs / 8 inputs supporting MQTT, and by December the code also supported Home Assistant with a crude form of Home Assistant Auto Discovery. The last update to this build occurred on December 30, 2020. It has now been retired, but it is still available in a zip file named "20201230_0411_retired".
January 23, 2021 - Latest release series. Provides a much improved Browser interface with the ability to define each pin as an Input or Output, each pin has its own Invert checkbox, and each pin can be individually set to power up as ON, OFF, or with its state prior to a power loss. As a result there is now only 1 pre-built firmware to handle all pinout configurations and MQTT (no longer need 4 separate builds!). In addition the Home Assistant interface is greatly improved with automatic reconfiguration of pin controls in Home Assistant when a user changes the Network Module configuration in its Browser.

Unfortunately with the new release Help is no longer built into the Network Module firmware. Instead the Configuration page includes a link to the Wiki page on this site. The Network Statistics were also removed from the firmware due to lack of memory.

Current users that upgrade to the new release will find that their Device Name, IP Address, Port Numbers, and MAC address entries are retained. However, since pins are now individually assigned, the pinout settings will have to be re-entered in the Configuration page. Note that firmware downgrade is not supported in an automated way. Check the Network Module Manual for downgrade instructions.

All functionality is described in detail in the "Network Module Manual". I suggest you take a look.

Videos: I have not updated the YouTube videos yet. The "Network Module Manual" illustrates all the differences and the programming steps are the same, so the videos will be updated over the next few weeks. See the video links in the Wiki.

Many thanks to Carlos Ladeira and Jevgeni Kiski for their many hours of work in the January 2021 release. Their collaboration with me greatly improved the code for everyone.

Tested with:
- Windows 10 Firefox 84.0.2 (64-bit)
- Windows 10 Chrome 87.0.4280.141 (64-bit)
- Windows 10 Chrome 88.0.4324.104 (64-bit)
- Windows 10 Edge 87.0.664.75 (64-bit)
- Windows 10 Edge 88.0.705.50 (64-bit)
- Mac Safari Version 14.0.2
- Mac Edge 87.0.664.75
- Mac Opera 73.0.3856.344
- Mac Firefox 84.0.2
- Mac Firefox 72.0.2
- Ubuntu 20.10 - Firefox 84.0.1 (64-bit)
- Ubuntu 20.10 - Chromium 87.0.4280.88 (64-bit)
- iPhone Safari on iOS 14.3
- iPhone Chrome 87.0.4280.77 on iOS 14.3
- Mosquitto
- Node-Red
- Chrome MQTTLens
- Home Assistant

- IE - NOT SUPPORTED - It won't work with the javascript that is now part of the Browser GUI.

IMPORTANT NOTE: The software provided in this project only works with the “Web_Relays_Con V2.0 HW-584” which is based on the STM8S-005 or STM8S-105 processor and ENC28J60 ethernet controller. I haven't tried it with any other version of the hardware. I think the V.1 FC-160 is based on a Nuvoton processor and this code and the tools are incompatible. NOTE: I am not in any way associated with the manufacturer of this device. I only wrote code to run on it for my own hobby purposes, and I am making it available for other hobbyists.


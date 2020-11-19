# NetMod-ServerApp
Reprogramming the Web_Relay_Con V2.0 HW-584 Network Module
Did you buy one (or more) of these Network Modules and then find disappointment in the software
on the board?
-	All of the modules have the same MAC address. That's a problem if you want more than one on
    your network. And the supplier does not give you a way to change the MAC.
-	If you change the IP Address the device returns to its default IP Address when it power
    cycles. That makes it pretty much useless even if you only put one on your network - unless
	you're OK with it always having IP Address 192.168.1.4.

I was disappointed enough that I decided to reprogram the device to provide a web server
interface that let's you change the IP Address, Gateway (Default Router) Address, Netmask, Port
number (a REAL port number), and MAC Address. I also added the ability for the device to remember
all these settings through a power cycle. Any Relay settings you make are also saved through
a power cycle.

I've retired the previous release last updated August 6, 2020. It remains available in a zip file
named "20200806_retired_release.zip".

The new release series starting November 16, 2020 has all the same functionality as the previous
release, but numerous code changes were made to condense the Flash code size to make room for the
addition of MQTT functionality. You can now download four different code builds:
1) NetworkModule-16out (same functions as the prior release).
2) NetworkModule-8out (same functions as the prior release).
3) NetworkModule-16in (same functions as the prior release).
4) NetworkModule-8outMQTT (same as the -8out build but also adds MQTT functionality).

Current users that upgrade to the new release SHOULD find that all their settings remain intact.
You will also see the following differences in the web browser interface:
a) The "Address Settings" page is now called "Configuration".
b) The Device Name still appears on the IO Control page, but the field to edit the Name is now
   on the Configuration page.
c) The Invert Output setting moved to the Configuration page.
d) The Configuration page has a "Config" field for providing Invert Ouput, Invert Input,
   Retain/Set/Clear outputs on power cycle, and Full/Half Duplex mode on the Ethernet connection.

The new release includes numerous bug fixes to fix browser corner cases, so even if you won't be
using MQTT it should be beneficial. A user let me know that the old release did not work on
Safari. I don't have access to a Mac or Safari at this time, but I tried Safari on my iPhone with
the new release and it seemed to work fine. So hopefully users will find that Safari now works.
Let me know!

The MQTT functionality is described in detail in the "Network Module Reprogram Doc" so won't cover
that here. But current users will find that the "Help" and "Network Statistics" browser pages are
removed from the MQTT build. This was necessary to make Flash space available.

Videos: I have not updated the YouTube videos yet. The "Network Module Reprogram Doc" illustrates
all the differences and the programming steps are the same, so the videos will be updated over
the next few weeks.

Many thanks to Carlos Ladeira for his help with user interface ideas, many hours of testing, and
his patience during development of the MQTT version of this code. His collaboration was extremely
helpful.

See videos listed in the Wiki.

Tested with:
- Firefox 82.0.3 64bit
- Chrome 87.0.4280.66 64bit
- Edge 86.0.622.69 64bit
- Internet Explorer 11.630.19041.0

IMPORTANT NOTE: The software provided in this project only works with the “Web_Relays_Con V2.0
HW-584” which is based on the STM8S-005 processor and ENC28J60 ethernet controller. I haven't 
tried it with any other version of the hardware. I think the V.1 FC-160 is based on a Nuvoton 
processor and this code and the tools are incompatible. NOTE: I am not in any way associated 
with the manufacturer of this device. I only wrote code to run on it for my own hobby purposes, 
and I am making it available for other hobbyists.


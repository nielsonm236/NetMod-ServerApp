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

IMPORTANT NOTE: The software provided in this project only works with the “Web_Relays_Con V2.0
HW-584” which is based on the STM8S-005 processor and ENC28J60 ethernet controller. I haven't 
tried it with any other version of the hardware. I think the V.1 FC-160 is based on a Nuvoton 
processor and this code and the tools are incompatible. NOTE: I am not in any way associated 
with the manufacturer of this device. I only wrote code to run on it for my own hobby purposes, 
and I am making it available for other hobbyists.


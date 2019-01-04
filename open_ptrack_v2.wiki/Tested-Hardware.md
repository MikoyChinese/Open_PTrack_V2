## Tested Hardware

This section covers the equipment we have tested and have found to work reliably and continuously. This is not a definitive list of the hardware or hardware configurations that will work with OpenPTrack. This should be used as a starting point for hardware procurement. 
  
**What to run on each computer:**

Our tested configurations include:
- One computer per Kinect imager, sometimes also running a Swissranger (when connecting two Kinects to a single CPU, tracking on one Kinect will generally fail).
- One computer with a CPU utilization of no more than 70% from detection processes also running the tracking process.
- A separate laptop running RViz visualizations of the tracking. 

We have found that one computer with a single i5 or i7 CPU can only process data from a single Kinect paired with a Mesa SwissRanger. We strongly suggest each imager has a dedicated computer, otherwise tracking is likely to degrade in terms of density of the tracked path, or the ability to detect at all. 

It is also important to watch each computer’s system resources so that CPU utilization per core does not exceed 80%. Otherwise, tracking is likely to degrade. 

We highly recommend that the RViz visualization component is run on a separate computer that is not running detection or tracking processes. Nodes running detection and/or tracking should *only* perform those functions.

**Recommended Configurations:**

Based on our experience, we suggest any computer being used in an OpenPtrack system meet the following minimum hardware specifications:

- Intel i7 processor (as fast as possible)
- 8GB of RAM
- at least 40GB free space
- NVIDIA GPU (for Kinect v2 support)

**N.B.:** The NVIDIA GPUs that have worked for us so far: NVidia GeForce 650, 660, 670, 740, 750, 760, 770, 840, 850, 860, and 870. 384 CUDA cores or more is recommended.

**N.B.:** For the Kinect v2 a quad-core CPU with at least 2.2 GHz of frequency and 4MB (6MB preferably) of L2 or L3 cache is recommended. 


**Imagers:**

We have tested the following imagers:

- [Kinect v1 for XBox 360](https://support.xbox.com/en-US/browse/xbox-360/accessories/Kinect)
- [Kinect v2](https://support.xbox.com/en-US/browse/xbox-one/accessories)
- [Mesa SwissRanger 4500](http://hptg.com/industrial/)

**Computer Manufacturers:**

We have tested the following hardware: 

- Axiomtek Fanless:
     - [IPC912-213-FL](http://us.axiomtek.com/Default.aspx?MenuId=Products&FunctionId=ProductView&ItemId=7444&upcat=261)
     - [IPC932-230-FL](http://us.axiomtek.com/Default.aspx?MenuId=Products&FunctionId=ProductView&ItemId=7545&upcat=261)
- Shuttle: 
     - [SZ87R6](http://www.shuttle.eu/products/discontinued/barebones/sz87r6/)

**USB Cable Extenders:**

USB Cable extenders are critical to locating Kinects and other imagers away from compute nodes. Not all work well!  We have tested the following: 

- USB 2.0 over Ethernet Extenders:
     - [Gefen EXT-USB2-0-LR](http://www.gefen.com/kvm/ext-usb2.0-lr.jsp?prod_id=5529)
     - Black Box IC400A
- USB 3.0 Extension Cables:
     - [Black Box IC502A](http://www.blackbox.com/Store/Detail.aspx/USB-3-0-Ultimate-Fiber-Extender/IC502A)
     - [Tripp Lite U328-025 (25ft)](http://www.tripplite.com/usb-3.0-superspeed-active-repeater-cable-a-b-male-25-ft~U328025/)
     - [SIIG USB JU-CB0811-S1 (20meters)](http://www.siig.com/usb-3-0-active-repeater-cable-20m.html)
          *-Note: The use of the included power supply is necessary*

**Networking Hardware:**

There is nothing particularly special about the networking hardware. However, we suggest having a dedicated gigabit switch connecting all of the OpenPTrack nodes. We recommend a firewall / VPN router as the interface to the Internet or any other general purpose network. 

- Router:
     - [TP-LINK TL-ER6120](https://www.tp-link.com/no/products/details/cat-4909_TL-ER6120.html)
     - [TP-LINK TL-R600VPN](https://www.tp-link.com/us/products/details/cat-4909_TL-R600VPN.html)
- Switch:
     - [Netgear JGS516](http://support.netgear.com/product/JGS516)
     - [Netgear GS116E](http://support.netgear.com/product/gs116e)
- Access Point:
     - [Ubiquiti UAP-LR-US](https://www.ubnt.com/unifi/unifi-ap/)
     - [EnGenius EAP600](https://www.engeniustech.com/engenius-products/indoor-wireless-ceiling-ap-eap600/)

**Miscellaneous Hardware:**

We often use the following parts in our installations:

- [Kinect v1 - 1/4-20 Mount](http://www.monoprice.com/Product?p_id=8682&catargetid=320013720000066114&cadevice=c&kpid=108682&gclid=Cj0KEQjwmLipBRC59O_EqJ_E0asBEiQATYdNh2CZOkHuAMUaFKSUPQ_OTOkFkdZk6OJCBlfh4l1txBQaAgR08P8HAQ)
- [Manfrotto 492 Ball head for SwissRanger](http://www.manfrotto.com/492-micro-ball-head)
- Harting Male M12 to Female Ethernet Adapter for SwissRanger
- Camera mounts or tripods to mount the imagers
- VGA or DVI KVM
- Power Conditioner:
     - [Furman PL-PLUS C 15 Amp](http://www.furmansound.com/product.php?div=01&id=PL-PLUSC)

**Cables to have on hand:**

- bulk Cat-5e/Cat-6
- extension cords
- cube taps
- extra USB A to B cables
- power strips
- IEC cables
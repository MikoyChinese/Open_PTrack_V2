# Camera Mounting:

This section describes a few methods of installing and mounting imagers for temporary and permanent installations. Also covered is imager placement in the installation space, the Kinect field of view, and other imager specifications that need to be considered before installing OpenPTrack. 

Before deciding how to mount the sensors for your OpenPTrack installation, you should consider: Will the installation be temporary or permanent? 

**Temporary Installation:**

If your installation is temporary, using the [Manfrotto 1004BAC](http://www.manfrotto.com/master-stand) light stand or any light stand that is higher than 6ft, with a ball head such as the [Manfrotto 492](http://www.manfrotto.com/492-micro-ball-head), will provide flexibility of camera placement within the space and allow the camera’s FOV to be reconfigured easily.  

**N.B.:** We have also used [Middle Atlantic MFR-1227GE MFR Series Mobile Furniture Rack](http://www.middleatlantic.com/products/racks-enclosures/mobile-racks-carts/mfr-series-mobile-furniture-rack/mfr-1227ge.aspx), [SKB 8U Shock Mount Rack](http://www.skbcases.com/music/products/proddetail.php?f=&id=127&o=new&c=116&s=), and the [SKB 6U Rolling rack](http://www.skbcases.com/industrial/products/prod-detail.php?id=534#.VS7Dv_nF-So) to store the OpenPTrack computing and routing, for mobile and temporary installations.  

**Permanent Installation:**

For permanent installations, using camera mounts with integrated ball heads will provide the most flexibility for modifying the sensor’s FOV after installation, such as the [Manfrotto 356](http://www.manfrotto.com/wall-mount-camera-support).
 
**Kinect Wall-mounted:**
![](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/images/Kinect_wall_mount.jpg?raw=true)

**Sensors can also be mounted to a drop ceiling with the following parts:**

SwissRanger:

- [Matthews Drop Ceiling Scissor Clamp with Baby (5/8") Pin](http://www.bhphotovideo.com/c/product/33229-REG/Matthews_429678_Drop_Ceiling_Scissor_Clamp.html)
- [Manfrotto 016 Broncolor Adapter](https://www.manfrotto.us/broncolor-adapter-converts-5-8-female-3-8-tip-w-12mm-shaft)

Kinect:

- [Matthews Drop Ceiling Scissor Clamp with Baby (5/8") Pin](http://www.bhphotovideo.com/c/product/33229-REG/Matthews_429678_Drop_Ceiling_Scissor_Clamp.html)
- [Manfrotto 016 Broncolor Adapter](https://www.manfrotto.us/broncolor-adapter-converts-5-8-female-3-8-tip-w-12mm-shaft)
- [Manfrotto 014-38 Rapid Adapter](http://www.manfrotto.us/rapid-adapt-converts-5-8-light-stand-tip-17mm-3-8m-thread?product_only=1)
- [Manfrotto 492](http://www.manfrotto.com/492-micro-ball-head)

**Drop Ceiling Example:**

![](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/images/Kinect_ceiling_mount.jpg?raw=true)

**General Camera Placement and Field of View Considerations:** 

When determining sensor placement, a few things should be taken into consideration per imager:
- Access to power
- Access to associated computer 
- Direct sunlight, or lighting that produces large amounts of IR. Both should be avoided.
- The ability for the imager’s field of view (FOV) to overlap with at least one other imager’s FOV for calibration purposes
- The max distance (from the sensor) expected to be tracked should be no greater than:
     - Kinect v1: 4.5 meters
     - Kinect v2: 10 meters
     - Mesa SwissRanger: 8 meters

For Kinect v1, we have found that placing the sensors approx. 10ft-12ft apart in parallel, then overlapping the FOV, produces reliable tracking results. When placing the sensors, one should also consider that imagers should be placed at all corners of the tracking area, and then additional imagers should be placed along the edges to fill gaps as needed. This will allow for the greatest FOV coverage and overlap.

**Example Camera Installation:**

![](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/images/OPT_Imager_Layout.png?raw=true)
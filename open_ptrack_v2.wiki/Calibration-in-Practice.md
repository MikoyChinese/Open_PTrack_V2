# Calibration

**Sensor's Field of View:**
Before starting calibration, we have found it best for Rviz to be started and for a mono video feed to be displayed from each sensor.

**Example:**
![](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/images/Calibartion_Rviz.png?raw=true)

Then, while one person is watching the camera video feeds, another person walks around the predetermined tracking area. One should watch:
- That the person being tracked can always be seen by a minimum of two sensors.
- That each sensor FOV overlaps with another camera’s FOV, within the max tracking range.
- That, within the tracking extents, the person’s entire body is in frame, and that the head and feed are not cut off.
- That each sensor FOV is as level as possible with the ground plane.
- That the image does not flicker (if it does, this is generally an artifact of a CPU overload).
- That the FOV can be locked and secured in place (any movement will impact and degrade tracking).

**Calibration Best Practices:**
Before starting the calibration process, one should have the largest checkerboard printed that they can. The larger the checkers, the less error that will be introduced into tracking. Also, the checkerboard needs to be printed on half-inch or thicker foam core or Garboard. Any bending or shifting of the checkerboard during calibration will degrade tracking. The general calibration process is as follows:

- Cover the checkerboard so it cannot be identified by the sensors.

![](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/images/Calibartion_one.jpg?raw=true)

- While as close as possible to the initial sensor that will be calibrated, and with the least amount of skew of the checkerboard in relation to the sensor being calibrated, place the checkerboard on the floor (with the checkers facing the sensors and covered).
     - Standing in front of the checkerboard is a good technique to cover the checkers, while working to place the checkerboard properly.
- Once the checkerboard is in place, uncover the checkerboard and hold it as still as possible. Movement in the checkerboard while the sensor is detecting the checkers will degrade the tracking.

![](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/images/Calibartion_two.jpg?raw=true)

- Once OpenPTrack has verified that it has detected the sensor, and has added it to the “tree”, cover the checkerboard backup and place the checkerboard as close as possible, and with the least amount of skew, show it to the calibrated sensor and the next sensor to be calibrated.

![](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/images/Calibration_Terminal.jpg)

- Uncover the checkerboard and hold still.
- Verify that OpenPTrack has detected the checkerboard, and cover it up.
- Repeat for all sensors.
- Once all the sensors have been calibrated, the ground plane needs to be calibrated as well. Place the checkerboard on the ground, so that at a minimum one sensor can “see” the checkerboard. Then, save the calibration. (We have found that if three sensors can detect the checkerboard, while it is placed on the ground, the better the calibration will be. 

![](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/images/Calibartion_floor.jpg?raw=true)
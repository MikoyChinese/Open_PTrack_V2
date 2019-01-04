This page guides you through the process of creating a set of object images to train your OPT system. We have also included pictures from a session done for one of our OPT installations. 

### Things Needed
* Objects to be tracked
* A camera (such as a smartphone) or a functional OpenPTrack system
* Time 

### Procedure
1. Find all of the objects you want to to train the system to identify.
2. Then, start by placing all of the objects in the center of the space you will be using to photograph the objects.
   * In the example presented here, the photographs were taken in the space OpenPTrack was installed in.
   * Below is an example of how to arrange objects together. They are far enough apart that no object is obscured by another: 
   
  ![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/image1.jpg)

3. Now that you have your objects arranged, either:
   * Use the OPT still image capture script to take the photos; or
   * Use your camera to take about 6 - 8 images from different sides and distances. 
   * Lastly, turn off a few lights to create a different lighting condition, and re-take the photos either with your camera or with the OPT  script

4. Next, you will need to take photos of each object independently from different angles; with different lighting conditions; when partially obscured; carried by people; and with other objects.  It's fine to photograph more than one object in a given image.  You are aiming for ~300 images of each object, with several for each angle and lighting condition it might be seen in. Here are a few sample images:

![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/image4.jpg)   
![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/image12.jpg)
![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/image13.jpg)  
![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/image14.jpg)
![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/image6.jpg)
![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/image8.jpg)    

**Note:** The idea here is to show the computer a variety of different ways each object can be represented in a photo or video. One way to think about this is pretend you had to explain to a friend all the different ways you could see an umbrella without showing them the umbrella in question. How would you photograph that description? 

5. Now, repeat this process for all of the objects. For example, if you have a blue and orange cube, you would need to repeat this process for each of the colors. They system is sensitive to both color and shape. 

6. Remember! As you go through each of the objects you will need to photograph it from as MANY different angles (above, below, from the sides, sideways, etc), distances (close, far away, and between), different lighting conditions (lights on, lights off, some lights on, etc), and with different parts of each object obscured in the photo (only half the object is visible in the photo, a hand over part of the object, another object obscuring some of the object). Here is an example of objects being obscured: 

![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/image9.jpg) 
![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/image3.jpg)  
![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/image2.jpg)  
![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/image1.jpg)   

7. At the end you should have between 200 and 500 images.
8. Store your images in a folder of your choice.
9. Within the folder, create one sub-folder called ORIGINAL where you put the original images and another called RESIZED. 
10. In the RESIZED sub-folder, put copies of all images that are resized to no larger than 1024x1024 resolution and saved in JPEG format (with a .jpg extension).  You can use batch processing in Photoshop or Imagemagick (or any other common tool) to resize.  (For Imagemagick, simply run the command mogrify -resize 1024x1024 *.jpg in the RESIZED folder.) 
11. Shoot a few sample videos with people moving the props all around the space.  
12. That is it!  The next step is [annotation](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Labeling-Objects-Within-Your-Image-Set)! 



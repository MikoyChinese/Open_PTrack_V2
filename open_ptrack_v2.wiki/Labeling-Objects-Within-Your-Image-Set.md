Having followed the step [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Creating-an-Object-Training-Image-Set) to create an image set for object training, the next step is to label objects within the images in the set. This page guides you through the process.

### Things Needed
* Download [**VOTT**](https://github.com/Microsoft/VoTT), a tool for drawing bounding boxes and labeling them.
* RESIZED training photos, as generated in step 10 [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Creating-an-Object-Training-Image-Set#procedure)
* A list of object class names, which must be unique, descriptive, and have no spaces. For example, in the illustrated session on this page, we use names such as: square_orange, rect_blue, um_green. 
* Time 

### Procedure
1. Open VOTT, select the images image (looks like two overlapping photos with a mountain), then the dropbox directory you saved your RESIZED training photos in.
2. Now, in the next screen set the region type to ‘Rectangle’, and in the Labels section input the predetermined label set. This should look similar to this:

![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/image7.png)  

3. Now select Continue. 
4. A new screen should appear, and you should see an image from your training set. 
5. Now, by left clicking and dragging you can create bounding boxes. You will need to create these boxes around ALL of the objects in the photos (all of the objects that are part of our training set of objects), even if it is only a portion of the object. Here is an example:

![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/image10.png)  

**Note:** When creating the bounding boxes you need to have the edges of the box close as possible to the edge of the object. The goal is to have as much of the object in the box as possible, with as little of the surrounding area captured.  

**Note 2:** Any of the bounding boxes can be modified during this process. By left clicking and holding on any of the edges of the bounding box will allow you to manipulate that edge

6. After you have created the bounding boxes around all of the objects in the image, you have to assign the correct label to each of the bounding boxes. For example, in the image above, we have square_orange, um_blue, and um_red. 

7. To assign the correct label to each of the objects is easy. Left click on any of the bounding boxes, which will turn that box red. Once the bounding box is red, at the bottom of the screen will be a list of the labels you input in the first screen. Left click on the label that needs to associated with that object, which will turn that box white. Repeat this process for each of the objects in the image. Whichever bounding box is red is the bounding box you are modifying. Here is an example of what this will look like:

![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/image5.png)   

8. Once you have completed these steps for your first image, this process needs to be repeated for all of the training images!

9. To move to the next image, click the right facing double arrow below the image on the left side which will take you to the next image. Then complete the step above:
* Create bounding boxes around all of the objects in the image; then
* Assign labels to each of the bounding boxes; and
* Click the right facing double arrow to advance to the next image.

**Note:** You can also go back and check your work by clicking the left facing double arrow.

**Note 2:** To the right of the image advance tools is a fraction (1/99 in the example image above). This fraction shows what number image you are annotating out of the total number of images in your set. The numerator is the image you are currently annotating and the denominator is the total number of images.  This will help you keep track of your progress. 

**Note 3:** When you reach the last image in your training set the software will prevent you from advancing any further. 

10. Now that you have taken the time to annotate all of the training images, you need to export them! To do this, go to the toolbar and select Object Detection then Export tags.

11. Then in the popup window the settings should be:
* Export Format: YOLO
* Export Until: Last Tagged Region
* Output Path: _This is unique to your computer!_

12. Click export and wait for the confirmation that it has finished.  

13. Once the software is done exporting, which should not take very long, navigate to where you output the training data to. Generally, the name of the output folder is the folder is the same as the one that your initial training files are in with a suffix of _output. The file structure will look like:
_output_folder_name ->data->obj. The obj folder will have all of your training images, plus corresponding *.txt files. The entire output folder is needed. 




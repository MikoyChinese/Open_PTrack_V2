In order to carry out [calibration](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Calibration), you need to have a checkerboard. The checkerboard has to be made of squares with known dimensions. Furthermore, we recommend having an even number of squares in one direction and an odd number of squares in the other direction. The more numerous and bigger the squares, the better. 

You will need the following parameters from your checkerboard: rows, columns, width of individual squares (cell_width), height of individual cells (cell_height). The width and height are measured in meters. 

The rows and cols parameters are defined by the number of chess intersections(i.e. the number of interior vertex points) in rows and columns (cols), not the number of squares along the edge of the checkerboard. This is also the naming convention for checkerboards. So a 8X7 checkerboard has the parameters: rows = 8, cols = 7 but will actually have 9 squares along one edge of the checkerboard and 8 squares along the other. 

For example: 

![](https://github.com/OpenPTrack/open_ptrack/raw/master/docs/images/CheckerBoard_Origion.JPG?raw=true)

In the image above, the rows count is 6, and the cols count is 5 (Note that the checkerboard is held horizontally such that there are more checkers horizontally than vertically!). This is due to the intersections of columns and rows on the checkerboard. An easy way to think about this is to count the columns and rows and subtract 1 from each of the counts. In the checkerboard above, there are 7 rows and 6 cols; subtracting 1 from each gives us the value required for calibration configuration, for 6 rows and 5 cols. 

Possible materials for your checkerboard include foam core (half-inch or thicker), Garboard or Aluminium Dibond. 

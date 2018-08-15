# SoundBox Project

The goal of this project is to capture the movements of the sand (made by an audience) in a sandbox with a Kinect. The Kinect is connected to Processing that then analyses the image and emits some sound according to the movement. 

## Technical background

This project uses processing 3, a Xbox one Kinect (or Kinect 2.0) connected to a windows machine (windows 10, ). Follow the instructions to install your Kinect: https://www.microsoft.com/en-us/download/details.aspx?id=44561
If you wish to use MacOS or Linux, a library exists https://github.com/OpenKinect/libfreenect2/blob/master/README.md which works for kinect 2. Another one exists for the version 1. 

## Process

The first part of the project was to be able to generate random shapes that were movable with a mouse, and generate sound according to the change of the shape. To do so, pixels of the random shape were colored, and the frequency of the sound was change according to the number of pixels of one certain color. See Experiment to move a curve. 

The Kinect allows to get the raw data of the depth of its environment. The second part of the project was to grab the depth, make an image out of it and color only the pixels representings objects that would be closer. This allows to connect the first project to the second, emitting sound in accordance with the surface of the objects (or stack of sand). 

By getting the difference between a threshold (where the sand should be flat) and the highest points of the sand dunes, another characteristic of the sound is modify. 

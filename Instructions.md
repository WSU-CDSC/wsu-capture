# Welcome to WSU-Capture!

## Overview
This is designed to simplify our workflow for video transfers while also creating files that are both high quality and archivally sound. The tool is hard coded to control our Osprey video capture device, and will create two files for each capture: an [MKV/FFV1](https://www.loc.gov/preservation/digital/formats/fdd/fdd000343.shtml) archival quality file and an MP4 access file.

## Usage
<img src="/main-gui.png" alt="Main screen for WSU-Capture" width="350">

* Choose Save Location: This is where WSU-Capture will save the video files you are capturing. This must be selected at the start of every new session.
* Capture Card Settings: This will open the settings for the capture card. This should not usually need to be adjusted.
* Preview video: Use this to check if the video is playing correctly as well as to calibrate the Elmo telecine if you are digitizing a film.
* Record video: This will start to record the video to the save location. [A box will appear](/enter-name.png) for you to enter the output file name. Input a name, and press `Enter` to start video capture. If you have not yet chosen a save location, you will be prompted. A low quality preview window is available for monitoring the capture. Once you are done recording the video, just close the preview screen and the video capture will end.
* Film Source: Check this box if you are capturing a film. This will not affect the actual capture or archival file, but will optimize the derivative for the best presentation of film sources.

__After Capture__: After you end the video capture by closing the preview screen, WSU-Capture will start to create the access MP4 file. It will alert you both when it starts to do this, as well as when the file creation is finished. Do not start any new captures/previews until the access file creation is done. 



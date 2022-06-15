# <div align="center"> Segmentation Tool (SegTool)</div>
#### <div align="center"> The *Segmentation Tool* was designed to create unbiased ground truth data for multiplexIF imagery. </div>
#### <div align="center">Correspondence to: bgreen42@jhu.edu</div>

## 1. Description
This tool was designed to compare two segmentation maps in the efforts to design an unbaised ground truth segmentation. The app comparison starts by using the argmax(Intersection \ Union) for each object in the two segementations. Each object is then displayed to the user on at a time so that they can compare the two segmentation approaches. The user can select one of the two algorithm results or draw their own annotation for each cell. The user can also add cells as they see fit. 

## 2. Getting Started
There are two ways to launch the tool.

1. Through MATLAB: 
   1. check out the repository
   1. navigate to the repo. Open the `SegTool.mlapp`. The app designer will open. 
   1. In the task bar click the green run arrow. 
      1. *NOTE:* This is also the window to edit the app. There are two views the `Desgn View` and the `Code View`. You can toggle the views in the top right of the app designer window. 
1. Install the tool and open from the icon. 
   1. download the installer.exe located [here](SegmentationTool/for_redistribution)
   1. double click on the installer.exe to launch it
   1. *NOTE:* If the installer fails this is typically b/c of a failed MATLAB runtime install. Download and install MATALB Runtime_R2020a_win64 separately, then retry the `SegTool` installer.

## 3. Contents
- [1. Description](#1-description "Title")
- [2. Getting Started](#2-getting-started "Title")
- [3. Contents](#3-contents "Title")


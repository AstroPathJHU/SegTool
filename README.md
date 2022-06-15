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
- [4. Background](#4-background "Title")
- [5. Workflow](#5-workflow "Title")
- [6. File Structure](#6-file-structure "Title")
- [7. Usage](#7-usage "Title")
- [8. Saving Output](#8-saving-output "Title")
- [9. Combing Ground Truth Results](#9-combing-ground-truth-results "Title")
- [10. Potential Edits](#10-potential-edits "Title")

## 9. Combining Ground Truth Results
The segmentation status for annotators is kept in the Segmentation_eval.xlsx document in the notes folder of the repo. Numeric ids can be found in the NumericIDs.csv file. To combine results run `gather_simil()` from the *QC* repo directory on the image directory. 

`gather_simil(wd, P, imname, N)` 

Input:
- `wd`: the directory to the trainingimages where each annotator has a subfoler: 'SegmentationImages_PP' (where PP is the person's intials).
- `P`: cell array containing the extensions after the '\_' on annotators annotation folder for each annotator that has completed the image of interest
  - ex. for SegmentationImages_SS it would be {'SS'}
- `imname`: the image name up to the image coordinates
  - ex.  'Liver_TMA_145_23_01.30.2020_\[6435,55763]'
- `N`: cell array containing the numeric ID from the NumericIDs.csv file which will be added as an extension to the final image
 
Output:
a combined image in a *wd\..\upkeep\Results* folder with the segmentation label images named by the image names and appended with *_comparison_seg_data_final_01*. Also includes a .csv file with the MultiNuc flag status indicating if the user flagged the cell as being multi-nucleated. 

Examples for running this code are found in the t1.m, t2.m, and t3.m files where each of the previous results were run and generated. 

To cut the large images into smaller images using the `cut_big_image` function in the QC folder. Which takes in a directory with the superpixel and component_tiff subfolders as described in section 6 and an image name as desribed for `gather_simil`. 

## 10. Potential Edits
### edits for membrane segmentation
The code should be edited to add a dialog box to use membrane or nuclear segmentation. This dialog box should change the headers *current nuclear object* and extract the information from different layers in the superpixel and inform data. We should also append '\_mem' to the output image files from the tool (both when reading and writing). 


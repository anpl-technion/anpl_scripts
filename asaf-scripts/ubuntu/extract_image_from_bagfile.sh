#!/bin/bash

echo "Extract image from ros bagfile."
echo "Enter path to the bag file: "
read bagfile_dir

echo "Enter the name of the bag file: "
read bagfile_name

roslaunch anpl_inf image_from_bag.launch bagfile_dir:=$bagfile_dir bagfile_name:=$bagfile_name

cd $bagfile_dir
mkdir -p $bagfile_name
mv ~/.ros/frame*.jpg $bagfile_dir/$bagfile_name

echo "Images stored in the bagfile dir ..."

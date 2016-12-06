FILE_VERSION=/media/matlab/version.txt

sudo mount 132.68.1.41:/ccnfs/cccd/matlab /media/matlab
VERSION=$(head -n 1 /media/matlab/version.txt)
genisoimage -o ~/$VERSION.iso -V BACKUP -r -J /media/matlab
sleep 2
sudo umount /media/matlab

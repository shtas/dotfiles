#!/bin/sh

echo "Killing iPhoto and Aperture..."
killall iPhoto
killall Aperture
ssh Stian@thaulow.ddns.net killall iPhoto && killall Aperture
echo "Syncing..."
rsync -az --info=progress2 --delete /Volumes/Rikiki/Pictures/Clean.aplibrary/ Stian@thaulow.ddns.net:~/Pictures/Clean.aplibrary
echo "Done."
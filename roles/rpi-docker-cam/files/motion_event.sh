#!/bin/sh
sleep 10
pathtoimage=/var/www/media/
cd $pathtoimage
latestimage=$(ls -Art *jpg | tail -n 1)

curl -s -X POST "https://api.telegram.org/bot502631193:AAHP3_6etbVCV40gMGuKk1MojYJef6FFV0I/sendPhoto" -F chat_id=-1001093830425 -F photo=@$pathtoimage$latestimage -F caption=http://kloos.myqnapcloud.com

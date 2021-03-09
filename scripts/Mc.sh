backdir=/files/backups

echo "1 hour until MC server maintenance"
screen -S MC -p 0 -X stuff "`printf "say Server maintenance will start in 1 hour. Please prepare.\r"`"; 
sleep 50m
echo "10 min until MC server maintenance"
screen -S MC -p 0 -X stuff "`printf "say Server maintenance will start in 10 minutes. Please prepare.\r"`"; 
sleep 5m
screen -S MC -p 0 -X stuff "`printf "say Server maintenance will start in 5 minutes. Please prepare.\r"`"; 
sleep 4m
echo "1 min until MC server maintenance"
screen -S MC -p 0 -X stuff "`printf "say Server maintenance will start in 1 minute. Please leave the server. This will take 1-10 minutes.\r"`"; 
screen -S MC -p 0 -X stuff "`printf "say An announcement will be made when complete.\r"`"; 
sleep 50
screen -S MC -p 0 -X stuff "`printf "say Server maintenance will start in 10 seconds.\r"`"; 
sleep 10
screen -S MC -p 0 -X stuff "`printf "say SERVER SHUTDOWN NOW\r"`"; 
screen -S MC -p 0 -X stuff "`printf "stop\r"`"; 
echo "Stopping server."
sleep 1m
echo "Starting backup"

file_name=minecraft
current_time=$(date "+%d.%m.%Y")
echo "Current date : $current_time"
 
new_fileName=$file_name.$current_time
echo "New FileName: " "$new_fileName"
cd /files/

echo "Moving dynmap to tmp"

mv $file_name/plugins/dynmap tmp

cp -r $file_name $backdir/$new_fileName

echo "Finished copying, moving dynmap back"

mv tmp/dynmap $file_name/plugins/dynmap
echo "Starting zip backup"

cd $backdir

zip -r $backdir/$new_fileName.zip $new_fileName

rm -rvf $new_fileName
echo "Finished backup"

echo "Starting copy to webserver"
cp $backdir/$new_fileName.zip /var/www/html/download/map.zip

echo "Starting copy to webdav"
cp $backdir/$new_fileName.zip /files/webdav/Backups

echo "Completed copy, starting server."

screen -S MC -p 0 -X stuff "`printf "java -Xmx8192M -Xms8192M -jar server.jar nogui\r"`"; 
echo "Complete"

echo "starting VNC Thunbnail Viewer"
echo $ports

host=localhost
portRangeStart=5900
portRangeEnd=5909
password=secret

if [ ! -z $1 ]
then
    host=$1
fi

if [ ! -z $2 ]
then
    portRangeStart=$2
fi

if [ ! -z $3 ]
then
    portRangeEnd=$3
fi

if [ ! -z $4 ]
then
    password=$4
fi

for i in $(seq $portRangeStart $portRangeEnd); 
do 
    params="$params HOST $host PORT $i PASSWORD $password"
done

java -jar bin/VncThumbnailViewer.jar $params
#common functions
launch () {
	luna-send -n 1 -f luna://com.webos.applicationManager/launch '{"id":"com.webos.app.dsmp","params":{"src":"/tmp/usb/sda/sda2/LG Smart TV/'$1'","type":"video"}}'
}
close () {
	luna-send -n 1 -f luna://com.webos.applicationManager/closeByAppId '{ "id": "com.webos.app.dsmp" }'
}
delay () {
	s=$1
	ms=1000
	sleep $((s / ms))
}
irsend () {
	luna-send -f -n 1 luna://com.lge.inputgenerator/pushKeyEvent '{"keycodenum":'$1'}'
}
n=1000
l=0
#filesize=`stat -c%s $file`
cycle () {
	echo ""$1" play"
	launch $1
	# wait 20000
	delay 20000
	close
	echo "'$1' stop"
	# wail 10000
	delay 10000
}
# run cycle
while [ $(( l+=1 )) -le $n ]
do
# launch & close media application
echo ""
t=$(( t=(l%4)+1 ))
echo ""$t" check"

echo "'$l'th loop"
file=""$t".mp4"
cycle $file
done

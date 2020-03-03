#!/bin/bash
#
# author: Leo Chan
# Blog: https://leochan.me
#

backPath="/data/leds/backup/"
ledsPath="/sys/class/leds/"

backupConfig(){
	if [ ! -d $backPath ]; then
		mkdir -p $backPath
		for i in `find / -name brightness`; do
			name=`dirname $i | grep -o '[^/]*$'`
			cat $i > $backPath$name
		done
	fi
}

turnOff(){
	for i in `ls "$backPath"`
	do
	  	echo 0 > "$ledsPath$i/brightness"
	done
}

turnOn(){
	for i in `ls "$backPath"`
	do
	  	cat $backPath$i > "$ledsPath$i/brightness"
	done
}

switchLed(){
	if [ `date +%H` -gt 19 ]; then
		turnOff
	else
		turnOn
	fi
}

backupConfig
switchLed

#!/bin/bash -l

while getopts u:p:a:P:s:t: flag
do
    case "${flag}" in
        u) username=${OPTARG};;
	p) password=${OPTARG};;
	a) address=${OPTARG};;
	P) port=${OPTARG};;
	s) stream=${OPTARG};;
	t) targetPort=${OPTARG};;
    esac
done

url="rtsp://"
if [ "$username" != "" ]
then
	url="${url}${username}"
fi

if [ "$password" != "" ]
then
        url="${url}:${password}@"
else
	if [ "$username" != "" ]
	then
		url="${url}@"
	fi
fi

url="${url}${address}"
url="${url}:${port}"

if [ "${stream}" != "" ]
then
	url="${url}/${stream}"
fi

soutOptions="#transcode{vcodec=mjpg,scale=1.0,acodec=none}:standard{access=http{mime=multipart/x-mixed-replace;boundary=--7b3cc56e5f51db803f790dad720ed50a},mux=mpjpeg,dst=:${targetPort}\}"

echo "Calling: /usr/bin/vlc --intf dummy ${url} --sout ${soutOptions}"

/usr/bin/vlc --intf dummy ${url} --sout "${soutOptions}" 

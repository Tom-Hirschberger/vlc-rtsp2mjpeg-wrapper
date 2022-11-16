# vlc-rtsp2mjpeg-wrapper

A simple script that calls vlc to convert a rtsp stream to mjpeg stream.
The script can be registered as system service to be started automatically.

The script has been tested on Raspberry OS Bullseye 32bit with state 2022-11-16.

## rtsp2mjpeg.bash

The script needs the vlc media player be installed on your system.
On Raspberry OS or any other Debian based system you can install it with:

```bash
sudo apt -y update && sudo apt -y install vlc
```

You can call the script with the following options:
| OPTION | DESCRIPTION |
| ------ | ----------- |
| -u USERNAME | If the source stream is protected you can provide the username with this option |
| -p PASSWORD | If the source stream is protected you can provide the password with this option |
| -a ADDRESS  | The ip address or hostname of the source stream |
| -P PORT     | The port the source stream is provided at |
| -s STREAM   | The stream part of the source stream. If i.e. your stream url is "rtsp://localhost:3000/unicast" the stream part is "unicast" |
| -t TARGET_PORT | The port the mjpeg stream should be provided at. Best is to choose a port higher than 1024 as you need root privileges otherwhise |

## System service

You can use the provided rtsp2mjpeg.service file to register a system service that will be started during boot.

This instructions assume that you cloned the repository to the home directory of the "pi" user.
So the source path is "/home/pi/vlc-rtsp2mjpeg-wrapper". If you saved the repository to a different location you need to change the paths to your needs.

Copy the service file to the system location:

```bash
sudo cp /home/pi/vlc-rtsp2mjpeg-wrapper/rtsp2mjpeg.service /etc/systemd/system/rtsp2mjpeg.service
```

You then need to configure the options in "rtsp2mjpeg.service" at the new location to your needs:

```bash
sudo nano /etc/systemd/system/rtsp2mjpeg.service
```

If you want to convert more than one stream you need to copy the service file again with a different name:

```bash
sudo cp /home/pi/vlc-rtsp2mjpeg-wrapper/rtsp2mjpeg.service /etc/systemd/system/rtsp2mjpeg2.service
````

In the next step the script will be enabled and started:

```bash
sudo systemctl enable rtsp2mjpeg.service
sudo systemctl start rtsp2mjpeg.service
```

If you configured a second one repeat this step with the second name!

You then can access the new stream with the browser of your choice under:

```text
http://<IP OR NAME OF THE CONVERTER HOST>:<CONFIGURED PORT>
```

#!/system/bin/sh
snd() {
snd=$(find /sys/m* -name $1)
if [ $snd ]; then
	chmod 777 $snd
	echo $2 > $snd
	chmod 444 $snd
fi }
# Laster K's tasha codec driver
# HPH Amplifier Class: 1 - Class AB. 0 - Class H-Hifi.
snd "low_distort_amp" "1"
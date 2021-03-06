mixer=$device_folder/mixer_paths.xml

mv $MODPATH/files/msm8996/* $device_folder/

if [ -f /system/vendor/etc/fstab.qcom ]; then
	fstab=/system/vendor/etc/fstab.qcom
else
	fstab=/system/etc/fstab.qcom
fi

vendor=/dev/block/bootdevice/by-name/factory

if grep -q "$vendor" $fstab; then
	ui_print "- Treble partition"
	mv $device_folder/treble/* $device_folder/
else
	ui_print "- Non-Treble partition"
	mv $device_folder/non-treble/* $device_folder/
fi

if [ -f /system/etc/mixer_paths_tasha.xml ]; then
	mixer=$device_folder/mixer_paths_tasha.xml
	mv $device_folder/mixer_paths.xml $device_folder/mixer_paths_tasha.xml
fi

if [ -f /system/vendor/etc/mixer_paths_tasha.xml ]; then
	mixer=$device_folder/mixer_paths_tasha.xml
	mv $device_folder/mixer_paths.xml $device_folder/mixer_paths_tasha.xml
fi

rm -rf $device_folder/treble
rm -rf $device_folder/non-treble
rm -rf $device_folder/install.sh
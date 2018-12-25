# Check supported device
device_check=1
device1=z2_plus
device2=z2_row
device3=

custom_module() {
# Zero Audio Patch
	ui_print "- Check audio directory"
	if [ -f /system/etc/audio_policy_configuration.xml ]; then
		mv $MODPATH/system/vendor/etc/audio_policy_configuration.xml $MODPATH/system/etc/
	fi
	if [ -f /system/etc/mixer_paths.xml ]; then
		mv $MODPATH/system/vendor/etc/mixer_paths.xml $MODPATH/system/etc/
	fi
	if [ -f /system/etc/mixer_paths_tasha.xml ]; then
		mv $MODPATH/system/vendor/etc/mixer_paths.xml $MODPATH/system/etc/mixer_paths_tasha.xml
	fi
	if [ -f /system/vendor/etc/mixer_paths_tasha.xml ]; then
		mv $MODPATH/system/vendor/etc/mixer_paths.xml $MODPATH/system/vendor/etc/mixer_paths_tasha.xml
	fi
}
# Check supported device
device_check=1
device1=z2_plus
device2=z2_row
device3=

custom_module() {
# Zero Audio Patch
	policy=$MODPATH/files/audio_policy_configuration.xml
	mixer=$MODPATH/files/mixer_paths.xml
	ui_print "- Check audio directory"
	if [ -f /system/etc/audio_policy_configuration.xml ]; then
		cp $policy $MODPATH/system/etc/
	else
		cp $policy $MODPATH/system/vendor/etc/
	fi
	if [ -f /system/etc/mixer_paths.xml ]; then
		cp $mixer $MODPATH/system/etc/
	fi
	if [ -f /system/etc/mixer_paths_tasha.xml ]; then
		cp $mixer $MODPATH/system/etc/mixer_paths_tasha.xml
	fi
	if [ -f /system/vendor/etc/mixer_paths.xml ]; then
		cp $mixer $MODPATH/system/vendor/etc/
	fi
	if [ -f /system/vendor/etc/mixer_paths_tasha.xml ]; then
		cp $mixer $MODPATH/system/vendor/etc/mixer_paths_tasha.xml
	fi
	rm -rf $MODPATH/files
}
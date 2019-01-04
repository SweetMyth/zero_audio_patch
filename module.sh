# Check supported device
device_check=1
device1=z2_plus
device2=z2_row
device3=

# Disable audio effects in audio flinger
disable_effects=0

# Amp class for headphones: "H_HIFI", "AB".
hph_amp_class=H_HIFI

custom_module() {
# Zero Audio Patch
	policy=$MODPATH/files/audio_policy_configuration.xml
	mixer=$MODPATH/files/mixer_paths.xml
	ui_print "- Check audio directory"
	if [ "$hph_amp_class" == "AB" ]; then
		ui_print "- Changing Amp Class to AB"
		sed -i 's/CLS_H_HIFI/CLS_AB/' $mixer
		sed -i 's/"low_distort_amp" "0"/"low_distort_amp" "1"/' $MODPATH/post-fs-data.sh
	fi
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
	if [ "$disable_effects" == "1" ]; then
		ui_print "- Disabling audio effects"
		cp $MODPATH/files/audio_effects.conf $MODPATH/system/etc/
		cp $MODPATH/files/audio_effects.xml $MODPATH/system/vendor/etc/
	fi
	rm -rf $MODPATH/files
}
# Check supported device
device_check=1
device1=z2_plus
device2=z2_row
device3=

# Disable audio effects in audio flinger
disable_effects=1

# Amp class for headphones: H_HIFI, AB, AB_HIFI
hph_amp_class=AB

# Speaker dual enable
# Have delay between main speaker and earpiece on Pro
speaker_dual=0

custom_module() {
# Zero Audio Patch
	policy=$MODPATH/files/audio_policy_configuration.xml
	if [ "$speaker_dual" == "1" ]; then
		mixer=$MODPATH/files/mixer_paths_dual.xml
	else
		mixer=$MODPATH/files/mixer_paths.xml
	fi
	ui_print "- Check audio directory"
	if [ "$hph_amp_class" == "AB_HIFI" ]; then
		ui_print "- Changing Amp Class to AB HIFI"
		sed -i 's/CLS_AB/CLS_AB_HIFI/' $mixer
	fi
	if [ "$hph_amp_class" == "H_HIFI" ]; then
		ui_print "- Changing Amp Class to H HIFI"
		sed -i 's/CLS_AB/CLS_H_HIFI/' $mixer
	fi
	if [ -f /system/etc/audio_policy_configuration.xml ]; then
		cp $policy $MODPATH/system/etc/
	else
		cp $policy $MODPATH/system/vendor/etc/
	fi
	if [ -f /system/etc/mixer_paths.xml ]; then
		cp $mixer $MODPATH/system/etc/mixer_paths.xml
	fi
	if [ -f /system/etc/mixer_paths_tasha.xml ]; then
		cp $mixer $MODPATH/system/etc/mixer_paths_tasha.xml
	fi
	if [ -f /system/vendor/etc/mixer_paths.xml ]; then
		cp $mixer $MODPATH/system/vendor/etc/mixer_paths.xml
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
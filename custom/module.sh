# Device support
device_check=1
device_list="z2_plus z2_row"
# Board support
board_check=1
board_list="msm8996"
# Custom installer
custom_installer() {
# Zero Audio Patch
	# Declare about start installing common files
	ui_print "- Installing common configs"

	# Define shortcuts
	common=$MODPATH/files/common
	device_folder=$MODPATH/files/$device
	# Experimental! Use board folder if device not supported
	[ ! -f "$device_folder" ] && ( device_folder=$MODPATH/files/$board )

	# Audio effects
	case "$disable_effects" in
	"0" )
		ui_print "- Disabling audio effects"
		rm -f $common/system/etc/audio_effects_eq.conf
		rm -f $common/system/vendor/etc/audio_effects_eq.xml
	;;
	"1" )
		ui_print "- Keep audio effects enabled"
		rm -f $common/system/etc/audio_effects.conf
		rm -f $common/system/vendor/etc/audio_effects.xml
		rm -f $common/system/etc/audio_effects_eq.conf
		rm -f $common/system/vendor/etc/audio_effects_eq.xml
	;;
	"2" )
		ui_print "- Tweaking audio effects"
		mv $common/system/etc/audio_effects_eq.conf $common/system/etc/audio_effects.conf
		mv $common/system/vendor/etc/audio_effects_eq.xml $common/system/vendor/etc/audio_effects.xml
	;;
	esac

	# Check adsp policy dir
	[ -f /system/vendor/etc/audio_io_policy.conf ] && ( mv $common/system/vendor/etc/audio_output_policy.conf $common/system/vendor/etc/audio_io_policy.conf )

	# Move common files to module folder
	mv $common/* $MODPATH/

	# Declare about start installing device files
	ui_print "- Installing device configs"

	# Additional scripts for device
	if [ -f $device_folder/install.sh ]; then
		. $device_folder/install.sh
	fi

	# Dual speaker
	if [ "$dual_speaker" -gt "0" ]; then
		ui_print "- Dual speaker option"
		sed -i 's/IS_DUAL_SPEAKER/speaker-dual/' $mixer
	else
		sed -i 's/IS_DUAL_SPEAKER/speaker-mono/' $mixer
	fi

	# Phone's mic instead of Headset mic
	if [ "$phone_mic" -gt "0" ]; then
		ui_print "- Using phone's mic instead of headset mic"
		sed -i 's/IS_PHONE_MIC/bottom-mic/' $mixer
	else
		sed -i 's/IS_PHONE_MIC/external-mic/' $mixer
	fi

	# Copy files to right dir
	[ -f /system/etc/audio_policy_configuration.xml ] && ( cp $device_folder/* $MODPATH/system/etc/ )
	[ -f /system/vendor/etc/audio_policy_configuration.xml ] && ( cp $device_folder/* $MODPATH/system/vendor/etc/ )

	# Cleanup
	rm -rf $MODPATH/files
}
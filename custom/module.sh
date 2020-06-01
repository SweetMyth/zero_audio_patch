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

	# Enabling effects
	if [ -z "$disable_effects" ]; then
		ui_print "- Keep audio effects enabled"
		rm -f $common/system/etc/audio_effects.conf
		rm -f $common/system/vendor/etc/audio_effects.xml
	else
		ui_print "- Disabling audio effects"
	fi

	# Check adsp policy dir
	if [ -f /system/vendor/etc/audio_io_policy.conf ]; then
		mv $common/system/vendor/etc/audio_output_policy.conf $common/system/vendor/etc/audio_io_policy.conf
	fi

	# Move common files to module folder
	mv $common/* $MODPATH/

	# Declare about start installing device files
	ui_print "- Installing device configs"

	# Additional scripts for device
	[ -f $device_folder/install.sh ] && ( . $device_folder/install.sh )

	# Copy files to right dir
	[ -f /system/etc/audio_policy_configuration.xml ] && ( cp $device_folder/* $MODPATH/system/etc/ )
	[ -f /system/vendor/etc/audio_policy_configuration.xml ] && ( cp $device_folder/* $MODPATH/system/vendor/etc/ )

	# Cleanup
	rm -rf $MODPATH/files
}
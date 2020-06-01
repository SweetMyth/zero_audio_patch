#!/system/bin/sh
imgless=/data/adb/modules/zap
img=/sbin/.magisk/img/zap
audio_log(){
echo "Audio Log"
DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo "- Preparing directory"
folder="sdcard/Log/Audio/$DATE"
mkdir -p "$folder"
echo "- Preparing tinymix dump"
tinymix > $folder/tinymix.txt 2>/dev/null
echo "- Preparing audio flinger dump"
dumpsys media.audio_flinger > $folder/audio_flinger.txt 2>/dev/null
echo "- Preparing audio policy dump"
dumpsys media.audio_policy > $folder/audio_policy.txt 2>/dev/null
echo "- Preparing dump files"
if [ -f $imgless ]; then
	cp -r $imgless "$folder/Files" 2>/dev/null
else
	cp -r $img "$folder/Files" 2>/dev/null
fi
tar -cvf "$folder/Data.tar" "$folder" 2>/dev/null
echo "- Done"
echo "- Files placed in Log/Audio/$DATE"
echo "- If you have any issues please report and send Data.tar archive to me:"
echo "- XDA: @SweetMyth"
echo "- TG: @SweetMyth"
}
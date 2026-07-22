#!/run/current-system/sw/bin/bash

current=$(kreadconfig6 --file kwinrc --group Plugins --key poloniumEnabled)

if [[ $current == "true" ]]; then
	kwriteconfig6 --file kwinrc --group Plugins --key poloniumEnabled false
elif [[ $current == "false" ]]; then
	kwriteconfig6 --file kwinrc --group Plugins --key poloniumEnabled true
fi

echo "poloniumEnabled=$(kreadconfig6 --file kwinrc --group Plugins --key poloniumEnabled)"

# Actually updates the configuration
qdbus org.kde.KWin /KWin reconfigure

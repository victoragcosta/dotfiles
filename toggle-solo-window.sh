#!/run/current-system/sw/bin/bash

current=$(kreadconfig6 --file kwinrc --group Plugins --key kwin-solo-windowEnabled)

if [[ $current == "true" ]]; then
	kwriteconfig6 --file kwinrc --group Plugins --key kwin-solo-windowEnabled false
elif [[ $current == "false" ]]; then
	kwriteconfig6 --file kwinrc --group Plugins --key kwin-solo-windowEnabled true
fi

echo "kwin-solo-windowEnabled=$(kreadconfig6 --file kwinrc --group Plugins --key kwin-solo-windowEnabled)"

# Actually updates the configuration
qdbus org.kde.KWin /KWin reconfigure

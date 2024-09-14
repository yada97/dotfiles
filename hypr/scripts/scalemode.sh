#! /bin/bash
#
status=$(hyprctl getoption dwindle:special_scale_factor | grep -i float | awk '{print $2}')
echo $status

if [ $status = 1.000000 ];
then
    $(hyprctl keyword dwindle:special_scale_factor 0.87)
elif [ $status = 0.870000 ];
then
    $(hyprctl keyword dwindle:special_scale_factor 1)
else
    echo "done"
fi

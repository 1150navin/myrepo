#!/bin/bash
echo "4" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio4/direction
for i in `seq 1 10`;
do
cat /sys/class/thermal/thermal_zone0/temp | while read output;
do
  
  usep=$(echo $output )
  if [ $usep -ge 41160 ]; then
    echo $output "Running hot" on $(hostname) as on $(date)
    echo "1" > /sys/class/gpio/gpio4/value
    else
    echo "0" > /sys/class/gpio/gpio4/value
    echo $output "Running cool" on $(hostname) as on $(date)
  fi
done
sleep 3
done


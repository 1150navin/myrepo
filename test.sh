#!/bin/bash
echo "4" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio4/direction
for i in `seq 1 10`;
do
        echo "1" > /sys/class/gpio/gpio4/value
        sleep 3
        echo "0" > /sys/class/gpio/gpio4/value
        sleep 3
done
echo "4" > /sys/class/gpio/unexport
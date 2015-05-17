import sys
import time
import RPi.GPIO as GPIO
GPIO.setmode(GPIO.BOARD)
try:
	ping_count = input("Enter the number of times to collect sonar evidence before calculating the distance: ") or 5
	while True:
		distance=[]
		avg_dist = 0.0
		GPIO.setup(11, GPIO.OUT)
		GPIO.output(11,0)
		for i in range(int(ping_count)):
			GPIO.setup(7, GPIO.OUT)
			GPIO.output(7, 0)
			time.sleep(0.000002)
			GPIO.output(7, 1)
			time.sleep(0.000005)
			GPIO.output(7, 0)
			GPIO.setup(7, GPIO.IN)
			while GPIO.input(7)==0:
				starttime=time.time()
			while GPIO.input(7)==1:
				endtime=time.time()
			duration=endtime-starttime
			distance.append(float(duration*34000/2))
			time.sleep(.025)
			avg_dist = avg_dist + distance[i]
		avg_dist=avg_dist/ping_count
		print ('Distance from obstacle = ',avg_dist)
#        if (avg_dist >= (prev_dist-.01*prev_dist) and avg_dist<=(prev_dist+.01*prev_dist)) :
		if (avg_dist <= 10) :
			GPIO.output(11, 1)
		else :
			GPIO.output(11,0)
	
except KeyboardInterrupt:
        GPIO.cleanup()
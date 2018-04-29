# -*- coding: utf-8 -*-
import RPi.GPIO as GPIO
import time
from picamera import PiCamera
GPIO.cleanup()
#set GPIO pin numbering system
GPIO.setmode(GPIO.BCM)

#set which pins are connected to what
TRIG = 23
ECHO = 24

print ('Distance Measurement in Progress')

#set the two GPIO ports to output,
#using the pin numbers set during declaration above
GPIO.setup(TRIG, GPIO.OUT)
GPIO.setup(ECHO, GPIO.IN)

camera = PiCamera()
camera.rotation = 180
camera.start_preview()

pics_taken = 0

def settle_sensor():
	""""
	set trigger pin to low
	and let the sensor settle before use
	"""
	GPIO.output(TRIG, False)
	print('waiting for sensor to settle')
	time.sleep(0.1)

	#short pulse to trigger the module, to obtain an echo response
	GPIO.output(TRIG, True)
	time.sleep(0.00001)
	GPIO.output(TRIG, False)
	
settle_sensor()

while True:

	while GPIO.input(ECHO) == 0:
		pulse_start = time.time()

	while GPIO.input(ECHO) == 1:
		pulse_end = time.time()

	pulse_duration = pulse_end - pulse_start

	distance = pulse_duration * 17150
	distance = round(distance, 2)
	if distance < 40:
		camera.capture('images/image'+str(time.time())+'.jpg')
		pics_taken+=1
		print('capture ' + str(pics_taken) + ' made')
		time.sleep(0.3)
	print('Distance: ' + str(distance) + 'cm')
	settle_sensor()
	
camera.stop_preview()
GPIO.cleanup()
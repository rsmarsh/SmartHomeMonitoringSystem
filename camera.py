from picamera import PiCamera
import time

camera = PiCamera()

print('camera imported')
number_of_pics = int(input('how many pictures would you like to take?'))
time_between_pics = int(input('how long between each photo?'))
camera.rotation = 180
camera.start_preview()
print('preview started')
time.sleep(3)
for x in range(0, number_of_pics):
	camera.capture('image'+str(time.time())+'.jpg')
	print('capture ' + str(x) + ' made')
	time.sleep(time_between_pics)
camera.stop_preview()
print('preview stopped')
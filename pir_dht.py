import time
import datetime
import RPi.GPIO as GPIO
import pymysql
import Adafruit_DHT

GPIO.setmode(GPIO.BCM)

#PIR sensor declaration
PIR_1_PIN = 26
#PIR_2_PIN = GPIO NUM HERE

#DHT11 Temperature sensor declaration
DHT_SENSOR_TYPE = Adafruit_DHT.DHT11
#DHT pin declaration, edit this depending on which GPIO pin you have used for the data pin.
DHT_PIN = 5

#LED PIN declaration
RED_LED = 21
GREEN_LED = 25

#20 minutes is 1200 seconds
temp_countdown =  20

GPIO.setup(PIR_1_PIN, GPIO.IN)
GPIO.setup(RED_LED, GPIO.OUT)
GPIO.setup(GREEN_LED, GPIO.OUT)

def current_date():
	date_today = str(datetime.date.today())
	return date_today
	
def current_time():
	time_today = str(datetime.datetime.now().time())[:8]
	return time_today
	
def db_interaction(sql_to_run):
	GPIO.output(GREEN_LED,GPIO.HIGH)
	GPIO.output(RED_LED,GPIO.LOW)
	try:
		db_connection = pymysql.connect(host='localhost', port=3306, user='root', passwd='root', db='PiSmartHome', autocommit=True)
		db_cursor = db_connection.cursor()
		print('database connection opened')
		sql_statement = str(sql_to_run)
		db_cursor.execute(str(sql_statement))
	finally:
		db_connection.close()
		print('db connection closed')
		GPIO.output(GREEN_LED,GPIO.LOW)
		GPIO.output(RED_LED,GPIO.HIGH)

def temp_reading():
	reading_date = current_date()
	reading_time = current_time()
	print('taking temperature reading')
	humidity, temp_c = Adafruit_DHT.read_retry(DHT_SENSOR_TYPE, DHT_PIN)
	temp_f = temp_c * 9/5.0 + 32
	print('temperature: C: '+str(temp_c)+'  F: '+str(temp_f)+'  Humidity %: '+str(humidity))
	
	sql_statement = "INSERT INTO Climate VALUES (DEFAULT, '"+reading_date+"', '"+reading_time+"', '"+str(temp_c)+"', '"+str(temp_f)+"', '"+str(humidity)+"');"
	print('temp sql is: ')
	print(str(sql_statement))
	db_interaction(sql_statement)

def pir_detection(room, area):
	
	GPIO.output(GREEN_LED,GPIO.HIGH)
	GPIO.output(RED_LED,GPIO.LOW)
	print('detection from sensor '+str(room + area))
	
	#sql formatted date and time
	detection_date = current_date()
	detection_time = current_time()
	try:
		db_connection = pymysql.connect(host='localhost', port=3306, user='root', passwd='root', db='PiSmartHome', autocommit=True)
		db_cursor = db_connection.cursor()
		print('writing to database')
		sql_statement = "INSERT INTO Movements VALUES (DEFAULT, '"+detection_date+"', '"+detection_time+"', '"+room+"', '"+area+"');"
		db_cursor.execute(str(sql_statement))
	finally:
		db_connection.close()
		print('db connection closed')
		GPIO.output(GREEN_LED,GPIO.LOW)
		GPIO.output(RED_LED,GPIO.HIGH)




try:

	print ('PIR Movement detection')
	time.sleep(2)
	print ('ready')

	while True:
		if temp_countdown < 1:
			#reset timer
			temp_countdown = 60
			temp_reading()
		elif GPIO.input(PIR_1_PIN):
			pir_detection('Living Room', 'Window')
			print('done, sleeping for 10')
			time.sleep(10)
		
		#if GPIO.input(PIR_2_PIN):
		#	pir_detection('Living Room', 'Oven')
		
		else:
			
			time.sleep(1)
			temp_countdown -= 1
			print('next temp reading taken in ' + str(temp_countdown))
		
except KeyboardInterrupt:
	print ('Quit')
	GPIO.cleanup()

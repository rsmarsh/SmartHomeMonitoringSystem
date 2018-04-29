# Smart Home Monitoring System

The aim of this application was to create a smart home for as low a cost as possible.  
An intended use of this application was to monitor elderly homes and save costs of check-ups and reduce concerns by being able to detect recent movements.  

The result was achieved by having two types of a Raspberry Pi within the home:  
 * A Pi Zero as the 'hub' of the system, hosting the LAMP server for serving the website on top of a MySQL database.  
 * A Raspberry Pi 2/3 for each room that is being tracked, each sending their data back to the hub.  

  
All of the data collected is stored by the server and visible within a table on the landing page of the serving Pi
Each of the following will be recorded by the sensors within the home:
 * Movements and their locations  
 * Temperature and Humidity  
 * Harmful gasses  
 * Images which can capture the room when alarming events are detected, such as gas leaks
  

## Operation
Create the MySQL database using the schema on the host Raspberry Pi, and place the Web Interface files into a folder accessible by the Apache Server.  
  
## Sensors Used
 * DHT11  - Temperature and Humidity sensor
 * HC-SR501 PIR sensor - Movement detection
 * MQ135 - Gas detection sensor
 * Camera - Official Raspberry Pi camera

## Technology Stack

The application runs with assistance from the following technologies:  
  * Apache   
  * MySQL  
  * PHP
  * Python 3
  * HTML/JavaScript/CSS

# Credit

Created by Richard Marshall for a Dissertation project at The University of Sheffield  
Contact: Richard@live.cl
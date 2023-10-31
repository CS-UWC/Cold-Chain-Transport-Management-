import time
import paho.mqtt.client as paho
from paho import mqtt
import serial


# setting callbacks for different events to see if it works, print the message etc.
def on_connect(client, userdata, flags, rc, properties=None):
    print("CONNACK received with code %s." % rc)

# with this callback you can see if your publish was successful
def on_publish(client, userdata, mid, properties=None):
    print("mid: " + str(mid))

# print which topic was subscribed to
def on_subscribe(client, userdata, mid, granted_qos, properties=None):
    print("Subscribed: " + str(mid) + " " + str(granted_qos))

# print message, useful for checking if it was successful
def on_message(client, userdata, msg):
    print(msg.topic + " " + str(msg.qos) + " " + str(msg.payload))

# using MQTT version 5 here, for 3.1.1: MQTTv311, 3.1: MQTTv31
# userdata is user defined data of any type, updated by user_data_set()
# client_id is the given name of the client
client = paho.Client(client_id="", userdata=None, protocol=paho.MQTTv5)
client.on_connect = on_connect

# enable TLS for secure connection
client.tls_set(tls_version=mqtt.client.ssl.PROTOCOL_TLS)
# set username and password
client.username_pw_set("honours", "@sterix21")
# connect to HiveMQ Cloud on port 8883 (default for MQTT)
client.connect("7473c375bb6e44a0bdd5bab2f27c42a2.s1.eu.hivemq.cloud", 8883)

# setting callbacks, use separate functions like above for better visibility
client.on_subscribe = on_subscribe
client.on_message = on_message
client.on_publish = on_publish


values = []
temp = []

print('Established serial connection to Arduino')

print('Program started')
arduino = serial.Serial('/dev/ttyACM0', 9600)

try:

    while True:


        arduino_data = arduino.readline()

        decoded_values = arduino_data.decode().strip()
        

        if "Temperature:" in decoded_values:
            parts = decoded_values.split(" ")
            
            
            if len(parts) >= 2:
                
                temperature_celsius = float(parts[1])
                client.publish("encyclopedia/temperature", payload=str(temperature_celsius), qos=1)
                print(f" Temperature: {temperature_celsius}\u00B0C ")
                #client.subscribe("encyclopedia/#", qos=1)

                
        
except KeyboardInterrupt:
    arduino.close()

# subscribe to all topics of encyclopedia by using the wildcard "#"
client.subscribe("encyclopedia/#", qos=1)

# a single publish, this can also be done in loops, etc.
#client.publish("encyclopedia/temperature", payload="hot", qos=1)

# loop_forever for simplicity, here you need to stop the loop manually
# you can also use loop_start and loop_stop
client.loop_forever()
# all listed pins were connected R60 Microstep Driver

# DRIVER SETTINGS
# Current: 2.1 peak | 1.5 RMS (SW1-OFF, SW2-ON, SW3-ON)
# Pulse/rev: 200 (SW5-ON, SW6-ON, Sw7-ON, SW8-ON)

# HELPFUL TIPS
# ground all negative driver pins to Arduino
# Motor wires on the same coil will have greater resistance AB (BLUE|RED) CD (GREEN|BLACK) 
# are together

import pyfirmata
import time

board = pyfirmata.Arduino('COM8')

it = pyfirmata.util.Iterator(board)
it.start()

STEPS = 200 # steps for 1 revolution
DELAY = 50 / 10 ** 6 # num of micro-sec delay to adjust speed

# Motor 1 setup
PUL_PIN1 = board.get_pin('d:5:o') # PUL+
DIR_PIN1 = board.get_pin('d:2:o') # DIR+
EN_PIN1 = board.get_pin('d:8:o') # EN+
M1 = {"PUL": PUL_PIN1, "DIR": DIR_PIN1, "EN": EN_PIN1}

# infinite revolution test
while True:
    M1["DIR"].write(1)
    for i in range (STEPS):
        M1["PUL"].write(1)
        time.sleep(DELAY)
        M1["PUL"].write(0)
    time.sleep(DELAY*10**3)

# function to turn motor
# will take motor, degree turn, and speed



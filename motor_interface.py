
# all listed pins were connected to the R60 Microstep Driver

# DRIVER SETTINGS
# Current: 2.1 peak | 1.5 RMS (SW1-OFF, SW2-ON, SW3-ON)
# Pulse/rev: 200 (SW5-ON, SW6-ON, Sw7-ON, SW8-ON)

# HELPFUL TIPS
# ground all negative driver pins to Arduino
# Motor wires on the same coil will have greater resistance AB (BLUE|RED) CD (GREEN|BLACK) 
# are together

# The serial_control.ino file needs to be flashed to the Arduino before running this program

import pyfirmata
import time

board = pyfirmata.Arduino('COM8') # update port to specific device

it = pyfirmata.util.Iterator(board)
it.start()

STEPS = 200 # steps for 1 revolution
DELAY = 50 / 10 ** 6 # num of micro-sec delay to adjust speed

class Motor:
    def __init__(self, conv, relay_ctrl, pl_pin, dr_pin, e_pin):
        """
         - conv is how much the micrometer moves per rotation of the motor
         - pl_pin is for PUL+
         - dr_pin is for DIR+
         - e_pin is for EN+
        """

        self.pul_pin = board.get_pin(f'd:{pl_pin}:o')
        self.dir_pin = board.get_pin(f'd:{dr_pin}:o')
        self.en_pin = board.get_pin(f'd:{e_pin}:o')
        self.rev_conv = conv
        self.relay_pin = relay_ctrl

    """ 
    def turn_on_motor():
    """

    """ 
    def turn_off_motor():
    """

    def move_motor(self, steps, dir):
        # enable relay to allow current to flow to motor
        # turn_on_motor()

        if dir == -1:
            self.dir_pin.write(1)
        else:
            self.dir_pin.write(0)

        for i in range (steps):
            self.pul_pin.write(1)
            time.sleep(DELAY)
            self.pul_pin.write(0)
            time.sleep(DELAY)

        # turn_off_motor()

m1 = Motor(200, 5, 4, 2, 3)
m1.move_motor(200, 1)
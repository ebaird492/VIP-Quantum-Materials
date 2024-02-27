// all listed pins were connected R60 Microstep Driver

// DRIVER SETTINGS
// Current: 2.1 peak | 1.5 RMS (SW1-OFF, SW2-ON, SW3-ON)
// Pulse/rev: 200 (SW5-ON, SW6-ON, Sw7-ON, SW8-ON)

// HELPFUL TIPS
// ground all negative driver pins to Arduino
// Motor wires on the same coil will have greater resistance AB (BLUE|RED) CD (GREEN|BLACK) 
// are together

// PIN CONNECTIONS
const int PUL_PIN = 5; // PUL+
const int DIR_PIN = 2; // DIR+
const int EN_PIN = 8; // ENA+

const int STEPS = 200; // steps for 1 revolution
const int DELAY = 500; // num of microsecond delay

void setup() {
  pinMode(PUL_PIN, OUTPUT);
  pinMode(DIR_PIN, OUTPUT);
  pinMode(EN_PIN, OUTPUT);
  digitalWrite(EN_PIN, LOW);
}

void loop() {
  digitalWrite(DIR_PIN, HIGH); 
  for(int i = 0; i < STEPS; i++) { // based on pulse/rev
    digitalWrite(PUL_PIN, HIGH);
    delayMicroseconds(DELAY);
    digitalWrite(PUL_PIN, LOW);
    delayMicroseconds(DELAY);
  }
  delay(1000);
}

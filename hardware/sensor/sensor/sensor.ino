//Pin variables
const int red = 25;
const int green = 33;
const int blue = 32;
const int mq2 = 13;
const int buzzer = 12;

const int sensorPin = 13;      // Pin where the MQ-2 sensor is connected
const float Ro = 1.0;          // Resistance in clean air (adjust this based on calibration)
const float LPGCurve = 10.0;   // LPG curve sensitivity (adjust this based on calibration)

void setup() {

  Serial.begin(115200);
  Serial.println("Iniciando...");

  //Set PinModes
  pinMode(red, OUTPUT);
  pinMode(green, OUTPUT);
  pinMode(blue, OUTPUT);
  pinMode(mq2, INPUT);
  pinMode(buzzer, OUTPUT);

  //set the resolution to 12 bits (0-4096)
  analogReadResolution(12);
}

void loop() {
  int sensorValue = analogRead(sensorPin);  // Read the analog value from the sensor

  // Calculate sensor resistance using the sensor value and Ro
  float sensorResistance = (float)(4095 - sensorValue) / sensorValue * Ro;

  // Calculate gas concentration using LPG curve sensitivity
  float gasConcentration = pow(10, ((log10(sensorResistance / Ro) - 0.3) / LPGCurve));

  Serial.print("Sensor Value: ");
  Serial.print(sensorValue);
  Serial.print("\tSensor Resistance: ");
  Serial.print(sensorResistance);
  Serial.print("\tGas Concentration (ppm): ");
  Serial.println(gasConcentration);

  delay(1000);  // Wait for a second before the next reading
}
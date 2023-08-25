//Pin variables
const int mq2 = 13;

int step = 0;
int summation = 0;

void setup() {

  Serial.begin(115200);
  Serial.println("Iniciando...");

  //Set PinModes
  pinMode(mq2, INPUT);

  //set the resolution to 12 bits (0-4096)
  analogReadResolution(12);
}

void loop() {
  if(step < 300){

    int gas = analogRead(mq2);  // Read the analog value from the sensor

    Serial.print("Sensor Value: ");
    Serial.println(gas);

    summation += gas;
    step++;

  }else if(step == 300){

    Serial.println("Calculando promedio...");
    float ro = summation/300;

    Serial.print("Ro es igual a: ");
    Serial.println(ro);

    step++; 

  }else{

  }

  delay(1000);  // Wait for a second before the next reading
}
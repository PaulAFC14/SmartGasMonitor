#include <WiFi.h>
#include <HTTPClient.h>
#include <DHT.h>

char* ssid = "RedCasa"; // Reemplaza con el nombre de tu red WiFi
char* password = "B67D76P01A04";

//Sensor de temperatura
#define DHTPIN 14 // Pin al que está conectado el sensor DHT11
#define DHTTYPE DHT11 // Tipo de sensor (DHT11 en este caso)
DHT dht(DHTPIN, DHTTYPE);

//Definir pines
int buzzer = 13;
int mq2 = 32;
int g = 27;
int b = 26;
int r = 25;

int mapedGas = 0;
double temperature = 0;
int sensor_id = 1;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  dht.begin();

  //Pin modes
  pinMode(buzzer, OUTPUT);
  pinMode(mq2, INPUT);
  pinMode(g, OUTPUT);
  pinMode(b, OUTPUT);
  pinMode(r, OUTPUT);
  digitalWrite(r, HIGH);
  digitalWrite(g, HIGH);
  digitalWrite(b, HIGH);

  connectDeviceToNetwork();
}

void loop() {
  // put your main code here, to run repeatedly:
  int analogGas = analogRead(mq2);
  mapedGas = map(analogGas, 0, 4095, 0, 100);
  Serial.print("Analog value: ");Serial.print(analogGas);Serial.print(" | Percent: ");Serial.print(mapedGas);Serial.println("%");

  temperature = dht.readTemperature();
  if (!isnan(temperature)) {
    Serial.print("Temperatura: ");
    Serial.print(temperature);
    Serial.println(" °C");
  } else {
    Serial.println("Error al leer la temperatura.");
  }

  localLevel();
  sendRequest();
  delay(1000);
}

void localLevel(){
  if(mapedGas < 31){
    digitalWrite(r, HIGH);
    digitalWrite(g, LOW);
    digitalWrite(b, HIGH);
    noTone(buzzer);
  }else if(mapedGas < 61){
    digitalWrite(r, LOW);
    digitalWrite(g, LOW);
    digitalWrite(b, HIGH);
    noTone(buzzer);
  }else{
    digitalWrite(r, LOW);
    digitalWrite(g, HIGH);
    digitalWrite(b, HIGH);
    tone(buzzer, 4000);
    
  }
}

void sendRequest(){
  String serverAddress = "http://192.168.0.5:8000/api/values/send";

  HTTPClient http;
  http.begin(serverAddress);

  // Set headers
  http.addHeader("Content-Type", "application/x-www-form-urlencoded"); //Preparamos el header text/plain si solo vamos a enviar texto plano sin un paradigma llave:valor.
  http.addHeader("Accept", "application/json");
  http.addHeader("Authorization", "Bearer 3|LyVKhbTIW1qFOpTsm5zpb8b6T8yRSA9Iaga2FBAT06cf923b");

  // Set POST data as JSON
  //String jsonData = "{\"gas\":\"65\", \"temperature\":43, \"sensor_id\":1}";
  String data = "gas=" + String(mapedGas) + "&temperature=" + String(temperature) + "&sensor_id=" + String(sensor_id);
  
  int httpResponseCode = http.POST(data);
  if (httpResponseCode == 200) {
    String response = http.getString();
    Serial.println("Response: " + response);
  } else {
    String error = http.getString();
    Serial.println("HTTP Error: " + error);
  }

  http.end();
}

void connectDeviceToNetwork() {

  WiFi.begin(ssid, password);

  Serial.print("Connecting to ");
  Serial.println(ssid);

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("Successful connection.");
  Serial.print("IP Adress: ");
  Serial.println(WiFi.localIP());

}

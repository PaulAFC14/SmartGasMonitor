#include <WiFi.h>
#include <WiFiClient.h>
#include <ESPAsyncWebSrv.h>
#include <ESPmDNS.h> 

// Device status
int status = 0;

// STATUS: (0) Accespoint
const char* ssid = "SGMSensor";
const char* password = "password";
IPAddress local_IP(192, 168, 4, 1);
IPAddress gateway(192, 168, 4, 1);
IPAddress subnet(255, 255, 255, 0);

AsyncWebServer server(80);


// STATUS: (1) Connecting
String network = "network";
String pass = "pass";
int userId = 0;
int deviceId = 0;
String expressToken = "token";


// STATUS: (3) Sensor

//Pin variables
const int green = 33;
const int red = 32;
const int mq2 = 13;
const int buzzer = 12;

// STATUS 0
void setupAccesspoint() {

  Serial.println("Configuring access point...");

  // Setup ESP32 as accesspoint with static ip address
  if(!WiFi.softAPConfig(local_IP, gateway, subnet)){
    Serial.println("Error setting up IPAdress.");
  }else{
    Serial.println("IPAdress assigned.");
  }
  
  if (!WiFi.softAP(ssid, password)) {
    Serial.println("AccesPoint creation failed.");
  }else{
    Serial.println("AccesPoint started.");
  }

  // Init mDNS with name "esp32"
  if (!MDNS.begin("sgm")) {
    Serial.println("Error setting up MDNS.");
  }else{
    Serial.println("MDNS done.");
  }

  // Setup http server
  myHttpServer();

}

// Turn off accesspoint
void turnOffSoftAP() {
  WiFi.softAPdisconnect(true); // true para desactivar también la estación WiFi asociada
  Serial.println("AccesPoint disabled.");
}


// Init local Server
void myHttpServer() {
  server.on("/credentials", HTTP_POST, [](AsyncWebServerRequest *request){
    network = request->arg("ssid");
    pass = request->arg("password");

    Serial.println("(/credentials): Request received.");
    Serial.print("Network: ");
    Serial.print(network);
    Serial.print(" | Password: ");
    Serial.println(pass);

    // JSON response
    String jsonResponse = "";

    if(network.length() < 33){
      // Correct SSID
      if((pass.length() > 7) && (pass.length() < 64)){
        // Correct password 
        if(userId > 0){
          //Correct id
          status = 1;
          jsonResponse = "{\"message\":\"Credentials are OK.\",\"code\":0}";
        }else{
          //Wrong id
          jsonResponse = "{\"message\":\"Wrong userId.\",\"code\":3}";
        }
      }else{
        // Wrong password
        jsonResponse = "{\"message\":\"Wrong password.\",\"code\":2}";
      }
    }else{
      // Wrong SSID 
      jsonResponse = "{\"message\":\"Wrong SSID.\",\"code\":1}";
    }

    // Send JSON response
    request->send(200, "application/json", jsonResponse);
  });


  server.on("/isJoined", HTTP_POST, [](AsyncWebServerRequest *request){
    // JSON response
    String jsonResponse = "{\"message\":\"Credentials are OK.\",\"code\":0,\"id\":" + expressToken + "}";

    // Send JSON response
    request->send(200, "application/json", jsonResponse);
  });

  server.begin();
  Serial.println("Server started.");
}


// STATUS 3
void setupSensor() {
  //Set PinModes
  pinMode(red, OUTPUT);
  pinMode(green, OUTPUT);
  pinMode(mq2, INPUT);
  pinMode(buzzer, OUTPUT);

  // Set the resolution to 12 bits (0-4096)
  analogReadResolution(12);
}


void setup() {

  Serial.begin(115200);
  Serial.println("Starting device...");

  //STATUS: (0) Accespoint
  setupAccesspoint();
  
  //STATUS: (3) Sensor
  setupSensor();

}

void loop() {
  switch(status){
    case 0:
      Serial.println("STATUS: (0) AccessPoint");
      break;
    case 1:
      Serial.println("STATUS: (1) Connecting");
      connectDeviceToNetwork();
      break;
    case 2:
      Serial.println("STATUS: (2) Joining");
      break;
    case 3:
      Serial.println("STATUS: (3) Sensor");
      break;
    default:
      Serial.println("default");
      break;
  }

  delay(3000);
}


// Connecting device to network
void connectDeviceToNetwork() {

  WiFi.begin(network, pass);

  Serial.print("Connecting to ");
  Serial.println(network);

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("Successful connection.");
  Serial.print("IP Adress: ");
  Serial.println(WiFi.localIP());

  status = 2;

}

//Joining device to team
void joinToTeam() {
  //Provisional code to expect from services api
  expressToken = "token generado";
  status = 3;
}
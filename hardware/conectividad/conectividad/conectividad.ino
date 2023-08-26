#include <WiFi.h>
#include <WiFiClient.h>
#include <ESPAsyncWebSrv.h>
#include <ESPmDNS.h> 

const char* ssid = "SGMSensor";
const char* password = "password";
IPAddress local_IP(192, 168, 4, 1);
IPAddress gateway(192, 168, 4, 1);
IPAddress subnet(255, 255, 255, 0);

AsyncWebServer server(80);

void setup() {

  Serial.begin(115200);

  // Configura el ESP32 como punto de acceso con dirección IP estática
  Serial.println("Configuring access point...");

  WiFi.softAPConfig(local_IP, gateway, subnet);

  if (!WiFi.softAP(ssid, password)) {
    Serial.println("Creation failed.");
    log_e("Soft AP creation failed.");
    while(1);
  }

  Serial.println("Wifi started");

  // Inicializa mDNS con el nombre "esp32"
  if (!MDNS.begin("esp32")) {
    Serial.println("Error setting up MDNS responder!");
  }

  // Configura el servidor HTTP
  server.on("/connect", HTTP_POST, [](AsyncWebServerRequest *request){
    String red = request->arg("ssid");
    String pass = request->arg("password");

    Serial.print("Red: ");
    Serial.print(red);
    Serial.print(" | Password: ");
    Serial.println(pass);


    
    // Prepara la respuesta JSON
    String jsonResponse = "{\"message\":\"Conexión establecida\",\"status\":200}";

    // Envía la respuesta JSON
    request->send(200, "application/json", jsonResponse);
  });

  server.begin();

  Serial.println("Server started");
}


void loop() {
  // Tu código aquí
}

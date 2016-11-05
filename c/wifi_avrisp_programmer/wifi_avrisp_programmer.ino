#include <Arduino.h>

#include <SPI.h>
#include <ESP8266WiFi.h>
#include <ESP8266mDNS.h>
#include <ESP8266AVRISP.h>

const char* host = "esp8266-avrisp";
const char* ssid = "IoT_Dobbi";
const char* pass = "was7thod";
const uint16_t port = 328;
const uint8_t reset_pin = 5;

ESP8266AVRISP avrprog(port, reset_pin);

void setup() {
  Serial.begin(115200);
  avrprog.setReset(false);

  WiFi.begin(ssid, pass);
  while (WiFi.waitForConnectResult() != WL_CONNECTED);

  MDNS.begin(host);
  MDNS.addService("avrisp", "tcp", port);

  IPAddress local_ip = WiFi.localIP();
  Serial.print("\n\nIP address: ");
  Serial.println(local_ip);

  // listen for avrdudes
  avrprog.begin();
}

void loop() {
    static AVRISPState_t last_state = AVRISP_STATE_IDLE;
    AVRISPState_t new_state = avrprog.update();
    if (last_state != new_state) {
        switch (new_state) {
            case AVRISP_STATE_IDLE: {
                //Serial.printf("[AVRISP] now idle\r\n");
                // Use the SPI bus for other purposes
                break;
            }
            case AVRISP_STATE_PENDING: {
                //Serial.printf("[AVRISP] connection pending\r\n");
                // Clean up your other purposes and prepare for programming mode
                break;
            }
            case AVRISP_STATE_ACTIVE: {
                //Serial.printf("[AVRISP] programming mode\r\n");
                // Stand by for completion
                break;
            }
        }
        last_state = new_state;
    }
    // Serve the client
    if (last_state != AVRISP_STATE_IDLE) {
        avrprog.serve();
    }
}

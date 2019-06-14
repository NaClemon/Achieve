void setup() {
 Serial.begin(9600); //Baud rate: 9600
}
void loop() {
 int sensorValue = analogRead(A0);// read the input on analog pin 0:
 float voltage = sensorValue * (5.0/1024.0);
 float ntu = -1120.4*voltage*voltage + 5742.3*voltage - 4352.9;
 Serial.println(ntu); // print out the value you read:
 delay(500);
}

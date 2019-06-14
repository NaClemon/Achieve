int To = A2;
int Do = A1;
int Po = A0;

void setup() {
  Serial.begin(9600); //Baud rate: 9600
}
void loop() {
  int Povalue = analogRead(Po);

  float ph = (float)Povalue * 5.0 / 1024 / 6;
  float phvalue = -5.70 * ph +10.84;

  Serial.println("============"); 
  Serial.print("Ph : ");
  Serial.println(phvalue);
  delay(500);
}

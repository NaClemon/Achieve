#include <string.h>  
  
///////////////////////////////////////////  
#include <SoftwareSerial.h>  // 소프트웨어 시리얼 라이브러리
SoftwareSerial mySerial(2, 3);
///////////////////////////////////////////  
 
#define DEBUG true
int buf[10];

char * floatToString(char * outstr, double val, byte precision, byte widthp)
{  
  char temp[16]; //increase this if you need more digits than 15  
  byte i;  
  
  temp[0]='\0';  
  outstr[0]='\0';  
  
  if(val < 0.0)
  {  
    strcpy(outstr,"-\0");  //print "-" sign  
    val *= -1;  
  }  
  
 if( precision == 0)
 {  
    strcat(outstr, ltoa(round(val),temp,10));  //prints the int part  
 }  
 else
 {  
    unsigned long frac, mult = 1;  
    byte padding = precision-1;  
     
    while (precision--)  
    mult *= 10;  
  
    val += 0.5/(float)mult;      // compute rounding factor  
     
    strcat(outstr, ltoa(floor(val),temp,10));  //prints the integer part without rounding  
    strcat(outstr, ".\0"); // print the decimal point  
  
    frac = (val - floor(val)) * mult;  
  
    unsigned long frac1 = frac;  
  
    while(frac1 /= 10)   
      padding--;  
  
    while(padding--)   
      strcat(outstr,"0\0");    // print padding zeros  
  
    strcat(outstr,ltoa(frac,temp,10));  // print fraction part  
  }  
  
 // generate width space padding   
  if ((widthp != 0)&&(widthp >= strlen(outstr)))
  {  
    byte J=0;  
    J = widthp - strlen(outstr);  
  
    for (i=0; i< J; i++)
    {  
      temp[i] = ' ';  
    }  
  
    temp[i++] = '\0';  
    strcat(temp,outstr);  
    strcpy(outstr,temp);  
  }  
  
  return outstr;  
}
void setup() {
 
  Serial.begin(9600);
  
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }
  mySerial.begin(9600);
  sendData("AT+RST\r\n", 100, DEBUG); // rst
  sendData("AT+CWJAP=\"dlink-806a-z\",\"\"\"\r\n", 1000, DEBUG); //enter name and password
}
 
void loop() {
  int sensorValue = analogRead(A0);
  int swap;
  double voltage = sensorValue*(5.0/1024.0);

  for(int i=0; i<10; i++)
  {
    buf[i]=analogRead(A1);
    delay(5);
  }
  for(int i=0; i<9; i++)
  {
    for(int j=i+1;j<10;j++)
    {
      if(buf[i]>buf[j])
      {
        swap=buf[i];
        buf[i]=buf[j];
        buf[j]=swap;
      }
    }
  }
  unsigned long int avgValue=0;
  for(int i=2; i<8; i++)
    avgValue+=buf[i];
  double sensor2 = (double)avgValue * (5.0/1024/6);
  double vol2 = -7.78*sensor2 + 34.16;
  int key;
  char test[20];
  char test2[20];
  String temp(floatToString(test,voltage, 2, 0));
  String temp2(floatToString(test2,vol2, 2, 0));
  sendData("AT+CWMODE=3\r\n", 200, DEBUG); //  access point
  sendData("AT+CIFSR\r\n", 500, DEBUG); // get ip address
  sendData("AT+CIPMUX=1\r\n", 500, DEBUG); // configure for multiple connections
  sendData("AT+CIPSTART=4, \"TCP\",\"13.209.96.184\",80\r\n", 500, DEBUG); // turn on server on port 80
  
  String web = "GET /insert_data.php?tur="+temp+"&ph="+temp2+" ";
 
  web += "HTTP/1.0\r\n";
  web += "Host: 127.0.0.1\r\n";
  web += "\r\n";
  web += "\r\n";
  
  String cipsend = "AT+CIPSEND=";
  cipsend += 4;
  cipsend += ",";
  cipsend += String(web.length());
  cipsend += "\r\n";
  sendData(cipsend, 500, DEBUG);
  sendData(web, 500, DEBUG);
  String closeCommand = "AT+CIPCLOSE=";
  closeCommand += 4;// append connection id
  closeCommand += "\r\n";
  sendData(closeCommand, 500, DEBUG);
}
 
String sendData(String command, const int timeout, boolean debug) {
  String response = "";
  mySerial.print(command); // send the read character to the esp8266
  long int time = millis();
  while ( (time + timeout) > millis()) {
    while (mySerial.available()) {
      // output to the serial window
      char c = mySerial.read(); // read the next character.
      response += c;
    }
  }
  if (debug) {
    Serial.print(response);
  }
  return response;
}

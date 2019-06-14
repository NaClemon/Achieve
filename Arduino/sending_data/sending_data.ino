#include <string.h>
#include <SoftwareSerial.h>

SoftwareSerial mySerial(9, 8);

char* FloatToString(char*, double, byte, byte);
String sendData(String, const int, boolean);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  mySerial.begin(9600);

  sendData("AT+RST\r\n", 100, true);  // restart the module
  sendData("AT+CWMODE=3\r\n", 100, true); // wifi mode, 3: ap+station mode
  sendData("AT+CWJAP=\"dlink-806a-z\",\"\"\r\n", 500, true); // connect wifi
  sendData("AT+CIFSR\r\n", 500, true);  // get ip address, and ready to access network
  sendData("AT+CIPMUX=1\r\n", 500, true); // configure for multiple connections
  sendData("AT+CIPSTART=4, \"TCP\", \"54.180.117.127\", 80\r\n", 1000, true); // start TCP connection
}

void loop() {
  // put your main code here, to run repeatedly:
  int buf[10];
  int swap_temp;
  unsigned long int avgValue = 0;
  int turbiVol = analogRead(A0);
  int phVol;
  double turbiValue, phValue;

  for(int i = 0; i < 10; i++)
  {
    buf[i]=analogRead(A1);
    delay(10);
  }

  // To find average value of center values
  for(int i = 0; i < 9; i++)
  {
    for(int j = i + 1; j < 10; j++)
    {
      if (buf[i] > buf[j])
      {
        swap_temp = buf[i];
        buf[i] = buf[j];
        buf[j] = swap_temp;
      }
    }
  }
  
  for(int i = 2; i < 8; i++)
  {
    avgValue += buf[i];
  }
  phVol = (double)avgValue * (5.0 / 1024.0 / 6.0);
  
  turbiValue = turbiVol * (5.0 / 1024.0);
  phValue = -7.78 * phVol + 34.16;

  char ph_temp[20], turbidity_temp[20];
  String ph(FloatToString(ph_temp, phValue, 2, 0));
  String turbidity(FloatToString(turbidity_temp, turbiValue, 2, 0));

  String web = "GET /insert2.php?tur="+turbidity+"&ph="+ph+" ";

  web += "HTTP/1.0\r\n";
  web += "Host: 127.0.0.1\r\n";
  web += "\r\n";
  web += "\r\n";

  String cipsend = "AT+CIPSEND=";
  cipsend += 4;
  cipsend += ",";
  cipsend += String(web.length());
  cipsend += "\r\n";
  sendData(cipsend, 500, true);
  sendData(web, 1000, true);
}

String sendData(String command, const int timeout, boolean debug)
{
  String response = "";

  mySerial.print(command);

  long int time = millis();

  while((time + timeout) > millis())
  {
    while(mySerial.available())
    {
      char c = mySerial.read();
      response += c;
    }
  }

  if (debug)
    Serial.print(response);

  return response;  
}

char* FloatToString(char* outstr, double value, byte precision, byte widthp)
{
  char temp[20];
  byte i;

  temp[0] = '\0';
  outstr[0] = '\0';

  if(value < 0.0)
  {
    strcpy(outstr, "-\0");
    value *= -1;
  }

  if(precision == 0)
    strcpy(outstr, ltoa(round(value), temp, 10));
  else
  {
    unsigned long frac, mult = 1;
    byte padding = precision - 1;

    while (precision--)
      mult *= 10;

    value += 0.5/(float)mult;

    strcat(outstr, ltoa(floor(value), temp, 10));
    strcat(outstr, ".\0");

    frac = (value - floor(value)) * mult;

    unsigned long frac1 = frac;

    while (frac1 /= 10)
      padding--;

    while (padding--)
      strcat(outstr, "0\0");
    
    strcat(outstr, ltoa(frac, temp, 10));
  }

  if ((widthp != 0) && (widthp >= strlen(outstr)))
  {
    byte j = 0;
    j = widthp - strlen(outstr);

    for(i = 0; i < j; i++)
    {
      temp[i] = ' ';
    }

    temp[i++] = '\0';
    
    strcat(temp, outstr);
    strcpy(outstr, temp);
  }

  return outstr;
}

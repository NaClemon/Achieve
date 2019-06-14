#include <string.h>  

#include "ESP8266.h"
#include <SoftwareSerial.h>  
    

#define SSID "dlink-806a-z"

#define PASSWORD ""

//#define SERVERIP "54.180.31.18"
#define SERVERIP "52.79.239.53"

SoftwareSerial mySerial(2, 3); /* RX:D11, TX:D10 */

      
      
      
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
  
  
      
void setup(void)    
{    
    
  //시리얼 포트 초기화    
  Serial.begin(9600);    
  /////////////////////////////////////////////////////////////////////////  
  Serial.setTimeout(2000);  
  mySerial.begin(9600);   
  Serial.println("ESP8266 connect");  
    
   boolean connected=false;  
   for(int i=0;i<10;i++)  
   {  
       if(connectWiFi())  
       {  
         connected = true;  
         break;  
       }  
   }  
     
   if (!connected){while(1);}  
   delay(5000);  
    
   mySerial.println("AT+CIPMUX=0");  
  ///////////////////////////////////////////////////////////////////////////
}    

      
void loop(void)    
{     
  int sensorValue = analogRead(A0);
  double voltage = sensorValue*(5.0/1024.0);

  String cmd = "AT+CIPSTART=\"TCP\",\"";
  cmd += SERVERIP;
  cmd += "\",80";
  Serial.println(cmd);
  mySerial.println(cmd);
  if(mySerial.find("Error"))
  {  
    Serial.println( "TCP connect error" );  
    return;  
  }

  char test[20];
  String temp(floatToString(test,voltage, 2, 0));  
      
  cmd = "GET 52.79.239.53/insert_data.php?x="+temp;  
  mySerial.print("AT+CIPSEND=");  
  mySerial.println(cmd.length());  
          
  Serial.println(cmd);  
       
       
  if(mySerial.find(">"))  
  {  
    Serial.print(">");  
  }
  else  
  {  
    mySerial.println("AT+CIPCLOSE");  
    Serial.println("connect timeout");  
    delay(1000);  
    return;  
  }  
         
  mySerial.println(cmd);
  delay(2000);  
  //Serial.find("+IPD");  
  while (Serial.available())  
  {  
    char c = Serial.read();  
    mySerial.write(c);  
    if(c=='\r') mySerial.print('\n');  
  }
  Serial.println("====");
  delay(1000);

}    
  
  
boolean connectWiFi()  
{  
   mySerial.println("AT+CWMODE=3");
     
   String cmd="AT+CWJAP=\"";  
   cmd+=SSID;  
   cmd+="\",\"";  
   cmd+=PASSWORD;  
   cmd+="\"";  
   mySerial.println(cmd);  
   Serial.println(cmd);  
   delay(3000);  
    
   if(mySerial.find("OK"))  
   {  
     Serial.println("OK, Connected to WiFi.");  
     return true;  
   }  
   else  
   {  
     Serial.println("Can not connect to the WiFi.");  
     return false;  
   }  
 }  

#include <Servo.h>
#include <SoftwareSerial.h>

Servo servo;
int servoPin = 2;
 
#define BT_RXD A5
#define BT_TXD A4
SoftwareSerial bluetooth(BT_RXD, BT_TXD);

int BltPin = 4;
 
int motor = 2;  // 서보모터의 핀 
int angle = 90; // 서보모터 초기 각도 값
 
void setup(){
  servo.attach(motor);  // 서보모터 연결
  Serial.begin(9600);
  bluetooth.begin(9600);
}
 
void loop(){
  
  if (bluetooth.available()) {
    
    char input = bluetooth.read();
    if(input == 'a')    //  오른쪽 키를 누를 때
    {
      Serial.print("+15");  // '+15'를 시리얼 모니터에 출력
      for(int i = 0; i < 15; i++)  // 현재 각도에서 15도 더해주기
      {
        angle = angle + 1;   
        if(angle >= 180)
          angle = 180;
                    
        servo.write(angle); 
        delay(10);
      }
      
      Serial.print("\t\t");
      Serial.println(angle);  // 현재 각도 출력
    } 
    else if(input == 'b')   // 왼쪽 키를 입력했을 때
    {
      Serial.print("\t-15\t");  // '-15'라고 출력
      for(int i = 0 ; i < 15 ; i++)  // 현재 각도에서 15도 빼주기
      {
        angle = angle - 1;
        if(angle <= 0)
          angle = 0;
        servo.write(angle);
        delay(10);
      }
      Serial.println(angle);  // 현재 각도 출력
    }
    else  // 잘못된 문자열을 입력했을 때
    {
      //Serial.println("wrong character!!");
    }
  }

  
}

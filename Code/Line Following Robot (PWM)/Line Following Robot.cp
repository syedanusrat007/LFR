#line 1 "D:/WorkShop @ TechShopBD/Line Following Robot/Program (05-11-2015)/Line Following Robot.c"

int last_direction;

float Robot_Speed=200;







void robot_move(int direc)
 {
 if(direc== 0 )
 {
 PORTA=0x05;
 Delay_ms(1);
 }

 if(direc== 1 )
 {
 PORTA=0x01;
 Delay_ms(1);
 }

 if(direc== 2 )
 {
 PORTA=0x04;
 Delay_ms(1);
 }
}



void main()
{
 TRISA=0x00;

 TRISD6_bit=1;
 TRISD7_bit=1;

 TRISC1_bit=0;
 TRISC2_bit=0;

 PWM1_Init(5000);
 PWM2_Init(5000);

 PWM1_Start();
 PWM2_Start();

 PWM1_Set_Duty(Robot_Speed);
 PWM2_Set_Duty(Robot_Speed);


 while(1)
 {

 if(RD7_bit==1&& RD6_bit==1)
 {
 robot_move( 0 );
 last_direction= 0 ;
 }
 else if(RD7_bit==1&& RD6_bit==0)
 {
 robot_move( 1 );
 last_direction= 1 ;
 }

 else if(RD7_bit==0&&RD6_bit==1)
 {
 robot_move( 2 );
 last_direction= 2 ;
 }

 else if (RD7_bit=0&&RD6_bit==0)
 {
 robot_move(last_direction);
 }
 }

}

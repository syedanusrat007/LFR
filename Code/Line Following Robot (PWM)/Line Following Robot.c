
int last_direction; // variable declaration

float Robot_Speed=200;  // Set the Robot Speed
 
 
#define forward 0 //flag define
#define left 1    //flag define
#define right 2   //flag define


void robot_move(int direc)//define a function named robot_move which will return direction
  {
    if(direc==forward)        //if the direction is forward
      {
       PORTA=0x05;              //IN1=1, In2=0, IN3=1, IN4=0 ,ie both motor will move forward
       Delay_ms(1);            //wait for 10 mili second
      }

  if(direc==left)          //if the direction is left
    {
     PORTA=0x01;             //IN1=1,In2=0,IN3=0,IN4=1
     Delay_ms(1);           //wait for 10 mili second ie left motor will stop, right will move forward
    }
    
  if(direc==right)         //if the direction is right
    {
       PORTA=0x04;             //IN1=0,IN2=1,IN3=1,IN4=0 ;ie right motor will stop, left will move forward
       Delay_ms(1);           //wait for 10 mili second
    }
}



void main()
{
  TRISA=0x00;                  //PORTD is output
   
  TRISD6_bit=1;               //Declare RD7 as input for Sensor_1
  TRISD7_bit=1;               //Declare RB2 as input for Sensor_2

  TRISC1_bit=0;   //Use RC1 as PWM_2
  TRISC2_bit=0;   //Use RC2 as PWM_1
   
  PWM1_Init(5000);  // Initialize PWM1 module at 5KHz
  PWM2_Init(5000);  // Initialize PWM2 module at 5KHz

  PWM1_Start();  // start PWM1
  PWM2_Start();  // start PWM2

  PWM1_Set_Duty(Robot_Speed); // Set current duty for PWM1
  PWM2_Set_Duty(Robot_Speed); // Set current duty for PWM2

   
     while(1)
     {

       if(RD7_bit==1&& RD6_bit==1) // When both sensors are on black line
         {
            robot_move(forward);      //move forward
            last_direction=forward;   //save forward in the variable named last direction
          }
       else if(RD7_bit==1&& RD6_bit==0) // When left sensor is on black line
         {
            robot_move(left);               //move left
            last_direction=left;             //save left in the variable named last direction
         }

       else if(RD7_bit==0&&RD6_bit==1)// When right sensor is on black line
         {
            robot_move(right);            //move right
            last_direction=right;         //save right in the variable named last direction
         }

       else if (RD7_bit=0&&RD6_bit==0)// When none of the sensors is on black line
         {
            robot_move(last_direction);  //move to last direction
         }
     }

}
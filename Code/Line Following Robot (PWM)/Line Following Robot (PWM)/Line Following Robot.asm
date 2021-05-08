
_robot_move:

;Line Following Robot.c,12 :: 		void robot_move(int direc)//define a function named robot_move which will return direction
;Line Following Robot.c,14 :: 		if(direc==forward)        //if the direction is forward
	MOVLW      0
	XORWF      FARG_robot_move_direc+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__robot_move25
	MOVLW      0
	XORWF      FARG_robot_move_direc+0, 0
L__robot_move25:
	BTFSS      STATUS+0, 2
	GOTO       L_robot_move0
;Line Following Robot.c,16 :: 		PORTA=0x05;              //IN1=1, In2=0, IN3=1, IN4=0 ,ie both motor will move forward
	MOVLW      5
	MOVWF      PORTA+0
;Line Following Robot.c,17 :: 		Delay_ms(1);            //wait for 10 mili second
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_robot_move1:
	DECFSZ     R13+0, 1
	GOTO       L_robot_move1
	DECFSZ     R12+0, 1
	GOTO       L_robot_move1
	NOP
	NOP
;Line Following Robot.c,18 :: 		}
L_robot_move0:
;Line Following Robot.c,20 :: 		if(direc==left)          //if the direction is left
	MOVLW      0
	XORWF      FARG_robot_move_direc+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__robot_move26
	MOVLW      1
	XORWF      FARG_robot_move_direc+0, 0
L__robot_move26:
	BTFSS      STATUS+0, 2
	GOTO       L_robot_move2
;Line Following Robot.c,22 :: 		PORTA=0x01;             //IN1=1,In2=0,IN3=0,IN4=1
	MOVLW      1
	MOVWF      PORTA+0
;Line Following Robot.c,23 :: 		Delay_ms(1);           //wait for 10 mili second ie left motor will stop, right will move forward
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_robot_move3:
	DECFSZ     R13+0, 1
	GOTO       L_robot_move3
	DECFSZ     R12+0, 1
	GOTO       L_robot_move3
	NOP
	NOP
;Line Following Robot.c,24 :: 		}
L_robot_move2:
;Line Following Robot.c,26 :: 		if(direc==right)         //if the direction is right
	MOVLW      0
	XORWF      FARG_robot_move_direc+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__robot_move27
	MOVLW      2
	XORWF      FARG_robot_move_direc+0, 0
L__robot_move27:
	BTFSS      STATUS+0, 2
	GOTO       L_robot_move4
;Line Following Robot.c,28 :: 		PORTA=0x04;             //IN1=0,IN2=1,IN3=1,IN4=0 ;ie right motor will stop, left will move forward
	MOVLW      4
	MOVWF      PORTA+0
;Line Following Robot.c,29 :: 		Delay_ms(1);           //wait for 10 mili second
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_robot_move5:
	DECFSZ     R13+0, 1
	GOTO       L_robot_move5
	DECFSZ     R12+0, 1
	GOTO       L_robot_move5
	NOP
	NOP
;Line Following Robot.c,30 :: 		}
L_robot_move4:
;Line Following Robot.c,31 :: 		}
L_end_robot_move:
	RETURN
; end of _robot_move

_main:

;Line Following Robot.c,35 :: 		void main()
;Line Following Robot.c,37 :: 		TRISA=0x00;                  //PORTD is output
	CLRF       TRISA+0
;Line Following Robot.c,39 :: 		TRISD6_bit=1;               //Declare RD7 as input for Sensor_1
	BSF        TRISD6_bit+0, 6
;Line Following Robot.c,40 :: 		TRISD7_bit=1;               //Declare RB2 as input for Sensor_2
	BSF        TRISD7_bit+0, 7
;Line Following Robot.c,42 :: 		TRISC1_bit=0;   //Use RC1 as PWM_2
	BCF        TRISC1_bit+0, 1
;Line Following Robot.c,43 :: 		TRISC2_bit=0;   //Use RC2 as PWM_1
	BCF        TRISC2_bit+0, 2
;Line Following Robot.c,45 :: 		PWM1_Init(5000);  // Initialize PWM1 module at 5KHz
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;Line Following Robot.c,46 :: 		PWM2_Init(5000);  // Initialize PWM2 module at 5KHz
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM2_Init+0
;Line Following Robot.c,48 :: 		PWM1_Start();  // start PWM1
	CALL       _PWM1_Start+0
;Line Following Robot.c,49 :: 		PWM2_Start();  // start PWM2
	CALL       _PWM2_Start+0
;Line Following Robot.c,51 :: 		PWM1_Set_Duty(Robot_Speed); // Set current duty for PWM1
	MOVF       _Robot_Speed+0, 0
	MOVWF      R0+0
	MOVF       _Robot_Speed+1, 0
	MOVWF      R0+1
	MOVF       _Robot_Speed+2, 0
	MOVWF      R0+2
	MOVF       _Robot_Speed+3, 0
	MOVWF      R0+3
	CALL       _Double2Byte+0
	MOVF       R0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Line Following Robot.c,52 :: 		PWM2_Set_Duty(Robot_Speed); // Set current duty for PWM2
	MOVF       _Robot_Speed+0, 0
	MOVWF      R0+0
	MOVF       _Robot_Speed+1, 0
	MOVWF      R0+1
	MOVF       _Robot_Speed+2, 0
	MOVWF      R0+2
	MOVF       _Robot_Speed+3, 0
	MOVWF      R0+3
	CALL       _Double2Byte+0
	MOVF       R0+0, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;Line Following Robot.c,55 :: 		while(1)
L_main6:
;Line Following Robot.c,58 :: 		if(RD7_bit==1&& RD6_bit==1) // When both sensors are on black line
	BTFSS      RD7_bit+0, 7
	GOTO       L_main10
	BTFSS      RD6_bit+0, 6
	GOTO       L_main10
L__main23:
;Line Following Robot.c,60 :: 		robot_move(forward);      //move forward
	CLRF       FARG_robot_move_direc+0
	CLRF       FARG_robot_move_direc+1
	CALL       _robot_move+0
;Line Following Robot.c,61 :: 		last_direction=forward;   //save forward in the variable named last direction
	CLRF       _last_direction+0
	CLRF       _last_direction+1
;Line Following Robot.c,62 :: 		}
	GOTO       L_main11
L_main10:
;Line Following Robot.c,63 :: 		else if(RD7_bit==1&& RD6_bit==0) // When left sensor is on black line
	BTFSS      RD7_bit+0, 7
	GOTO       L_main14
	BTFSC      RD6_bit+0, 6
	GOTO       L_main14
L__main22:
;Line Following Robot.c,65 :: 		robot_move(left);               //move left
	MOVLW      1
	MOVWF      FARG_robot_move_direc+0
	MOVLW      0
	MOVWF      FARG_robot_move_direc+1
	CALL       _robot_move+0
;Line Following Robot.c,66 :: 		last_direction=left;             //save left in the variable named last direction
	MOVLW      1
	MOVWF      _last_direction+0
	MOVLW      0
	MOVWF      _last_direction+1
;Line Following Robot.c,67 :: 		}
	GOTO       L_main15
L_main14:
;Line Following Robot.c,69 :: 		else if(RD7_bit==0&&RD6_bit==1)// When right sensor is on black line
	BTFSC      RD7_bit+0, 7
	GOTO       L_main18
	BTFSS      RD6_bit+0, 6
	GOTO       L_main18
L__main21:
;Line Following Robot.c,71 :: 		robot_move(right);            //move right
	MOVLW      2
	MOVWF      FARG_robot_move_direc+0
	MOVLW      0
	MOVWF      FARG_robot_move_direc+1
	CALL       _robot_move+0
;Line Following Robot.c,72 :: 		last_direction=right;         //save right in the variable named last direction
	MOVLW      2
	MOVWF      _last_direction+0
	MOVLW      0
	MOVWF      _last_direction+1
;Line Following Robot.c,73 :: 		}
	GOTO       L_main19
L_main18:
;Line Following Robot.c,75 :: 		else if (RD7_bit=0&&RD6_bit==0)// When none of the sensors is on black line
	BCF        RD7_bit+0, 7
	BTFSS      RD7_bit+0, 7
	GOTO       L_main20
;Line Following Robot.c,77 :: 		robot_move(last_direction);  //move to last direction
	MOVF       _last_direction+0, 0
	MOVWF      FARG_robot_move_direc+0
	MOVF       _last_direction+1, 0
	MOVWF      FARG_robot_move_direc+1
	CALL       _robot_move+0
;Line Following Robot.c,78 :: 		}
L_main20:
L_main19:
L_main15:
L_main11:
;Line Following Robot.c,79 :: 		}
	GOTO       L_main6
;Line Following Robot.c,81 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

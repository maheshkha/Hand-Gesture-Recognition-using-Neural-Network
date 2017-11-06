%##########################################################################
%########################--MATLAB CODE--###################################
%##########################################################################
%This code assumes that you have MATLAB hooked up to a PIC microcontroller via the PC's serial port through a
%MAX232 IC _OR_ if you don't use a max232 all you need is a 22 kohm limiting resistor on
%the serial line which connects the computer to the PIC (aka Pin 3 and/or Pin 2, see below). 
%Pin 3 or the DB-9 port is the TX line, aka the line that carries serial data from the PC to the PIC. 
%Pin 2 carries serial data the other way (PIC to PC) if you want to do that. 
%Pin 5 is the DB-9 ground pin which you should use to connect the PC ground with the PIC ground.
%This code also assumes that you're using COM3 for serial communication with the PIC.
clc;
close all;
clear all;
SerPIC = serial('COM3');        		%<--change this appropriately
set(SerPIC,'BaudRate', 9600, 'DataBits', 8, 'Parity', 'none','StopBits', 1, 'FlowControl', 'none');              
fopen(SerPIC);                              	%--open the serial port to the PIC
M_Background = aviread('im0.avi');
Background = frame2im(M_Background(1));

while(1)
    
answer = input('Would you like to call the Hand Gesture Recognition? y/n\n','s');

if (answer == 'y')
    [fn,pn] = uigetfile('*.avi','The file name should have avi extension.');
    M_Input 	=  aviread([pn,fn]);
    Input = frame2im(M_Input(1));
    Sign = count_fingers1(Background, Input, 30)
if(Sign ==1)
    fprintf(SerPIC, '%s', '001');			%--send a _three_ digit string to the PIC with no terminator ('%s')
						%-- 001 = 00000001 in binary
end
if(Sign ==2)
   fprintf(SerPIC, '%s', '002');			%--send a _three_ digit string to the PIC with no terminator ('%s')
						%-- 002 = 00000010 in binary
end
if(Sign ==3)
  fprintf(SerPIC, '%s', '003');			%--send a _three_ digit string to the PIC with no terminator ('%s')
						%-- 001 = 00000011 in binary
end   
if(Sign ==4)
  fprintf(SerPIC, '%s', '004');			%--send a _three_ digit string to the PIC with no terminator ('%s')
						%-- 001 = 00000100 in binary
end   
if(Sign ==5)
  fprintf(SerPIC, '%s', '005');			%--send a _three_ digit string to the PIC with no terminator ('%s')
						%-- 001 = 00000101 in binary
end   
else
   disp('If you want to run this program again simply type "serial-interface_fingure_count" at the')
   disp('MATLAB prompt.  To avoid the start screen you may directly type') 
    fclose(SerPIC)					%--close the serial port when done
    delete(SerPIC)				
    clear SerPIC
   return;
end
end %while
fclose(SerPIC)					%--close the serial port when done
delete(SerPIC)				
clear SerPIC

%NOTE 1:
%if MATLAB ever gives a serial error, it will most likely say 'unable to open serial port' next time you
%run the program, so you have to restart MATLAB
%NOTE 2:
%the number must always be sent as a three digit number because for some reason I couldn't get my PIC to receive
%the number when it wasn't of a specified length (see PIC code: DEC3)

%==========================================================================
%==========================================================================

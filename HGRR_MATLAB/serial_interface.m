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

SerPIC = serial('COM3');        		%<--change this appropriately
set(SerPIC,'BaudRate', 9600, 'DataBits', 8, 'Parity', 'none','StopBits', 1, 'FlowControl', 'none');              
fopen(SerPIC);                              	%--open the serial port to the PIC

fprintf(SerPIC, '%s', '001');			%--send a _three_ digit string to the PIC with no terminator ('%s')
						%-- 001 = 00000001 in binary
%fprintf(SerPIC, '%s', '002');			%--send a _three_ digit string to the PIC with no terminator ('%s')
						%-- 002 = 00000010 in binary
%fprintf(SerPIC, '%s', '003');			%--send a _three_ digit string to the PIC with no terminator ('%s')
						%-- 001 = 00000011 in binary

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

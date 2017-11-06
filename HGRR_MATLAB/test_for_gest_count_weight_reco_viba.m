clc;
close all;
clear all;
M_Background = aviread('im0.avi');
M_Input 	=     aviread('im1_t.avi');
% M_Input 	=     aviread('im2_t.avi');
% 
% M_Input 	=     aviread('im3_t.avi');
% M_Input 	=     aviread('im4_t.avi');
% M_Input 	=     aviread('im5_t.avi');

Background = rgb2gray(frame2im(M_Background(1)));%
Input = (frame2im(M_Input(1)));%rgb2gray
Sign = count_fingers1(Background, Input, 30)
nb_finger = count_fingers3(Background, Input, 60,1,Sign);
% nb_finger = recognition(Background,Input)

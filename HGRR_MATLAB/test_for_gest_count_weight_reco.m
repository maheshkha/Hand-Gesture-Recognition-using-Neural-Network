clc;
close all;
clear all;
M_Background = aviread('im0.avi');
M_Input 	=     aviread('im5.avi');
Background = rgb2gray(frame2im(M_Background(1)));%
Input = rgb2gray(frame2im(M_Input(1)));%rgb2gray
Sign = count_fingers1(Background, Input, 30)
nb_finger = count_fingers3(Background, Input, 60, 1);
% nb_finger = recognition(Background,Input)
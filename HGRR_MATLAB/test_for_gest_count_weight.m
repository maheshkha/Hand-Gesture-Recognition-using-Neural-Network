clc;
close all;
clear all;
[fn,pn] = uigetfile('*.avi','The file name should have avi extension.');

M_Background = aviread('im0.avi');
M_Input 	=  aviread([pn,fn]);
Background = frame2im(M_Background(1));
Input = frame2im(M_Input(1));
Sign = count_fingers1(Background, Input, 30)


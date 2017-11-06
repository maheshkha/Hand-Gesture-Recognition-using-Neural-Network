clc;
close all;
clear all;
% M_Background = aviread('im0.avi');
% M_Input 	=     aviread('im2_t.avi');
load fingerbg.mat;
bg1 = frame1;
figure,
len_frame = length(bg1(:,1,1,1));
for i=1:1,%len_frame,
    x(:,:,:)=bg1(i,:,:,:);
    imshow(x);
    pause(1);
end

load fingerbg1.mat;

figure,
len_frame = length(frame1(:,1,1,1));
for i=1:len_frame,
    x(:,:,:)=frame1(i,:,:,:);
    imshow(x);
    pause(1);
end

% Background = rgb2gray(frame2im(M_Background(1)));%
x(:,:,:)=bg1(1,:,:,:);
Background = rgb2gray(x);
% Input = rgb2gray(frame2im(M_Input(1)));%rgb2gray
x1(:,:,:)=frame1(1,:,:,:);
Input = rgb2gray(x1);
Sign = count_fingers1(Background, Input, 30)
figure,
nb_finger = count_fingers3(Background, Input, 60, 1);
% nb_finger = recognition(Background,Input)
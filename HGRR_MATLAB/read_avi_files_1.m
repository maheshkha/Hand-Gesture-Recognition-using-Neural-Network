% start code for gesture
clc % cmd clear 
close all % figure close
clear all % variable clear

%input reading
M_im0 = aviread('im0.avi');  %   background, 1 sample
M_im1 = aviread('im1.avi');  %   1 finger, 50 samples

% Play the movie
 movie(M_im1,1);
[m n]=size(M_im0);                  %  size for film

%display data
% figure,imshow(M_im0(1).cdata);
% figure,imshow(M_im1(1).cdata);
% figure,imshow(M_im1(2).cdata);
% figure,imshow(M_im1(3).cdata);
% figure,imshow(M_im1(4).cdata);


%image variable
x=M_im1(1).cdata;
figure,imshow(x);

%rgb2gray and noise processing
x1= rgb2gray(x);
figure,imshow(x1);

% histrogram calculations
reg_I_hist=imhist(x1);
figure;plot(reg_I_hist);

% equ histrogram calculations
eq_I_hist= histeq(x1);
figure;imshow(eq_I_hist);

reg_I_hist=imhist(eq_I_hist);
figure;plot(reg_I_hist);

% Noise addition
J = imnoise(x1,'salt & pepper',0.02);
figure;subplot(221),imshow(J);

% median filtering calculations
L = medfilt2(J,[5 5]);
subplot(222),imshow(L);

% median filtering calculations
L1 = medfilt2(J,[3 3]);
%subplot(222),imshow(L);

% error 5x5 calculations
err = L - x1;
subplot(223),imshow(err);

% error 3x3 calculations
err1 = L1 - x1;
subplot(224),imshow(err1);


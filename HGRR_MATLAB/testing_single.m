clc
close all
clear all
feature_extraction = [];
feature_extra = [];
k=1;
j1=1;
j2=1;

[fn,pn] = uigetfile('*.jpg','The file name should have jpg extension.');
in_img6 = imread([pn,fn]); % read the image
% axes(handles.axes2);
imshow(in_img6);
title('Unknown Image');

        x=rgb2gray(in_img6);%image toolbox dependent
    %     imshow(uint8(x));
    x=double(x);
    I = imresize(x,[80 64],'bicubic');
        Hi=imhist(I);

     BW = edge(I,'canny',0.25); %finding edges 
    [imx,imy]=size(BW);
    msk=[0 0 0 0 0;
         0 1 1 1 0;
         0 1 1 1 0;
         0 1 1 1 0;
         0 0 0 0 0;];
    B=conv2(double(BW),double(msk)); %Smoothing  image to reduce the number of connected components
    bw_7050=imresize(B,[70,50]);
    for cnt=1:7
        for cnt2=1:5
            Atemp=sum(bw_7050((cnt*10-9:cnt*10),(cnt2*10-9:cnt2*10)));
            lett((cnt-1)*5+cnt2)=sum(Atemp);
        end
    end

    lett=((100-lett)/100);
    lett=lett;

%         feature = [Hi'];
        feature = [lett];
        feature_extra = [feature_extra; feature];
%         data_target(j1,j2) = 1;
        j2 = j2+1;
        k = k+1;

%         j2 = j2+1;
        j1 = j1+1;
% load total_feature_16may09_5_signs_40samples_new_1
% here load training net file
% load network_50epochs_2may_final
% load network_50epochs_17may1_first_5_of_40_samples_2
% load network_50epochs_gesture;
load network_50epochs_gesture_lett;

%input
% P = [0 1 2 3 4 5 6 7 8 9 10];
P = feature_extra';
[m n]=size(feature_extra);
% T = data_target;

% [m N_test] = size(T);
Testing_Error = NaN * zeros(1,11);
%   Simulating the testing set
Sim_test = sim(net,P);% Simulation using the testing set
% Result_test = find(compet(Sim_test));
% Target_test = find(compet(T));
% Number_of_Errors = sum(Result_test ~= Target_test)% Calculating the number of errors
% Norm_Number_of_Error = Number_of_Errors / (3*N_test) % Normalizing the number of errors


nb_gesture = mod(find(compet(Sim_test)),5)
tab_asl = [ 'A' 'B' 'C' 'D' 'E'];% 'f' 'g' 'h' 'i' 'j']';
tab_asl1 = [ 1 2 3 4 5];% 6 7 8 9 0]';

[m n]=size(nb_gesture);
[m1 n1]=size(tab_asl1);
for i=1:m
    for j=1:n1-1
        if(nb_gesture(i)== tab_asl1(j))
            disp(tab_asl(j));
            Sign=num2str(j);
%             set(handles.edit1,'String',tab_asl(j));
%  set(handles.edit1,'String',num2str(j));
%tab_asl = [ 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z']';
        elseif (nb_gesture(i)== tab_asl1(n1))
            disp(['May be false result' tab_asl(j)]);
        end
    end
end

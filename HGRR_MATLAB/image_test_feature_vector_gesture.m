clc
close all
clear all

% here load training net file
% load network_50epochs_2may_final
% load network_50epochs_gesture
load network_50epochs_gesture_lett
% load total_feature_asl_1;
load total_feature_all

%input
% P = [0 1 2 3 4 5 6 7 8 9 10];
P = feature_extra';
[m n]=size(feature_extra);
T = data_target;

[m N_test] = size(T);
Testing_Error = NaN * zeros(1,11);
%   Simulating the testing set
Sim_test = sim(net,P);% Simulation using the testing set
Result_test = find(compet(Sim_test));
Target_test = find(compet(T));
Number_of_Errors = sum(Result_test ~= Target_test)% Calculating the number of errors
Norm_Number_of_Error = Number_of_Errors / (3*N_test) % Normalizing the number of errors


nb_gesture = mod(find(compet(Sim_test)),5)



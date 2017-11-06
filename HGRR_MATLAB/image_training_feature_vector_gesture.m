clc
close all
clear all

% load total_feature_asl_1;
load total_feature_all

%input
% P = [0 1 2 3 4 5 6 7 8 9 10];
P = feature_extra';
[m n]=size(feature_extra);
T = data_target;
% T = [ones(1,256),ones(1,256),ones(1,256),ones(1,256),ones(1,256),...
%     2*ones(1,256),2*ones(1,256),2*ones(1,256),2*ones(1,256),2*ones(1,256),...
%     3*ones(1,256),3*ones(1,256),3*ones(1,256),3*ones(1,256),3*ones(1,256),...
%     4*ones(1,256),4*ones(1,256),4*ones(1,256),4*ones(1,256),4*ones(1,256),...
%     5*ones(1,256),5*ones(1,256),5*ones(1,256),5*ones(1,256),5*ones(1,256)]; %1 having sign
N_train = length(T);
input_vectors_train = P;
%   Finding the optimal number of neurons
[input_dim1 input_dim2] = size(input_vectors_train);
Training_Error = NaN * zeros(1,11);
nb_neurons = 8                                                         % loop on the number of neurons

%declare neural network
net = newff( minmax(input_vectors_train),[nb_neurons 5], {'purelin' 'purelin'}, 'traingdx');% creating the NN

init(net);  % initializing the NN
net.trainParam.epochs = 10000; % Defining the number of epochs
net.trainParam.show = 9000;
net.trainParam.goal = 1e-3;
net.trainparam.mingrad=1.0000e-018
net.trainparam.min_grad=1.0000e-018

%training started
[net tr] = train(net,input_vectors_train,T); % training the NN
%   Simulating the training set
Sim_train = sim(net,input_vectors_train); % Simulation using the training set
Result_train = find(compet(Sim_train)); 
Target_train = find(compet(T));
Number_of_errors = sum(Result_train ~= Target_train); % Calculating the number of errors
Training_Error = Number_of_errors / (3*N_train) % Normalizing the number of errors
%   Saving the designed network
save network_50epochs_gesture_lett net;

% %initialise NN
% net = newff(minmax(P),[10 1],{'tansig' 'tansig'});
% % net = newff(minmax(P),[2 1],{'logsig' 'tansig'});
% % net = newff(minmax(P),[2 1],{'tansig' 'purelin'});
% 
% % net.trainParam.epochs = 500;
% 
% net.trainparam.show=1000;
% net.trainparam.epochs=5000;
% net.trainparam.goal=.00001;
% net.trainparam.mingrad=1.0000e-018
% net.trainparam.min_grad=1.0000e-018
% 
% %training started
% net = train(net,P,T);
% 
% save network_50epochs net;
% 
% Y = sim(net,P);

clc;
close all;
%   Loading movies and creating data structure
%[M_im0 M_im1 M_im2 M_im3 M_im4 M_im5 M_im6] = read_avi_files;
%[M_im0_t M_im1_t M_im2_t M_im3_t M_im4_t M_im5_t M_im6_t] = read_avi_files_t;
%   Loading Training and Testing set
N_train = length(M_im1);
N_test  = length(M_im1_t);
data_train = create_data_struct(M_im0,M_im1,M_im2,M_im3,M_im4,M_im5,M_im6);
data_test  = create_data_struct(M_im0_t,M_im1_t,M_im2_t,M_im3_t,M_im4_t,M_im5_t,M_im6_t);
%   Preprocessing the targets
eps = 10^-4;
data_train.target = (1-eps) * data_train.target + eps * (~data_train.target);
data_test.target = (1-eps) * data_test.target + eps * (~data_test.target);
%   Preprocessing the images
[input_vectors_train,par_train] = preprocess(data_train.input);
input_vectors_test = preprocess(data_test.input,par_train);
%   Finding the optimal number of neurons
[input_dim1 input_dim2] = size(input_vectors_train);
Training_Error = NaN * zeros(1,11);
Testing_Error = NaN * zeros(1,11);
for nb_neurons = [6:2:14]                                                         % loop on the number of neurons
    net = newff( minmax(input_vectors_train),[nb_neurons 6], {'logsig' 'logsig'}, 'traingdx');% creating the NN
    init(net);  % initializing the NN
    net.trainParam.epochs = 2000; % Defining the number of epochs
    net.trainParam.show = 1000;
    net.trainParam.goal = 1e-4;
    [net tr] = train(net,input_vectors_train,data_train.target); % training the NN
    
    Sim_train = sim(net,input_vectors_train); % Simulation using the training set
    Result_train = find(compet(Sim_train)); 
    Target_train = find(compet(data_train.target));
    Number_of_errors = sum(Result_train ~= Target_train); % Calculating the number of errors
    Training_Error(nb_neurons) = Number_of_errors / (3*N_train); % Normalizing the number of errors

    Sim_test = sim(net,input_vectors_test);% Simulation using the testing set
    Result_test = find(compet(Sim_test));
    Target_test = find(compet(data_test.target));
    Number_of_errors = sum(Result_test ~= Target_test);% Calculating the number of errors
    Testing_Error(nb_neurons) = Number_of_errors / (3*N_test); % Normalizing the number of errors
end

% Plotting the results
figure(1);
hold on;
stem(Training_Error,'b','-');
stem(Testing_Error,'r',':');
title('Training and testing normalized error for different hidden layers');
legend('Testing Error','Training Error');
hold off;
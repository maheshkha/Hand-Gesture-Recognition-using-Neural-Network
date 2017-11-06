%this is main file for creating database

close all;
%   Loading movies and creating data structure
[M_im0 M_im1] = read_avi_files;
% M_im2 M_im3 M_im4 M_im5
%   Loading Training and Testing set
N_train = length(M_im1);
data_train = create_data_struct1(M_im0,M_im1);
%,M_im2,M_im3,M_im4,M_im5
%   Preprocessing the targets
eps = 10^-4;
data_train.target = (1-eps) * data_train.target + eps * (~data_train.target);
%  Preprocessing the images
[input_vectors_train,par_train] = preprocess(data_train.input);

%   Finding the optimal number of neurons
[input_dim1 input_dim2] = size(input_vectors_train);
Training_Error = NaN * zeros(1,11);
nb_neurons = 8                                                         % loop on the number of neurons
%declare neural network
net = newff( minmax(input_vectors_train),[nb_neurons 1], {'logsig' 'logsig'}, 'traingdx');% creating the NN
init(net);  % initializing the NN
net.trainParam.epochs = 2000; % Defining the number of epochs
net.trainParam.show = 1000;
net.trainParam.goal = 1e-6;

%training started
[net tr] = train(net,input_vectors_train,data_train.target); % training the NN
%   Simulating the training set
Sim_train = sim(net,input_vectors_train); % Simulation using the training set
Result_train = find(compet(Sim_train)); 
Target_train = find(compet(data_train.target));
Number_of_errors = sum(Result_train ~= Target_train); % Calculating the number of errors
Training_Error = Number_of_errors / (3*N_train); % Normalizing the number of errors
%   Saving the designed network
save('Neural_Network','net','par_train');
%   Plotting the Weight Picture
Weight_vec = net.IW(1);% Collecting the Weights
Weight_vec_t = ((Weight_vec{1,1}.^2))';% Calculating the sum of their square value
Weight_vec = Weight_vec_t(:,8);
[Weight_dim1 Weight_dim2] = size(Weight_vec); 
index_non_deg = par_train.index_non_deg;% Collecting the index of degenerated pixels
index_non_deg_dim = size(index_non_deg);
Weight_pic = zeros(30,30);% Creating the Weight picture
i=1;
jump = 0;
while( i<= Weight_dim1) % Filling the Weight Picture 
    if(sum(i~=index_non_deg) ~= index_non_deg_dim)
        Weight_pic(i+jump) = Weight_vec(i);% if regular pixel
        i = i+1;
    else
        jump = jump +1; % if degenerated pixel
        i = i+1;
    end
end
figure % Plotting the result
imagesc(Weight_pic);
colorbar;
title('Weight Picture');
figure
A = zeros(30,30);
A(index_non_deg) = 255;
imshow(A);
figure
B = zeros(30,30);
B(index_non_deg) = par_train.stdp;
B(find(B<=0.3)) = 0;
imagesc(B);
title('Value of the satandard deviation for each pixel');
colorbar;
figure
C = (B~=0);
imagesc(C);
title('Map of the weights')
%   Loading the Neural Network
load('Neural_Network.mat');
%   Loading movies and creating data structure
[M_im0_t M_im1_t M_im2_t M_im3_t M_im4_t M_im5_t ] = read_avi_files_t;
%   Loading the Testing set
N_test  = length(M_im1_t);
data_test  = create_data_struct(M_im0_t,M_im1_t,M_im2_t,M_im3_t,M_im4_t,M_im5_t);
%   Preprocessing the targets
eps = 10^-4;
data_test.target = (1-eps) * data_test.target + eps * (~data_test.target);
%  Preprocessing the images
input_vectors_test = preprocess(data_test.input,par_train);

Testing_Error = NaN * zeros(1,11);
%   Simulating the testing set
Sim_test = sim(net,input_vectors_test);% Simulation using the testing set
Result_test = find(compet(Sim_test));
Target_test = find(compet(data_test.target));
Number_of_Errors = sum(Result_test ~= Target_test)% Calculating the number of errors
Norm_Number_of_Error = Number_of_Errors / (3*N_test) % Normalizing the number of errors

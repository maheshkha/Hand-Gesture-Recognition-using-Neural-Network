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

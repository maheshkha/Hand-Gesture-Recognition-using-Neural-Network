function nb_finger = count_fingers3(image_1, image_2, re_size, fig)

% im_bg = flipud(image_1');
% im_in = flipud(image_2');
im_bg = image_1;
im_in = image_2;

im_res(:,:,1) = create_binary_pic(im_bg, im_in, re_size);
im_res(:,:,2) = create_binary_pic(im_bg, im_in, re_size);

%
load('Neural_Network_good_mahesh.mat');
% load('Neural_Network_8may_train_10_tan.mat');
% load('Neural_Network_2_goal_8.mat');
% 
input_vector = preprocess(im_res,par_train);
Sim = sim(net,input_vector);
nb_finger = mod(find(compet(Sim)),6);
imagesc(im_res(:,:,1));
title(num2str(nb_finger(1)));
pause(0.1);
if nb_finger(2) ==2
    title(num2str(nb_finger(2)));
    pause(0.1);
end
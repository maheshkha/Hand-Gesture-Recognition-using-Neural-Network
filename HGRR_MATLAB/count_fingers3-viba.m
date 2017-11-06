function nb_finger = count_fingers3(image_1, image_2, re_size, fig,Sign)

% im_bg = flipud(image_1');
% im_in = flipud(image_2');
im_bg = image_1;
im_in = image_2;

im_res(:,:,1) = create_binary_pic(im_bg, im_in, re_size);
im_res(:,:,2) = create_binary_pic(im_bg, im_in, re_size);

%
load('Neural_Network5.mat');
% 
input_vector = preprocess(im_res,par_train);
Sim = sim(net,input_vector);
nb_finger = mod(find(compet(Sim)),6);
imagesc(im_res(:,:,1));
title(num2str(Sign));
pause(0.1);

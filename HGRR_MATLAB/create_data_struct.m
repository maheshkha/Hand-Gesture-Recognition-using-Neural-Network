function data = create_data_struct(M_im0,M_im1,M_im2,M_im3,M_im4,M_im5)

% data.input  - data.input(:,:,k) is the k'th image.
% data.target - data.target(:,k) is target vector for the k'th image.
% this field is all zeros except for the element corresponding to the digit.
% data.digit  - data.digit(k) holds the digit stored in the k'th image

nb_sample = length(M_im1);
bckgnd = rgb2gray(frame2im(M_im0));
%bckgnd = im2bw(pic,graythresh(pic));
re_size = 60;

for k = 1:1:nb_sample
    %   Loading the 1-finger set of pictures
    pic = frame2im(M_im1(k));
    data.input(:,:,k) = create_binary_pic(bckgnd,pic,re_size);
    data.target(1,k) = 1;
    data.digit(k) = 1;
    %   Loading the 2-fingers set of pictures
    pic = frame2im(M_im2(k));
    data.input(:,:,k+nb_sample) = create_binary_pic(bckgnd,pic,re_size);
    data.target(2,k+nb_sample) = 1;
    data.digit(k+nb_sample) = 2;
    %   Loading the 3-fingers set of pictures
    pic = frame2im(M_im3(k));
    data.input(:,:,k+2*nb_sample) = create_binary_pic(bckgnd,pic,re_size);
    data.target(3,k+2*nb_sample) = 1;
    data.digit(k+2*nb_sample) = 3;
    %   Loading the 4-fingers set of pictures
    pic = frame2im(M_im4(k));
    data.input(:,:,k+3*nb_sample) = create_binary_pic(bckgnd,pic,re_size);
    data.target(4,k+3*nb_sample) = 1;
    data.digit(k+3*nb_sample) = 4;
    %   Loading the 5-fingers set of pictures
    pic = frame2im(M_im5(k));
    data.input(:,:,k+4*nb_sample) = create_binary_pic(bckgnd,pic,re_size);
    data.target(5,k+4*nb_sample) = 1;
    data.digit(k+4*nb_sample) = 5;
end

data.digits = [1 2 3 4 5];
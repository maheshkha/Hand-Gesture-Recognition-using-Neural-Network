clc
close all
clear all

M_im0 = aviread('im1.avi')  %   background, 1 sample
% Play the movie twenty times
% movie(M_im0); 
% imshow(M_im0.cdata);
% pic = frame2im(M_im0(1));
%  imshow(pic);
%  pic = frame2im(M_im0(1));
% figure, imshow(pic);

images = double(M_im0.cdata);

image1 = rgb2gray(M_im0.cdata);
%histogram

J = imnoise(image1,'salt & pepper',0.02);
K = medfilt2(J);
figure,
imshow(J), figure, imshow(K);
input_dim = size(M_im0.cdata);
image_dim = input_dim(1:2);
samples_count = input_dim(3);


% reduce resolution:
Ir = zeros([image_dim / 2 samples_count]);      %   size(Ir) = 14 x 28 x samples_count
K = 1/4 * [1 1;1 1];
for k = 1:1:samples_count                                       %   resizing all the images
    temp = filter2(K,images(:,:,k));                 %    filtering the whole image with h
    Ir(:,:,k) = temp(1:2:end,1:2:end);                           %    downsizing by collecting odd lines and columns
end   
figure,
imagesc(temp);
size(Ir)

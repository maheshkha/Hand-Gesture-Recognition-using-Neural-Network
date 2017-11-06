function [M_im0,M_im1] = read_avi_files 
%,M_im2,M_im3,M_im4,M_im5

M_im0 = aviread('im0.avi');  %   background, 1 sample
M_im1 = aviread('im1.avi');  %   1 finger, 50 samples
% M_im2 = aviread('im2.avi');  %   2 finger, 50 samples
% M_im3 = aviread('im3.avi');  %   3 finger, 50 samples
% M_im4 = aviread('im4.avi');  %   4 finger, 50 samples
% M_im5 = aviread('im5.avi');  %   5 finger, 50 samples
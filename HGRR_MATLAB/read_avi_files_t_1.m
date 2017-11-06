function [M_im0_t,M_im1_t] = read_avi_files_t_1
% ,M_im2_t,M_im3_t,M_im4_t,M_im5_t

M_im0_t = aviread('im0_t.avi');  %   background, 1 sample
M_im1_t = aviread('im1_t.avi');  %   1 finger, 50 samples
% M_im2_t = aviread('im2_t.avi');  %   2 finger, 50 samples
% M_im3_t = aviread('im3_t.avi');  %   3 finger, 50 samples
% M_im4_t = aviread('im4_t.avi');  %   4 finger, 50 samples
% M_im5_t = aviread('im5_t.avi');  %   5 finger, 50 samples

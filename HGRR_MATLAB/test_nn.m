clc
close all
clear all
P = [0 1 2 3 4 0 1 2 3 4];
% P = [10 9 8 7 6 5 4 3 2 1 0];

load network_50epochs;

Y = sim(net,P);
figure,
plot(P,Y)
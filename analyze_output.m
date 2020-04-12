clear all;
close all;
clc;

A = readmatrix('gain_3000_150.csv');
hold on;
plot(((1:1:2570)*40)/1e3,A(:,1))

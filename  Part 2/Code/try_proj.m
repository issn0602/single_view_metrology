clc; clear all; close all;

%s = rng;

%% get the start_points and end_points of each straight line use LSD.
% note: input parameter is the path of image, use '/' as file separator.
lines = lsd('./images/Taj_Mahal.jpeg');

no_of_points = size(lines,2);
e1 = ones(no_of_points,3); e2 = ones(no_of_points,3);
e1(:,1) = lines(1,:);
e1(:,2) = lines(2,:);
e2(:,1) = lines(3,:);
e2(:,2) = lines(4,:);

A = cross(e1,e2);

load('params.mat');


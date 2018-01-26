clc; clear all; close all;


% lsd_example.m
% Test LSD algorithm with MATLAB
%% show the image.
im = imread('./images/Taj_Mahal.jpeg');
imshow(im);
%% get the start_points and end_points of each straight line use LSD.
% note: input parameter is the path of image, use '/' as file separator.
lines = lsd('./images/Taj_Mahal.jpeg');
%% plot the lines.
hold on;
for i = 1:size(lines, 2)
    plot(lines(1:2, i), lines(3:4, i), 'LineWidth', lines(5, i) / 2, 'Color', [1, 0, 0]);
end

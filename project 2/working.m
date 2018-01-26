clc; clear all; close all;

s = rng;
%% read image
im=imread('./images/Tea.jpg');

% %% get clusters of lines
% commandStr = 'python GenLineCluster.py';
%  [status, commandOut] = system(commandStr);

%% Load parameters
load('paramstea.mat'); %tajmahal
axes=axes';
origin = origin';
axes_length = axes_length';

%% line comp
linesx = get_lines('lines_x.csv');
linesy = get_lines('lines_y.csv');
linesz = get_lines('lines_z.csv');
p1 = [linesx(:,1) linesx(:,2) ones(size(linesx,1),1)];
p2 = [linesx(:,3) linesx(:,4) ones(size(linesx,1),1)];
infinite_lines_x = real(cross(p1,p2));


p1 = [linesy(:,1) linesy(:,2) ones(size(linesy,1),1)];
p2 = [linesy(:,3) linesy(:,4) ones(size(linesy,1),1)];
infinite_lines_y = real(cross(p1,p2));


p1 = [linesz(:,1) linesz(:,2) ones(size(linesz,1),1)];
p2 = [linesz(:,3) linesz(:,4) ones(size(linesz,1),1)];
infinite_lines_z = real(cross(p1,p2));

%% Ransac for orthogonality
vp_x = ransac(infinite_lines_x);
vp_y = ransac(infinite_lines_y);
vp_z = ransac(infinite_lines_z);
vp=[vp_x;vp_y;vp_z];
vp = vp./vp(:,3);

%% rem
vp=vp';
axes=axes';
origin=origin';
a_x = ( vp(:,1) \ (axes(:,1)-origin ) ) / axes_length(1);
a_y = ( vp(:,2) \ (axes(:,2)-origin ) ) / axes_length(2);
a_z = ( vp(:,3) \ (axes(:,3)-origin ) ) / axes_length(3);

P = [vp(:,1)*a_x vp(:,2)*a_y vp(:,3)*a_z origin ];

Hxy=projective2d(P(:,[1,2,4])'); 
Hyz=projective2d(P(:,[2,3,4])'); 
Hxz=projective2d(P(:,[1,3,4])'); 
Hxyinvt=invert(Hxy); 
Hyzinvt=invert(Hyz); 
Hxzinvt=invert(Hxz);

I = imread('./images/Tea.jpg');

imx = imwarp(I,Hxyinvt); 
imy = imwarp(I,Hyzinvt); 
imz = imwarp(I,Hxzinvt);  
figure(1)  
imshow(imx); 
figure(2)
imshow(imy); 
figure(3)
imshow(imz);
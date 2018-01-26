
clc; clear all; close all;

%s = rng;

%% get the start_points and end_points of each straight line use LSD.
% note: input parameter is the path of image, use '/' as file separator.
lines = lsd('./images/Taj_Mahal.jpeg');

no_of_points = size(lines,2);
e1 = ones(no_of_points,3); e2 = ones(no_of_points,3);
e1(:,1) = lines(1,:); e1(:,2) = lines(2,:);
e2(:,1) = lines(3,:); e2(:,2) = lines(4,:);

A = cross(e1,e2);

no_of_lines = size(A,1);
B = A./A(:,3);

% nr = randperm(size(B,1));
% vp = zeros(10,3);
% v = zeros(1,10);
% for i=1:10
%     
%     temp = B(nr((i-1)*48+1:i*48),:);
%     M = zeros(3,3);
%     for j=1:48
%         M(1,1) = M(1,1) + temp(j,1)*temp(j,1); M(1,2) = M(1,2) + temp(j,1)*temp(j,2); M(1,3) = M(1,3) + temp(j,1)*temp(i,3);
%         M(2,1) = M(2,1) + temp(j,1)*temp(j,2); M(2,2) = M(2,2) + temp(j,2)*temp(j,2); M(2,3) = M(2,3) + temp(j,2)*temp(i,3);
%         M(3,1) = M(3,1) + temp(j,1)*temp(j,3); M(3,2) = M(3,2) + temp(j,2)*temp(j,3); M(3,3) = M(3,3) + temp(j,3)*temp(i,3);
%     end
%     
%     [L,V] = eig(M);
%     new_v = sum(V,2); [v(i),I] = min(new_v);
%     vp(i,:) = L(I,:);
%     
% end

vp = zeros(size(B,1)*(size(B,1)-1)/2,3);
count = zeros(size(B,1)*(size(B,1)-1)/2,1);
val = 1;

for i=1:(size(B,1)-1)
    
    for j=(i+1):size(B,1)
        
        l_1 = B(i,:); l_2 = B(j,:);
        vp(val,:) = cross(l_1,l_2);
                        
        for k=1:size(B,1)
            
            if ( (k~=i) && (k~=j) )
                
                temp = cross(vp(val,:),B(k,:));
                disp(sum(temp));
                if sum(temp) <= 1e-3
                    count(val) = count(val)+1;
                end
                
            end
            
        end
        
        val = val+1;
        
    end
    
end

[~,I] = sort(v);
new_V = vp(I,:);
van_pts = new_V(1:3,:);
van_pts = van_pts ./ van_pts(:,3);
vp = van_pts;

load('params.mat');

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

I = imread('./images/Taj_Mahal.jpeg');

imx = imwarp(I,Hxyinvt); 
imy = imwarp(I,Hyzinvt); 
imz = imwarp(I,Hxzinvt);  
figure(1)  
imshow(imx); 
figure(2)
imshow(imy); 
figure(3)
imshow(imz);

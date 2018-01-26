function van_pt = ransac(B)

M = zeros(3,3);
for j=1:size(B,1)
    M(1,1) = M(1,1) + B(j,1)*B(j,1); M(1,2) = M(1,2) + B(j,1)*B(j,2); M(1,3) = M(1,3) + B(j,1)*B(i,3);
    M(2,1) = M(2,1) + B(j,1)*B(j,2); M(2,2) = M(2,2) + B(j,2)*B(j,2); M(2,3) = M(2,3) + B(j,2)*B(i,3);
    M(3,1) = M(3,1) + B(j,1)*B(j,3); M(3,2) = M(3,2) + B(j,2)*B(j,3); M(3,3) = M(3,3) + B(j,3)*B(i,3);
end

[L,V] = eig(M);
new_v = sum(V,2);
[~,I] = min(new_v);
van_pt = L(I,:);

end
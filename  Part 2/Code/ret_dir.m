function dir = ret_dir(B,axes)

    dir = zeros(size(B,1),1);

    for i=size(B,1)
        
        temp_1 = acosd(dot(B(i,:),axes(1,:))/(norm(B(i,:))*norm(axes(1,:))));
        temp_2 = acosd(dot(B(i,:),axes(2,:))/(norm(B(i,:))*norm(axes(2,:))));
        temp_3 = acosd(dot(B(i,:),axes(3,:))/(norm(B(i,:))*norm(axes(3,:))));
        
        [~,dir(i)] = min([temp_1,temp_2,temp_3]);
        
    end

end
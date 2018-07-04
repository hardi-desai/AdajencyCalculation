

clc;
clear all;

%Provinding Input Parameters
img_seg = [ 0 5 0 1 ; 0 1 1 3; 1 0 2 4; 1 1 2 5 ]; % Image segment with multiple pixel values
set_V = [0,1];  % Pixel values which could be considered
p_location = [4,1]; %Starting pixel position
q_location = [1,4]; %Ending pixel position
path_type = '8'; %Path type - could be '4','8' or 'm'

%Checking p and q locations
if p_location(1) >= size(img_seg,1) && p_location(2) >= size(img_seg,2) 
     error('Please check location of p. No pixel found at location p in image segment.')
end

if q_location(1) >= size(img_seg,1) && q_location(2) >= size(img_seg,2)
     error('Please check location of q. No pixel found at location q in image segment.')
end

%Finding indexes of pixels values in V
row_fin = [];
col_fin = [];
for index=1:length(set_V)
    [row,col]=find(img_seg == set_V(index));
    row_fin = [row_fin;row]; 
    col_fin = [col_fin;col];
end

%Making binary image with 1's at pixel location at V
bin_image = zeros(size(img_seg));
for i=1:size(img_seg,1)
    for j=1:size(img_seg,2)
        for k=1:length(row_fin)
            if row_fin(k)==i && col_fin(k)== j
                bin_image(i,j)=1;
            end
        end
    end
end


my_stack = [p_location(1) p_location(2)];
my_stack_length = [0] ;
location_iterator = [p_location(1) p_location(2)];
i = 1;

%Calulating length for 4 adjacency
if path_type == '4'
    while any(location_iterator ~= [q_location(1) q_location(2)])

        location_check = location_iterator;
        [~,index] = ismember(location_check,my_stack,'rows');
        if location_check(1)+1<= size(bin_image,1) && bin_image(location_check(1)+1,location_check(2)) == 1 && ~any(ismember([location_check(1)+1 location_check(2)],my_stack,'rows'))
            my_stack =[ my_stack ;[location_check(1)+1 location_check(2)]];          
            my_stack_length = [ my_stack_length; i];

        end

        if location_check(1)-1 > 0 && bin_image(location_check(1)-1,location_check(2)) == 1 && ~any(ismember([location_check(1)-1 location_check(2)],my_stack,'rows'))
            my_stack =[ my_stack ;[location_check(1)-1 location_check(2)] ];
            my_stack_length = [ my_stack_length;i];
           
        end


        if location_check(2)+1<= size(bin_image,2) && bin_image(location_check(1),location_check(2)+1) == 1 && ~any(ismember([location_check(1) location_check(2)+1],my_stack,'rows'))
            my_stack =[ my_stack ;[location_check(1) location_check(2)+1]];
            my_stack_length = [ my_stack_length;i];   
           
        end

        if location_check(2)-1>0 && bin_image(location_check(1),location_check(2)-1) == 1 && ~any(ismember([location_check(1) location_check(2)-1],my_stack,'rows'))
            my_stack  =[ my_stack ;[location_check(1) location_check(2)-1]];
            my_stack_length = [ my_stack_length;i];
           
        end

        [~,index] = ismember(location_check,my_stack,'rows');
        length(my_stack)
        if length(my_stack)>= index+1
            location_iterator = my_stack(index+1,:);
            i = my_stack_length(index+1) +1;
        else
            break;
        end
    end
%Calulating length for 8 adjacency
elseif path_type == '8'
    while any(location_iterator ~= [q_location(1) q_location(2)])

        location_check = location_iterator;
        [~,index] = ismember(location_check,my_stack,'rows');
        if location_check(1)+1<= size(bin_image,1) && bin_image(location_check(1)+1,location_check(2)) == 1 && ~any(ismember([location_check(1)+1 location_check(2)],my_stack,'rows'))
            my_stack =[ my_stack ;[location_check(1)+1 location_check(2)]];
            my_stack_length = [ my_stack_length; i];
        end
        if location_check(1)-1 > 0 && bin_image(location_check(1)-1,location_check(2)) == 1 && ~any(ismember([location_check(1)-1 location_check(2)],my_stack,'rows'))
            my_stack =[ my_stack ;[location_check(1)-1 location_check(2)] ];
            my_stack_length = [ my_stack_length;i];    
        end
        if location_check(2)+1<= size(bin_image,2) && bin_image(location_check(1),location_check(2)+1) == 1 && ~any(ismember([location_check(1) location_check(2)+1],my_stack,'rows'))
            my_stack =[ my_stack ;[location_check(1) location_check(2)+1]];
            my_stack_length = [ my_stack_length;i];   
        end
        if location_check(2)-1>0 && bin_image(location_check(1),location_check(2)-1) == 1 && ~any(ismember([location_check(1) location_check(2)-1],my_stack,'rows'))
            my_stack  =[ my_stack ;[location_check(1) location_check(2)-1]];
            my_stack_length = [ my_stack_length;i];
        end
        if location_check(1)+1 <= size(bin_image,1) && location_check(2)+1 <= size(bin_image,2) && bin_image(location_check(1)+1,location_check(2)+1) == 1 && ~any(ismember([location_check(1)+1 location_check(2)+1],my_stack,'rows'))
            my_stack  =[ my_stack ;[location_check(1)+1 location_check(2)+1]];
            my_stack_length = [ my_stack_length;i];
        end
        if location_check(1)-1 > 0 && location_check(2)-1 >0 && bin_image(location_check(1)-1,location_check(2)-1) == 1 && ~any(ismember([location_check(1)-1 location_check(2)-1],my_stack,'rows'))
            my_stack  =[ my_stack ;[location_check(1)-1 location_check(2)-1]];
            my_stack_length = [ my_stack_length;i];
        end
        if location_check(1)+1 <= size(bin_image,1) && location_check(2)-1 >0 && bin_image(location_check(1)+1,location_check(2)-1) == 1 && ~any(ismember([location_check(1)+1 location_check(2)-1],my_stack,'rows'))
            my_stack  =[ my_stack ;[location_check(1)+1 location_check(2)-1]];
            my_stack_length = [ my_stack_length;i];
        end
        if location_check(1)-1 >0 && location_check(2)+1 <= size(bin_image,2) && bin_image(location_check(1)-1,location_check(2)+1) == 1 && ~any(ismember([location_check(1)-1 location_check(2)+1],my_stack,'rows'))
            my_stack  =[ my_stack ;[location_check(1)-1 location_check(2)+1]];
            my_stack_length = [ my_stack_length;i];
        end
        [~,index] = ismember(location_check,my_stack,'rows');
        if length(my_stack)>= index+1
            location_iterator = my_stack(index+1,:);
            i = my_stack_length(index+1) +1;
        else
            break;
        end
    end
    
%Calulating length for m adjacency    
elseif path_type == 'm'
    while any(location_iterator ~= [q_location(1) q_location(2)])
        location_check = location_iterator;
        [~,index] = ismember(location_check,my_stack,'rows');
        p = 0;
        if location_check(1)+1<= size(bin_image,1) && bin_image(location_check(1)+1,location_check(2)) == 1 && ~any(ismember([location_check(1)+1 location_check(2)],my_stack,'rows'))
            my_stack =[ my_stack ;[location_check(1)+1 location_check(2)]];
            my_stack_length = [ my_stack_length; i];
            p = 1;
        end
        if location_check(1)-1 > 0 && bin_image(location_check(1)-1,location_check(2)) == 1 && ~any(ismember([location_check(1)-1 location_check(2)],my_stack,'rows'))
            my_stack =[ my_stack ;[location_check(1)-1 location_check(2)] ];
            my_stack_length = [ my_stack_length;i];    
            p = 1;
        end
        if location_check(2)+1<= size(bin_image,2) && bin_image(location_check(1),location_check(2)+1) == 1 && ~any(ismember([location_check(1) location_check(2)+1],my_stack,'rows'))
            my_stack =[ my_stack ;[location_check(1) location_check(2)+1]];
            my_stack_length = [ my_stack_length;i];  
            p = 1;
        end
        if location_check(2)-1>0 && bin_image(location_check(1),location_check(2)-1) == 1 && ~any(ismember([location_check(1) location_check(2)-1],my_stack,'rows'))
            my_stack  =[ my_stack ;[location_check(1) location_check(2)-1]];
            my_stack_length = [ my_stack_length;i];
            p = 1;
        end
        if p == 0
            if location_check(1)+1 <= size(bin_image,1) && location_check(2)+1 <= size(bin_image,2) && bin_image(location_check(1)+1,location_check(2)+1) == 1 && ~any(ismember([location_check(1)+1 location_check(2)+1],my_stack,'rows'))
                my_stack  =[ my_stack ;[location_check(1)+1 location_check(2)+1]];
                my_stack_length = [ my_stack_length;i];
            end
            if location_check(1)-1 > 0 && location_check(2)-1 >0 && bin_image(location_check(1)-1,location_check(2)-1) == 1 && ~any(ismember([location_check(1)-1 location_check(2)-1],my_stack,'rows'))
                my_stack  =[ my_stack ;[location_check(1)-1 location_check(2)-1]];
                my_stack_length = [ my_stack_length;i];
            end
            if location_check(1)+1 <= size(bin_image,1) && location_check(2)-1 >0 && bin_image(location_check(1)+1,location_check(2)-1) == 1 && ~any(ismember([location_check(1)+1 location_check(2)-1],my_stack,'rows'))
                my_stack  =[ my_stack ;[location_check(1)+1 location_check(2)-1]];
                my_stack_length = [ my_stack_length;i];
            end
            if location_check(1)-1 >0 && location_check(2)+1 <= size(bin_image,2) && bin_image(location_check(1)-1,location_check(2)+1) == 1 && ~any(ismember([location_check(1)-1 location_check(2)+1],my_stack,'rows'))
                my_stack  =[ my_stack ;[location_check(1)-1 location_check(2)+1]];
                my_stack_length = [ my_stack_length;i];
            end
        end
        if length(my_stack)>= index+1
            location_iterator = my_stack(index+1,:);
            i = my_stack_length(index+1) +1;
        else
            break;
        end
    end
end
path_found = 0;
for d=1:length(my_stack)
      if my_stack(d,1)== q_location(1) && my_stack(d,2)== q_location(2)
          path_found = 1;
          break;
      end
end
if(path_found)
    length = my_stack_length(d)    
else
    disp('Path not found, Can not calculate length');
end
function im_out  = zoom_in(im_bw)

[nb_line nb_col] = size(im_bw);
sum_line = sum(im_bw')';
sum_col = sum(im_bw);
%===== Finding y_min =====
if min(sum_line) == 0
    y_min = min(find(sum_line ~= 0));
else
    y_min = 1;
end
%===== Finding x_min =====
lap = [-1 1]';
im_temp = zeros(nb_line+2,nb_col);
im_temp(2:end-1,:) = im_bw;
edge = conv2(im_temp,lap,'same');
nb_edges = sum(abs(edge));
col = min(find(sum_col == max(sum_col)));
left = 0;
right = 0;
flag = 0;
count = 0;
while left*right == 0
    if (nb_edges(col)==2)
        col = col+1;
        right = 1;
    end
    if (nb_edges(col)>2)
        col = col-1;
        left = 1;
    end
    if col == 0
        break
    end
    if count > 2*nb_col
        im_out = 0;
        return
    end
    count = count + 1;
end
x_min = max([col 1]);

%===== Finding x_max =====
sc = sum_col(x_min:nb_col);
if min(sc) == 0
    x_max = min(find(sc == 0))-1+x_min;
else
    x_max = nb_col;
end

%===== Finding y_max =====
sum_line = sum(im_bw(:, x_min:x_max)')';
y_max = max(find(sum_line ~= 0));   

%===== Collecting the releavant picture =====
s1 = x_max-x_min;
s2 = y_max-y_min;
if s1 > 2/3*s2
    im_out = im_bw(y_min:y_max, x_min:x_max);
else
%    length = 2.5 * s1; 
    length = 2*s1;
    im_out = zeros(s2+1,length);
    im_out(:,1:s1+1) = im_bw(y_min:y_max, x_min:x_max);
end
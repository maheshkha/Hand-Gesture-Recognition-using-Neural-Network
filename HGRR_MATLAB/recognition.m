function nb_finger = recognition(image_1,image_2)

    im_bg = image_1;
    im_in = image_2;
re_size=60;
nb_finger = eval('count_fingers1(image_1,image_2,30,0)','9');
if nb_finger == 9;
%     im_bg = double(flipud(image_1'));
%     im_in = double(flipud(image_2'));
    diff = abs(im_in-im_bg);          % difference between the picture and its background
    diff_sum= double(diff);
    im_bw = zeros(size(im_in));         % creating a binary picture for each color
    im_bw(find(diff_sum > 20)) = 1;                                                 % filling the binary pictures
    im_bw = bwmorph(im_bw,'open');              % erosion eliminates isolated points
    im_res = eval('zoom_in(im_bw)','0');                        % collecting the releavant picture
    im_res = imresize(im_res,[re_size re_size]); 
    imshow(im_res);
    pause;
end
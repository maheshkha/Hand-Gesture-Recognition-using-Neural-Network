function nb_finger = count_fingers1(image_1, image_2, re_size)

im_bg = image_1;
im_in =rgb2gray( image_2);
% When calling Matlab from C++, use the two next lines  given that the 
% orientation of the picture is not the same when using AsusLive and VideoOCX
% im_bg = double(flipud(image_1')); 
% im_in = double(flipud(image_2')); 

diff = imabsdiff(im_in,im_bg);          % difference between the picture and its background
diff_sum= double(diff);
if length(size(diff_sum))==3            % case of RGB pictures
    im_bw = zeros(size(im_in(:,:,1)));  % creating a binary picture for each color
    diff_sum = sum(diff_sum,3);
else                                    % case of gray pictures
    im_bw = zeros(size(im_in));         % creating a binary picture for each color
end
im_bw(find(diff_sum > 20)) = 1;         % filling the binary pictures                                         
im_bw = bwmorph(im_bw,'open');          % erosion eliminates isolated points
im_res = eval('zoom_in(im_bw)','0');                        % collecting the releavant picture
im_res = double(imresize(im_res,[re_size re_size]));        % downsizing this picture
%   
%    Detecting the fingers
%    =====================
%wa=sum(column 15-25)[(no.of edges(column)*[line 1-30]pixel(line,column)]
im_der = abs([im_res; zeros(1,re_size)]-[zeros(1,re_size); im_res]); % Creating the edges
im_sum = ones(re_size,1) * sum(im_der); % im_sum[i,j] = number of edges in the j-th column
im_wei = double(im_res).*im_sum;        % Creating the weights
wa = sum(sum(im_wei(:,15:25)));         % calculating the weighted average
nb_finger = 6;                          % Initializing the number of finger to an incoherent value
if wa > 900
    nb_finger = 5;end                   % finding the correct range
if wa <= 900                            % and guessing the number of fingers
    nb_finger = 4;end
if wa <= 500
    nb_finger = 3;end
if wa <= 200
    nb_finger = 2;end
if wa <= 40
    if sum(sum(im_wei) > 20)
        nb_finger = 1;    else
        nb_finger = 0;    end
end

function im_out = create_binary_pic(im_bg, im_in, re_size)

diff = double(imabsdiff(rgb2gray(im_in),im_bg));%
im_bw = zeros(size(im_in(:,:,1)));
im_bw(find(diff > 20)) = 1;
im_bw = bwmorph(im_bw,'open');
eval('im_res = zoom_in(im_bw)','im_res = 0');
%im_res = zoom_in(im_bw);
im_out = imresize(im_res,[re_size re_size]);

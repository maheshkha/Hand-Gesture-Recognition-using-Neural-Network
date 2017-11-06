function [input_vectors,par] = preprocess(images,par)

% preprocess input images.
%
% usage:
% 1.   input_vectors = preprocess(images,par)
%   convert images to input_vectors using parameters stored in par.
%
% 2.   [input_vectors,par] = preprocess(images)
%   convert images to input_vectors and create the parameters structure
%   "par" based on the data.
%
% images  - images(:,:,k) is the k'th image.
% input_vectors = input_vectors(:,k) is the coded k'th image.


par_provided = (nargin>=2);

input_dim = size(images);
image_dim = input_dim(1:2);
samples_count = input_dim(3);

% reduce resolution:
Ir = zeros([image_dim / 2 samples_count]);      %   size(Ir) = 14 x 28 x samples_count
K = 1/4 * [1 1;1 1];
for k = 1:1:samples_count                                       %   resizing all the images
    temp = filter2(K,images(:,:,k));                 %    filtering the whole image with h
    Ir(:,:,k) = temp(1:2:end,1:2:end);                           %    downsizing by collecting odd lines and columns
end   

% order images as vectors:
Ir_vectors = reshape(Ir,[image_dim(1)*image_dim(2) / 4, samples_count]);%creating the set of vectors
[Ir_vec1 Ir_vec2] = size(Ir_vectors);

% remove degenerated input elements:
if par_provided,
    Ir_releavant = Ir_vectors(par.index_non_deg,:);
else
    par.index_non_deg = find(std(Ir_vectors')'~=0);
    Ir_releavant = Ir_vectors(par.index_non_deg,:);
end

% * normalize input% 
if par_provided,
    [Ir_releavant] = poststd(Ir_releavant,par.meanp,par.stdp);
    [input_vectors, par.meanp, par.stdp] = prestd(Ir_releavant);  
else%
    [input_vectors, par.meanp, par.stdp] = prestd(Ir_releavant);  
end%

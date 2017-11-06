clc
close all
clear all

feature_extraction = [];
feature_extra = [];

k=1;
j1=1;
j2=1;
for j=65:69
    for i=1:5
        disp(['Reading :' num2str(char(j)) num2str(i) '.jpg']);
        RGB = imread([num2str(char(j)) num2str(i) '.jpg']);
        img_crop = RGB;
        I  = rgb2gray(RGB); % convert to intensity
        I = imresize(I,[80 64],'bicubic');
        imshow(I);
%         bw2 = edu_imgcrop(I);        
%         figure,imshow(bw2);
        
        Hi=imhist(I);
%         figure,plot(Hi);
%         imgGray = I;
%         bw = im2bw(img_crop,graythresh(imgGray));
%         bw2 = edu_imgcrop(bw);        
%         figure,imshow(bw2);
         
        BW = edge(I,'canny',0.25); % extract edges
%         [H,T,R] = hough(BW,'RhoResolution',1,'ThetaResolution',1);
        [H,T,R] = hough(BW);
      [imx,imy]=size(BW);
    msk=[0 0 0 0 0;
         0 1 1 1 0;
         0 1 1 1 0;
         0 1 1 1 0;
         0 0 0 0 0;];
    B=conv2(double(BW),double(msk)); %Smoothing  image to reduce the number of connected components
    bw_7050=imresize(B,[70,50]);
    for cnt=1:7
        for cnt2=1:5
            Atemp=sum(bw_7050((cnt*10-9:cnt*10),(cnt2*10-9:cnt2*10)));
            lett((cnt-1)*5+cnt2)=sum(Atemp);
        end
    end

    lett=((100-lett)/100);
    lett=lett;

    %     % display the original image
    %     figure,subplot(2,1,1);
    %     imshow(RGB);
    %     title(['a' num2str(i) '.bmp']);
    % 
    %     % display the hough matrix
    %     subplot(2,1,2);
    %     imshow(imadjust(mat2gray(H)),'XData',T,'YData',R,...
    %       'InitialMagnification','fit');
    %     title('Hough transform of gantrycrane.png');
    %     xlabel('\theta'), ylabel('\rho');
    %     axis on, axis normal, hold on;
    %     colormap(hot);
%         feature = [Hi' T R];
%         feature = [Hi'];
            feature = [lett];
        feature_extraction(k,:) = feature;
        feature_extra = [feature_extra; feature];
        data_target(j1,j2) = 1;
        j2 = j2+1;
        k = k+1;
    end
%         j2 = j2+1;
        j1 = j1+1;
end

% feature stored in file
% save total_feature_asl_1 feature_extraction
save total_feature_all feature_extra data_target
disp('Feature Extraction competed')
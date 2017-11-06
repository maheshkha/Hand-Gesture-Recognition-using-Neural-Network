clc
close all
clear all

% useVideo:  1 for recording video and 0 otherwise
useVideo =1;
nBlocks = 100;

% OPEN VIDEO INPUT:
if (useVideo==1)
    vid = videoinput('winvideo', 1);
    set(vid,'FramesPerTrigger',1);
    set(vid,'TriggerRepeat',Inf);
    triggerconfig(vid, 'Manual');
    start(vid);
end

for (i=1:nBlocks)
    % trigger video:
    if (useVideo==1) 
        trigger(vid); 
    end
       if (useVideo==1)
        IM = (getdata(vid,1,'uint8'));
        IMGray = rgb2gray(IM);
    end
    
    if (useVideo==1)
        if (i==1) IM_PREV = IMGray; end % previous video frame
    end            
        
        if (useVideo==1)        
            subplot(2,4,5);imshow(IM); title('Current Frame')

            IM_DIFF = abs(double(IMGray) - double(IM_PREV)); 
            subplot(2,4,6);imshow(IM_DIFF / 256); title('Motion');
            IM_DIFF_PLOT_VIDEO = zeros(100,2);
            Differences(i) = mean(mean(IM_DIFF));
            if (Differences(i)<100)
                IM_DIFF_PLOT_VIDEO(end-Differences(i):end,:) = 1;
            else
                IM_DIFF_PLOT_VIDEO(1:end,:) = 1;
            end
            subplot(2,4,8); imshow(IM_DIFF_PLOT_VIDEO,[]);  
            drawnow;
        end    

    if (useVideo==1)
        IM_PREV = IMGray; % keep previous frame
    end

end    
if (useVideo==1)
    stop(vid);
end
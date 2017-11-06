clc
close all
clear all

obj = videoinput('winvideo', 1);

set(obj, 'SelectedSourceName', 'input1');

src_obj = getselectedsource(obj);
get(src_obj)

preview(obj);

for i=1:25,
    frame = getsnapshot(obj);
    frame1(i,:,:,:)=frame;
    image(frame);
end
save camera_cap frame1
delete(obj);
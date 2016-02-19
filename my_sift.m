adr='/media/New Volume/pcl_paper/HumanGrpah/Vahid Kazemi/RFPoseEstimation-master/dataset/FOOTBALL5907m/';
new_sift=[];
for num=1:5907
    num
    if mod(num,2)
        adrs=strcat(adr,sprintf('%05d',num),'_m.jpg');
    else
        adrs=strcat(adr,sprintf('%05d',num),'.jpg');
    end
    im=imread(adrs);
    im=double(im);
    adrs=strcat(adr,'labels.mat');
    load(adrs)
    pts=ptsAll(:,:,num);
    patchSize = params.patchSize;
    coords =[31,31];
    [sift_arr, Z] = extract_sift(img, pts, params);
    new_sift=[sift_arr;new_sift];
end
function [ image_feat ] = vgg_resize(featname)

%filepath='/home/hpc/Ershadi/normal_vgg_features/';
%filepath='/home/ce-ipl/normal_vgg_features/';
filepath='/home/ce-ipl/vgg_features/';
% sprintf('%05d',num);

matfile_address= strcat(filepath,featname);
b=load(matfile_address);


a.conv1=imresize(single(b.conv1),[266 266],'bilinear');
a.conv2=imresize(single(b.conv2),[266 266],'bilinear');
a.conv3=imresize(single(b.conv3),[266 266],'bilinear');
a.conv4=imresize(single(b.conv4),[266 266],'bilinear');
a.conv5=imresize(single(b.conv5),[266 266],'bilinear');

% a.conv1=imResample(single(b.conv1),[266 266],'bilinear');
% a.conv1=imResample(single(b.conv1),[266 266],'bilinear');
% a.conv2=imResample(single(b.conv2),[266 266],'bilinear');
% a.conv3=imResample(single(b.conv3),[266 266],'bilinear');
% a.conv4=imResample(single(b.conv4),[266 266],'bilinear');
% a.conv5=imResample(single(b.conv5),[266 266],'bilinear');


image_feat=cat(3, a.conv1, a.conv2, a.conv3, a.conv4, a.conv5);
%image_feat=cat(3, a.conv1, a.conv2); %, a.conv3, a.conv4, a.conv5);
end


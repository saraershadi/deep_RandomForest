function vgg_allDeep_norm(num , str)

filepath='/home/hpc/Ershadi/vgg_features/';
sprintf('%05d',num);
matfile_address= strcat(filepath,sprintf('%05d',num),str);


b=load(matfile_address);
% 
% b.conv1=permute(a.conv1,[2 3 1]);
% b.conv2=permute(a.conv2,[2 3 1]);
% b.conv3=permute(a.conv3,[2 3 1]);
% b.conv4=permute(a.conv4,[2 3 1]);
% b.conv5=permute(a.conv5,[2 3 1]);

% 
% b.conv1=imResample(single(b.conv1),[266 266],'bilinear');
% b.conv2=imResample(single(b.conv2),[266 266],'bilinear');
% b.conv3=imResample(single(b.conv3),[266 266],'bilinear');
% b.conv4=imResample(single(b.conv4),[266 266],'bilinear');
% b.conv5=imResample(single(b.conv5),[266 266],'bilinear');
for i=1:size(b.conv1,3)
% b.conv1(:,:,i)=(b.conv1(:,:,i) - min(min(b.conv1(:,:,i))) )/( max(max(b.conv1(:,:,i)))-min(min(b.conv1(:,:,i)))) ;
b.conv1(:,:,i)=(b.conv1(:,:,i)-mean(mean(b.conv1(:,:,i))) )/ max(max(abs((b.conv1(:,:,i)-mean(mean(b.conv1(:,:,i))) ))));


end

for i=1:size(b.conv2,3)
% b.conv2(:,:,i)=(b.conv2(:,:,i) - min(min(b.conv2(:,:,i))) )/( max(max(b.conv2(:,:,i)))-min(min(b.conv2(:,:,i)))) ;
b.conv2(:,:,i)=(b.conv2(:,:,i)-mean(mean(b.conv2(:,:,i))) )/ max(max(abs((b.conv2(:,:,i)-mean(mean(b.conv2(:,:,i))) ))));

end

for i=1:size(b.conv3,3)
% b.conv3(:,:,i)=(b.conv3(:,:,i) - min(min(b.conv3(:,:,i))) )/( max(max(b.conv3(:,:,i)))-min(min(b.conv3(:,:,i)))) ;
b.conv3(:,:,i)=(b.conv3(:,:,i)-mean(mean(b.conv3(:,:,i))) )/ max(max(abs((b.conv3(:,:,i)-mean(mean(b.conv3(:,:,i))) ))));

end

for i=1:size(b.conv4,3)
% b.conv4(:,:,i)=(b.conv4(:,:,i) - min(min(b.conv4(:,:,i))) )/( max(max(b.conv4(:,:,i)))-min(min(b.conv4(:,:,i)))) ;
b.conv4(:,:,i)=(b.conv4(:,:,i)-mean(mean(b.conv4(:,:,i))) )/ max(max(abs((b.conv4(:,:,i)-mean(mean(b.conv4(:,:,i))) ))));

end

for i=1:size(b.conv5,3)
% b.conv5(:,:,i)=(b.conv5(:,:,i) - min(min(b.conv5(:,:,i))) )/( max(max(b.conv5(:,:,i)))-min(min(b.conv5(:,:,i)))) ;
b.conv5(:,:,i)=(b.conv5(:,:,i)-mean(mean(b.conv5(:,:,i))) )/ max(max(abs((b.conv5(:,:,i)-mean(mean(b.conv5(:,:,i))) ))));

end


filepath_save='/home/hpc/Ershadi/normal_vgg_features/';
sprintf('%05d',num);
matfile_address= strcat(filepath_save,sprintf('%05d',num),str);
save (matfile_address,'b');


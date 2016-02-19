function afshin_normalizeDeep(num , str)

% global meanx maxx

filepath='/home/hpc/Ershadi/vgg_features/';
sprintf('%05d',num);
matfile_address= strcat(filepath,sprintf('%05d',num),str);

b=load(matfile_address);
convs = {b.conv1, b.conv2, b.conv3, b.conv4, b.conv5};

temp = [];
for i=1:length(convs)
    conv = convs{i};
    temp = [temp;conv(:)];
end

nv = max(abs(temp-mean(temp)));
mx = max(temp);
mn = mean(temp);

for i=1:length(convs)
    conv = convs{i};
    if nv
        convs{i}=(conv-mn)/ nv;
    elseif mx
        convs{i}=conv/ mx;
    end
end

b.conv1 = convs{1};
b.conv2 = convs{2};
b.conv3 = convs{3};
b.conv4 = convs{4};
b.conv5 = convs{5};


filepath_save='/home/hpc/Ershadi/normal_vgg_features/';
sprintf('%05d',num);
matfile_address= strcat(filepath_save,sprintf('%05d',num),str);
save (matfile_address,'b');


% for num=1:5907
%     vgg_allDeep_norm(num,'.mat');
% end
% 
% 
% for num=1:3900
%     vgg_allDeep_norm(num,'_m.mat');
% end

global maxx meanx
maxx = @(a) max(max(max(a)));
meanx = @(a) mean(mean(mean(a)));

parfor num=1:5907
    display(strcat('first: ',num2str(num)))
    afshin_normalizeDeep(num,'.mat');
end


parfor num=1:3900
    display(strcat('second: ',num2str(num)))
    afshin_normalizeDeep(num,'_m.mat');
end
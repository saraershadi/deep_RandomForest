function football_train_sift(dbname)

if nargin<1, dbname = 'football5907m'; end

% dataset information
if strcmp(dbname, 'football')
    imagedir = '../dataset/FOOTBALL12m/';
    files = dir([imagedir '*.jpg']);
    load([imagedir 'labels.mat']);
    train_ims = 1:180*2;
    nTrain = length(train_ims);
    trainPoints = ptsAll(:,:,train_ims);
    trainNames = cell(1, nTrain);
    
    for i=1:nTrain
        trainNames{i} = files(train_ims(i)).name;
    end

elseif strcmp(dbname, 'football5907')
    imagedir = '../dataset/FOOTBALL5907/';
    files = dir([imagedir '*.jpg']);
    load([imagedir 'labels.mat']);
    train_ims = 1:3900;
%     train_ims = 1:20;

    nTrain = length(train_ims);
    trainPoints = ptsAll(:,:,train_ims);
    trainNames = cell(1, nTrain);
    for i=1:nTrain
        trainNames{i} = files(train_ims(i)).name;
    end
elseif strcmp(dbname, 'football5907m')
    imagedir = '../dataset/FOOTBALL5907m/';
    files = dir([imagedir '*.jpg']);
    load([imagedir 'labels.mat']);
    train_ims = 1:3900*2;
    %train_ims = 1:10;
    nTrain = length(train_ims);
    trainPoints = ptsAll(:,:,train_ims);
    trainNames = cell(1, nTrain);
    
    featureNames = cell(1, nTrain);
    

    featuredir = '/home/ce-ipl/vgg_features/';
    feature_files = dir([featuredir '*.mat']);
    
    for i=1:nTrain
        trainNames{i} = files(train_ims(i)).name;
        featureNames{i}=feature_files(train_ims(i)).name;
    end
elseif strcmp(dbname, 'campus')
    imagedir = '../dataset/';
    load([imagedir 'CampusLM/train.mat']);
elseif strcmp(dbname, 'campus_masked')
    imagedir = '../dataset/';
    load([imagedir 'CampusLMmasked/train.mat']);
end

model = [];

featureParams = [];
featureParams.type = 'HOG';
featureParams.sbin = 8;
featureParams.nTypes = 32;

model.featureParams = featureParams;

% train random forest
try
    load(['../data/forest_' dbname '.mat']);
catch    
    treeParams.nPosPatch =40; %50
    treeParams.nNegPatch = 400; %500
    treeParams.jointRadius = 10;
    treeParams.jointMargin = 10;
    treeParams.nTrees = 3; 
    treeParams.depth = 20;
    treeParams.radius = 50;
    treeParams.featureLength = 15000 ;
    treeParams.nNodeFeatures = 15000 ;
    treeParams.nThresholdBins = 10;
    treeParams.minimumGain = 0.01;
    treeParams.minimumSamples = 5;
    treeParams.thresholdMargin = 0;
    treeParams.partSegment = @PARSE_part_segment;
    treeParams.nTypes = featureParams.nTypes;

%treeParams
    [trees, treeParams] = my_forest_train_sift(imagedir, trainNames, trainPoints, featureParams, treeParams);
    save(['../data/forest_' dbname '.mat'], 'trees', 'treeParams');
end

model.trees = trees;

% set meanshift parameters
meanshift_params.num_clusters = 20;
meanshift_params.neighbor_radius = 20;
meanshift_params.kernel_gamma = 0.00001;
meanshift_params.stop_threshold = 1;
meanshift_params.stop_iterations = 100;
meanshift_params.merge_threshold = 5;
model.meanshift_params = meanshift_params;

ps_params.nClusters = 6*ones(1,14);
ps_params.lambda = 0.01;
ps_params.up = [1 6 7 12 14 2 5 8 11 3 4 9 10 13];
ps_params.pa = [2 3 9 10 4 5 8 9 13 13 10 11 0 13];
model.ps_model = ps_fit(trainPoints, ps_params);

save(['../data/model_' dbname '.mat'], 'model');

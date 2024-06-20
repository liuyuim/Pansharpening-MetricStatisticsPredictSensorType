%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 【6 评价指标准确率统计】
% 统计每一个指标 最优值是不是出现在 应该的传感器影像上
% 对比方法采用 Pansharpening Tool ver 1.3中的方法；
% 对比指标是 Fu：D_lambda,D_S,QNRI,SAM,SCC。DR：Q_index, SAM_index, ERGAS_index, sCC, Q2n_index。
% MatrixAll.mat 
% 第一维是若干种假设融合图像的评价结果，HypothesInGF1,HypothesInGF2...
% 第二维是五个评价指标,D_lambda,D_S,QNRI,SAM,SCC
% 第三维是100张图片
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 6.1 通过对单一指标表现统计，找出适合区分传感器类型的指标
clc;clear;close all;addpath(genpath('.\Fx\'));

% 对应Matrix_Fu第一维的n种假设,使用对应n的个数的函数，EvaluationFu2IndexStatistics3H/4H/5H

% Y={'GF1','IK','QB','WV2','WV3','WV4'}; Y={'GF1','GF2','JL1','QB','WV2','WV3'};
Y={'GF1','QB','WV4'}; 
 
% Index_Sensor = "IK"; % 使用的影像
% EvaluationDir = '..\IK_WSDFNet\EvaluateFu1024';
% EvaluationFu2IndexStatistics3H (EvaluationDir,Index_Sensor,Y)
% EvaluationFu2IndexStatistics4H (EvaluationDir,Index_Sensor,Y)
% EvaluationFu2IndexStatistics5H (EvaluationDir,Index_Sensor,Y)
% EvaluationFu2IndexStatistics6H (EvaluationDir,Index_Sensor,Y)

for Sizes = [1024]  %% Size 1024,512,256,128,64,32
    Size = num2str(Sizes);
    
    NetNames = {'WSDFNet'}; %% Net 'PanNet','LPPN','WSDFNet'
    for i = 1:numel(NetNames)
        NetName = NetNames{i};
        
        SensorNames = {'GF1','QB','WV4'}; % Sensor {'GF1','IK','QB','WV2','WV3','WV4'} {'GF1','GF2','JL1','QB','WV2','WV3'}
        for j = 1:numel(SensorNames)     
            Index_Sensor = SensorNames{j}; % 使用的影像
            Sensor_Net = strcat(SensorNames{j},'_',NetName);
            Evaluate_Fu = ['Evaluate_Fu',Size,'_G1QW4']; % 
            EvaluationDir = fullfile('F:\Demo\Data_MLPrediction\NBUDatasetResult',Sensor_Net,Evaluate_Fu);
            EvaluationFu2IndexStatistics3H (EvaluationDir,Index_Sensor,Y)
            
        end
    end
end

%% 6.2 预测

clc;clear;close all;addpath(genpath('.\Fx\'));


format short g;

% 对应Matrix_Fu第一维的n种假设，使用对应n的个数的函数，EvaluationFu2IndexStatistics3H/4H/5H
% Y={'GF1','GF2','IK','JL1','QB','WV2','WV3','WV4'}; 
Y={'GF1','QB','WV4'}; 

EvaluationDir = 'F:\Demo\Data_MLPrediction\NBUDatasetResult\GF1_WSDFNet\Evaluate_Fu1024_G1QW4';
EvaluationFu2Forecast3H(EvaluationDir,Y)

EvaluationDir = 'F:\Demo\Data_MLPrediction\NBUDatasetResult\QB_WSDFNet\Evaluate_Fu1024_G1QW4';
EvaluationFu2Forecast3H(EvaluationDir,Y)

EvaluationDir = 'F:\Demo\Data_MLPrediction\NBUDatasetResult\WV4_WSDFNet\Evaluate_Fu1024_G1QW4';
EvaluationFu2Forecast3H(EvaluationDir,Y)

function [] = EvaluationFu2IndexStatistics6H (EvaluationDir,Index_Sensor,Y)
    
    saveName = fullfile(EvaluationDir,'MatrixAll_Fu.mat');
    %Matrix_Fu = saveName;
    Matrix_Fu = load(saveName).Matrix_Fu;
%     Index_Sensor = Paras.sensor;
    NumImgs = size(Matrix_Fu,3); % Matrix_Fu第3维得到NumImgs

    % 对5参数循环
%     fprintf('对多参数循环排序，判断，统计。判断是否准确！ \n');        
    for i_Indexs = 1:5 % D_lambda, D_S, QNRI, SAM, SCC       

        % 对100幅影像循环排序，判断，统计
        Index_SensorCorrectNum = 0; %计数器清零
        for i_NumImgs = 1:NumImgs                 
            HypothesisDir1 = Matrix_Fu(1,i_Indexs,i_NumImgs);
            HypothesisDir2 = Matrix_Fu(2,i_Indexs,i_NumImgs);
            HypothesisDir3 = Matrix_Fu(3,i_Indexs,i_NumImgs);
            HypothesisDir4 = Matrix_Fu(4,i_Indexs,i_NumImgs);
            HypothesisDir5 = Matrix_Fu(5,i_Indexs,i_NumImgs);
            HypothesisDir6 = Matrix_Fu(5,i_Indexs,i_NumImgs);
           
            % 按相同顺序对向量进行排序。创建两个在对应元素中包含相关数据的行向量。https://ww2.mathworks.cn/help/matlab/ref/sort.html#d124e1289785
            X=[HypothesisDir1,HypothesisDir2,HypothesisDir3,HypothesisDir4,HypothesisDir5,HypothesisDir6];
%             X=[HypothesisDir1,HypothesisDir2,HypothesisDir3,HypothesisDir4];
%             Y={'GF1','GF2','QB','WV2','WV3'};
            
            % 首先对向量 X 进行排序，然后按照与 X 相同的顺序对向量 Y 进行排序。
            [~,I]=sort(X); %[Xsorted,I]=sort(X);
            Ysorted=Y(I);
            % char(Ysorted(1)) % 由小到大排序，第一个最小，再转换成字符串类型 % char(Ysorted(end)) 由小到大排序，最后一个最大，再转换成字符串类型 
            
            %验证两者是否一致 
            switch(i_Indexs)
                % D_lambda
                case 1
                    Index_SensorSort = char(Ysorted(1));
                    if isequal(Index_Sensor,Index_SensorSort)
                    Index_SensorCorrectNum = Index_SensorCorrectNum + 1;
                    end
                % D_S
                case 2
                    Index_SensorSort = char(Ysorted(1));
                    if isequal(Index_Sensor,Index_SensorSort)
                    Index_SensorCorrectNum = Index_SensorCorrectNum + 1;
                    end
                % QNRI
                case 3
                    Index_SensorSort = char(Ysorted(end));
                    if isequal(Index_Sensor,Index_SensorSort)
                    Index_SensorCorrectNum = Index_SensorCorrectNum + 1;
                    end
                % SAM
                case 4
                    Index_SensorSort = char(Ysorted(1));
                    if isequal(Index_Sensor,Index_SensorSort)
                    Index_SensorCorrectNum = Index_SensorCorrectNum + 1;
                    end
                % SCC
                case 5
                    Index_SensorSort = char(Ysorted(end));
                    if isequal(Index_Sensor,Index_SensorSort)
                    Index_SensorCorrectNum = Index_SensorCorrectNum + 1;
                    end    
                % otherwise
                otherwise                
                    fprintf("对多参数循环出错！");
                    break;

            end
            
                    
        end
        % 对100幅影像循环排序，判断，统计 后，计算正确率
        Index_SensorCorrectSum(i_Indexs) = Index_SensorCorrectNum;
        Index_SensorCorrectRate(i_Indexs) = double(Index_SensorCorrectNum / NumImgs);

    end
    % 对5参数循环 后，保存数据为mat
    saveName = fullfile(EvaluationDir,'Index_SensorCorrectRate_Fu.mat'); 
    save(saveName, 'Index_SensorCorrectSum','Index_SensorCorrectRate');
    fprintf("已完成对本次样本影像参数循环排序，判断，统计，请到%s查看！\n  ", EvaluationDir);
    fprintf('D_lambda,D_S,QNRI,SAM,SCC 准确个数计数，准确率分别为： \n');
    disp(Index_SensorCorrectSum);
    disp(Index_SensorCorrectRate);

end
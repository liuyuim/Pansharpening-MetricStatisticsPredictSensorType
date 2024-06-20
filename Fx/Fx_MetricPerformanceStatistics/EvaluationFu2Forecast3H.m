function [] = EvaluationFu2Forecast3H(EvaluationDir,Y)
    format short g;

    saveName = fullfile(EvaluationDir,'MatrixAll_Fu.mat');
    %Matrix_Fu = saveName;
    Matrix_Fu = load(saveName).Matrix_Fu;
%     Index_Sensor = Paras.sensor;
    NumImgs = size(Matrix_Fu,3); % Matrix_Fu第3维得到NumImgs

    % 设置xlsx文件名
    XlsxName = strcat("ForecastReport", string(datetime, 'yyyy-MM-dd-HH-mm-ss'), '.xlsx');
    saveXlsxName = fullfile(EvaluationDir,XlsxName);

     %计数器清零
    ForecastGF1Num_D_lambda = 0; ForecastGF1Num_D_S = 0; ForecastGF1Num_QNRI = 0;ForecastGF1Num_SAM = 0;ForecastGF1Num_SCC = 0;
    ForecastQBNum_D_lambda = 0; ForecastQBNum_D_S = 0; ForecastQBNum_QNRI = 0;ForecastQBNum_SAM = 0;ForecastQBNum_SCC = 0;
    ForecastWV4Num_D_lambda = 0; ForecastWV4Num_D_S = 0; ForecastWV4Num_QNRI = 0;ForecastWV4Num_SAM = 0;ForecastWV4Num_SCC = 0;
        
    fprintf('根据评价结果进行预测... %s \n',saveName);      

    % 对5参数循环
    for i_Indexs = 1:5 % D_lambda, D_S, QNRI, SAM, SCC       

        % 对100幅影像循环排序，判断，统计        
        for i_NumImgs = 1:NumImgs                 
            HypothesisDir1 = Matrix_Fu(1,i_Indexs,i_NumImgs);
            HypothesisDir2 = Matrix_Fu(2,i_Indexs,i_NumImgs);
            HypothesisDir3 = Matrix_Fu(3,i_Indexs,i_NumImgs);
%             HypothesisDir4 = Matrix_Fu(4,i_Indexs,i_NumImgs);
%             HypothesisDir5 = Matrix_Fu(5,i_Indexs,i_NumImgs);
           
            % 按相同顺序对向量进行排序。创建两个在对应元素中包含相关数据的行向量。https://ww2.mathworks.cn/help/matlab/ref/sort.html#d124e1289785
%             X=[HypothesisDir1,HypothesisDir2,HypothesisDir3,HypothesisDir4,HypothesisDir5];
            X=[HypothesisDir1,HypothesisDir2,HypothesisDir3];
%             Y={'GF1','GF2','QB','WV2','WV3'};
            
            % 首先对向量 X 进行排序，然后按照与 X 相同的顺序对向量 Y 进行排序。
            [~,I]=sort(X); %[Xsorted,I]=sort(X);
            Ysorted=Y(I);
            % char(Ysorted(1)) % 由小到大排序，第一个最小，再转换成字符串类型 % char(Ysorted(end)) 由小到大排序，最后一个最大，再转换成字符串类型 
            
            %验证两者是否一致
            switch(i_Indexs)                
                case 1 % D_lambda "0"
                    Index_SensorSort = char(Ysorted(1));
                    switch(Index_SensorSort)
                        case 'GF1' ; ForecastGF1Num_D_lambda = ForecastGF1Num_D_lambda + 1;
                        case 'QB' ; ForecastQBNum_D_lambda = ForecastQBNum_D_lambda + 1;
                        case 'WV4' ; ForecastWV4Num_D_lambda = ForecastWV4Num_D_lambda + 1;
                    end                
                case 2 % D_S "0"
                    Index_SensorSort = char(Ysorted(1));
                    switch(Index_SensorSort)
                        case 'GF1' ; ForecastGF1Num_D_S = ForecastGF1Num_D_S + 1;
                        case 'QB' ; ForecastQBNum_D_S = ForecastQBNum_D_S + 1;
                        case 'WV4' ; ForecastWV4Num_D_S = ForecastWV4Num_D_S + 1;
                    end                
                case 3 % QNRI "1"
                    Index_SensorSort = char(Ysorted(end));
                    switch(Index_SensorSort)
                        case 'GF1' ; ForecastGF1Num_QNRI = ForecastGF1Num_QNRI + 1;
                        case 'QB' ; ForecastQBNum_QNRI = ForecastQBNum_QNRI + 1;
                        case 'WV4' ; ForecastWV4Num_QNRI = ForecastWV4Num_QNRI + 1;
                    end                
                case 4 % SAM "0"
                    Index_SensorSort = char(Ysorted(1));
                    switch(Index_SensorSort)
                        case 'GF1' ; ForecastGF1Num_SAM = ForecastGF1Num_SAM + 1;
                        case 'QB' ; ForecastQBNum_SAM = ForecastQBNum_SAM + 1;
                        case 'WV4' ; ForecastWV4Num_SAM = ForecastWV4Num_SAM + 1;
                    end                
                case 5 % SCC "1"
                    Index_SensorSort = char(Ysorted(end));
                    switch(Index_SensorSort)
                        case 'GF1' ; ForecastGF1Num_SCC = ForecastGF1Num_SCC + 1;
                        case 'QB' ; ForecastQBNum_SCC = ForecastQBNum_SCC + 1;
                        case 'WV4' ; ForecastWV4Num_SCC = ForecastWV4Num_SCC + 1;
                    end
                % otherwise
                otherwise                
                    fprintf("对多参数循环出错！");
                    break;

            end
            
                    
        end
        
        % 对100幅影像循环排序，判断，统计 后

        % Index_SensorCorrectSum(i_Indexs) = Index_SensorCorrectNum;
        % Index_SensorCorrectRate(i_Indexs) = double(Index_SensorCorrectNum / NumImgs);

    end
    % 对5参数循环 后，给出预测结果，保存数据为xslm
    % 打印统计结果
    XlsxTitle=["ForecastGF1Num_D_lambda","ForecastQBNum_D_lambda","ForecastWV4Num_D_lambda"];
    ForecastSensorNum_D_lambda=[ForecastGF1Num_D_lambda,ForecastQBNum_D_lambda,ForecastWV4Num_D_lambda];
    writematrix(XlsxTitle,saveXlsxName,'WriteMode','append')
    writematrix(ForecastSensorNum_D_lambda,saveXlsxName,'WriteMode','append')
    
    XlsxTitle=["ForecastGF1Num_D_S","ForecastQBNum_D_S","ForecastWV4Num_D_S"];
    ForecastSensorNum_D_S=[ForecastGF1Num_D_S,ForecastQBNum_D_S,ForecastWV4Num_D_S];
    writematrix(XlsxTitle,saveXlsxName,'WriteMode','append')
    writematrix(ForecastSensorNum_D_S,saveXlsxName,'WriteMode','append')

    XlsxTitle=["ForecastGF1Num_QNRI","ForecastQBNum_QNRI","ForecastWV4Num_QNRI"];
    ForecastSensorNum_QNRI=[ForecastGF1Num_QNRI,ForecastQBNum_QNRI,ForecastWV4Num_QNRI];
    writematrix(XlsxTitle,saveXlsxName,'WriteMode','append')
    writematrix(ForecastSensorNum_QNRI,saveXlsxName,'WriteMode','append')
    
    XlsxTitle=["ForecastGF1Num_SAM","ForecastQBNum_SAM","ForecastWV4Num_SAM"];
    ForecastSensorNum_SAM=[ForecastGF1Num_SAM,ForecastQBNum_SAM,ForecastWV4Num_SAM];
    writematrix(XlsxTitle,saveXlsxName,'WriteMode','append')
    writematrix(ForecastSensorNum_SAM,saveXlsxName,'WriteMode','append')
    
    XlsxTitle=["ForecastGF1Num_SCC","ForecastQBNum_SCC","ForecastWV4Num_SCC"];
    ForecastSensorNum_SCC=[ForecastGF1Num_SCC,ForecastQBNum_SCC,ForecastWV4Num_SCC];
    writematrix(XlsxTitle,saveXlsxName,'WriteMode','append')
    writematrix(ForecastSensorNum_SCC,saveXlsxName,'WriteMode','append')
    
    % 预测
    % QNRI        
    [~,I]=sort(ForecastSensorNum_QNRI); Ysorted=Y(I);
    ForecastSensor_QNRI = char(Ysorted(end));       
    writematrix(["根据QNRI预测结果"],saveXlsxName,'WriteMode','append')
    writematrix([ForecastSensor_QNRI,ForecastSensor_QNRI/NumImgs],saveXlsxName,'WriteMode','append')
    fprintf("根据QNRI指标得出的预测结果是 %s ！具体统计结果打印至xlsx \n ", ForecastSensor_QNRI);
    
    % SAM        
    [~,I]=sort(ForecastSensorNum_SAM); Ysorted=Y(I);
    ForecastSensor_SAM = char(Ysorted(end));
    writematrix(["根据SAM预测结果"],saveXlsxName,'WriteMode','append')
    writematrix([ForecastSensor_SAM,ForecastSensor_SAM/NumImgs],saveXlsxName,'WriteMode','append')
    fprintf("根据SAM指标得出的预测结果是 %s ！具体统计结果打印至xlsx \n ", ForecastSensor_SAM);
end
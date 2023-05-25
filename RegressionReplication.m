function RegressionResponse = RegressionReplication(X,y)
%RegressionReplication Compute the weights of the replication strategy that
%   minimize the TEV, using a regression approach
%
%   RegressionResponse = RegressionReplication(X,y)
%   The function asks in input the returns to be replicated (y) and the
%   matrix of returns of the replication instruments.
%
%   The function return a struct with the following fields:
%       * Type: Lasso, Ridge or Elastic Net
%       * alpha: between 0 and 1
%       * lambdaType: IndexMinMSE, Index1SE
%       * lambda: value associated to the lambdaType
%       * b: coefficients of the regression
%       * Returns: estimated returns using b (X*b)
%       * TEV: Tracking Error Variance
%   
%   The function uses: ComputeTEV, lasso
%
%   See also ComputeTEV, lasso
%
    
    % Initialization to a random high value for the condition
    RegressionResponse.TEV = 99999;
    
    % Lasso and Elastic Net regressions
    warning off
    for alpha = 0.1:0.1:1
        if alpha == 1
            % Lasso regression
            [b,fitinfo] = lasso(X,y,'CV',5, 'Intercept',false);
        else
            % Elastic Net regression
            [b,fitinfo] = lasso(X,y,'Alpha',alpha,'CV',5, 'Intercept',false);
        end
        lambda_b = [fitinfo.IndexMinMSE, fitinfo.Index1SE];
        
        % Consider both the main lambda
        for i = 1:2
            lambda = lambda_b(i);
            b_lambda = b(:,lambda);
            replicaRet = X*b_lambda;
            TEV = ComputeTEV(replicaRet,y);
            
            % Update of the optimal
            if TEV<RegressionResponse.TEV
                RegressionResponse.TEV = TEV;
                RegressionResponse.alpha = alpha;
                RegressionResponse.lambda = i;
                RegressionResponse.b = b_lambda;
                RegressionResponse.Returns = replicaRet;
            end
        end
    end
    warning on
    
    % Ridge regression
    for k=0:0.01:1
        b = ridge(y, X, k);
        replicaRet = X*b;
        TEV = ComputeTEV(replicaRet,y);
        
        % Update of the optimal
        if TEV<RegressionResponse.TEV
                RegressionResponse.TEV = TEV;
                RegressionResponse.alpha = 0;
                RegressionResponse.lambda = k;
                RegressionResponse.b = b;
                RegressionResponse.Returns = replicaRet;
        end
    end

    % Display on method used
    switch RegressionResponse.alpha
        case 1
            disp('Applying a Lasso regression')
            RegressionResponse.Type = 'Lasso';
        case 0 
            disp('Applying a Ridge regression')
            RegressionResponse.Type = 'Ridge';
        otherwise 
            display(['Applying an Elastic Net regression with alpha = ',num2str(RegressionResponse.alpha)])
            RegressionResponse.Type = 'Elastic Net';
    end
    
    % Display on regression parameter used
    switch RegressionResponse.lambda
        case 1
            disp('Optimizing using lambda such that MSE is min')
            RegressionResponse.lambdaType = 'IndexMinMSE';
        case 2 
            disp('Optimizing using lambda such that MSE is within 1 SE off min MSE')
            RegressionResponse.lambdaType = 'Index1SE';
        otherwise 
            if RegressionResponse.alpha == 0
                disp(['The optimizing Ridge uses parameter: ',num2str(RegressionResponse.lambda)])
            else
                error('Something went wrong')
            end
    end

    % Plotting the weights
    disp(['The replication portfolio has TEV = ',num2str(RegressionResponse.TEV),' and the following weights:'])
    figure()
    bar(RegressionResponse.b)
    title('Weights (regression coefficients)')
    ylabel('Weight')
    xlabel('Assets (#)')

end % end RegressionReplication
function [Weights,TEV_return] = mainKalman(model,x_initial,Returns,Date,Benchmark)
%mainKalman Perform the main analysis of the Kalman part and plot it
%
%   [Weights,TEV_return] = mainKalman(model,x_initial,Returns,Date) 
%   [Weights,TEV_return] = mainKalman(model,x_initial,Returns,Date,Benchmark)
%       It possible to give also a benchmark set of returns to have a
%       reference inside the plot
%   
%   The function uses: KalmanFilter, ComputeTEV, ret2price
%
%   See also KalmanFilter, ComputeTEV
%    

    y = model.y;
    m = size(model.V1,1);
    P = ones(m,m)*(y(1)-Returns(1,:)*x_initial); 
    
    [~,Weights,~] = KalmanFilter(model,x_initial,P);
    Prediction = sum(Returns.*Weights',2);
    
    TEV_return = ComputeTEV(Prediction,y);
    if nargin<5
        display(['TEV Kalman = ',num2str(TEV_return)])
    else
        display(['TEV Kalman = ',num2str(TEV_return)])
        TEV_return = ComputeTEV(Benchmark,y);
        display(['TEV Benchmark = ',num2str(TEV_return)])
    end

    figure()
    subplot(1,2,1)
    plot(Date,ret2price(y),'Color','b')
    hold on
    plot(Date,ret2price(Prediction),'Color','r')
    if nargin<5
        legend('Target','Predicted')
    else
        plot(Date,ret2price(Benchmark),'Color','g')
        legend('Target','Predicted','Benchmark')
    end

    subplot(1,2,2)
    plot(Date(2:end),y,'Color','b')
    hold on
    plot(Date(2:end),Prediction,'r.','MarkerSize',10)
    legend('Target','Predicted')

end % end mainKalman



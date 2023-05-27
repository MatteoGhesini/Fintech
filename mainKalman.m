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
    % The construction of P is based on the case study and some literature
    % found on the web. The model is quite sensible to this choice.
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

    % To make a plot of Return and Price
%     figure()
%     subplot(1,2,1)
%     plot(Date,ret2price(y),'Color','b', 'LineWidth', 1.5)
%     hold on
%     plot(Date,ret2price(Prediction),'Color','r', 'LineWidth', 1.5)
%     xlabel("years")
%     ylabel("prices")
%     if nargin<5
%         legend('Target','Predicted')
%     else
%         plot(Date,ret2price(Benchmark),'Color','g', 'LineWidth', 1.5)
%         xlabel("years")
%         ylabel("prices")
%         legend('Target','Predicted','Benchmark')
%     end
% 
%     subplot(1,2,2)
%     plot(Date(2:end),y,'Color','b', 'LineWidth', 1.5)
%     hold on
%     plot(Date(2:end),Prediction,'r.','MarkerSize',10)
%     xlabel("years")
%     ylabel("returns")
%     legend('Target','Predicted')
    
    % To make a plot of Price - Kalman Prediction
    figure()
    plot(Date,ret2price(y),'Color','b', 'LineWidth', 1.5)
    hold on
    plot(Date,ret2price(Prediction),'Color','r', 'LineWidth', 1.5)
    xlabel("Year")
    ylabel("Price")
    if nargin<5
        legend('Target','Predicted')
    else
        plot(Date,ret2price(Benchmark),'Color','g', 'LineWidth', 1.5)
        xlabel("Year")
        ylabel("Price")
        legend('Target','Predicted','Benchmark')
    end
    title('Kalman Prediction')


end % end mainKalman



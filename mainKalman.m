function [Prediction,TEV_return, TEV_price] = mainKalman(model,x_initial,Returns,Date)
%mainKalman Perform the main analysis of the Kalman part and plot it
%
%   [Prediction,TEV_return, TEV_price] = mainKalman(model,x_initial,Returns,Date) 
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
    
    [TEV_return, TEV_price] = ComputeTEV(Prediction,y);
    display(['Case with initial x=',num2str(x_initial(1)),': TEV_return=',num2str(TEV_return)])

    figure()
    subplot(1,2,1)
    plot(Date,ret2price(y),'Color','b')
    hold on
    plot(Date,ret2price(Prediction),'Color','r')
    legend('Target','Predicted')

    subplot(1,2,2)
    plot(Date(2:end),y,'Color','b')
    hold on
    plot(Date(2:end),Prediction,'r.','MarkerSize',10)
    legend('Target','Predicted')
end % end mainKalman



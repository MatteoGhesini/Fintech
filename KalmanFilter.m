function [K,x_hat,y_hat_minus] = KalmanFilter(model,P,step)
    [y, F, ~, H, ~, V1, V2, V12] = retrivingData(model);
    
    n = size(y, 1);  % Number of time steps
    m = size(H, 2);  % Number of instruments

    K = zeros(m,n);            % initialize the gain dimensionality
    x_hat_minus = zeros(m,n);  % initialize x_hat(t|t-1)
    x_hat = zeros(m,n);        % initialize x_hat(t+1|t)
    y_hat_minus = zeros(1,n);  % initialize y_hat(t|t-1)
    e = zeros(1,n);            % initialize error vector

    for i = 1:step:n
        % Compute the Kalman gain
        K(:,i) = (H(i,:)*P*H(i,:)'+V2)\(F*P*H(i,:)'+V12);
        % Update the Error covariance
        P = (F*P*F'+V1)-K(:,i)*(F*P*H(i,:)'+V12)';
        
        % Estimate the response
        y_hat_minus(i) = H(i,:)*x_hat_minus(:,i);
        % Compute the error of the estimated response
        e(i) = y(i)-y_hat_minus(i);
        % Update estimate with measurement
        x_hat(:,i) = F*x_hat_minus(:,i) + K(:,i)*e(i); 
    
        % Project the state ahead
        x_hat_minus(:,i+1) = x_hat(:,i);
    end
    
    for i = 1:n
        if x_hat(1,i) == 0
            x_hat(:,i) = x_hat(:,i-1);
        end
    end

end
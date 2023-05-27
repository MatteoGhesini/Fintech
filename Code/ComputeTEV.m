function [TEV_return,TEV_price] = ComputeTEV(Prediction,TargetReturn,TargetPrice,Periodicity)
%ComputeTEV Compute the TEV of the predicted returns (it does it also for
%   the price)
%
%   TEV_return = ComputeTEV(Prediction,TargetReturn)
%   [TEV_return,TEV_price] = ComputeTEV(Prediction,TargetReturn,TargetPrice)
%   [TEV_return,TEV_price] = ComputeTEV(Prediction,TargetReturn,TargetPrice,Periodicity)
%       the default periodicity is weekly, so 52 weeks in a year
%   periodicity can assume values: 'daily','weekly','monthly','yearly'
%   
%   The function uses: ret2price
%
%    
 
    if nargin<2
        error('Mendatory Information Missing')
    elseif nargin<4
        TargetPrice=ret2price(TargetReturn);
        Periodicity = 'weekly';
    end

    switch Periodicity
        case 'daily'
            step = 365;
        case 'weekly'
            step = 52;
        case 'monthly'
            step = 12;
        case 'yearly'
            step = 1;
    end

    TE_return = Prediction - TargetReturn;
    TEV_return = std(TE_return)*sqrt(step);
    TE_price = ret2price(Prediction) - TargetPrice;
    TEV_price = std(TE_price)*sqrt(step);
    
end % end ComputeTEV



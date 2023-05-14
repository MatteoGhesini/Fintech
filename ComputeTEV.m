function [TEV_return,TEV_price] = ComputeTEV(Prediction,TargetReturn,TargetPrice)
%ComputeTEV Compute the TEV of the predicted returns (it does it also for
%   the price)
%
%   TEV_return = ComputeTEV(Prediction,TargetReturn)
%   [TEV_return,TEV_price] = ComputeTEV(Prediction,TargetReturn,TargetPrice)
%   
%   The function uses: ret2price
%
%    
 
    if nargin<2
        error('Mendatory Information Missing')
    elseif nargin<3
        TargetPrice=ret2price(TargetReturn);
    end

    TE_return = Prediction - TargetReturn;
    TEV_return = std(TE_return)*sqrt(52);
    TE_price = ret2price(Prediction) - TargetPrice;
    TEV_price = std(TE_price)*sqrt(52);
end % end ComputeTEV



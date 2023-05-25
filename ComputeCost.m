function [Cost, NumberVariations] = ComputeCost(Weights,CostTransaction)
%ComputeCost Compute the cost to change so many times wheights
%
%   Cost = ComputeCost(Weights,CostTransaction)
%       CostTransaction describes the cost to open a transaction
%       indipendently of the amount of stock exchanged in that
%
%   [Cost, NumberVariations] = ComputeCost(Weights,CostTransaction)
%       the function can return also the number of changes predicted to do
%       for each replication title
%
%       

    m = size(Weights,1);
    n = size(Weights,2);
    
    NumberVariations = zeros(m,1) + n;
    Variations = round(Weights(:,1:end-1) - Weights(:,2:end),4);
   

    for i = 1:m
        NumberVariations(i) = NumberVariations(i) - length(find(Variations(i,:)==0));
    end
    Cost = sum(NumberVariations)*CostTransaction;

end % end ComputeCost

function [y, F, G, H, D, V1, V2, V12] = retrivingData(model)
%retrivingData Extract all the element from an object model
%
%   [y, F, G, H, D, V1, V2, V12] = retrivingData(model) 
%     x(t+1) = Fx(t) + Gu(t) + v1(t)       {State equation}
%     y(t)   = Hx(t) + Du(t) + v2(t)       {Measurements}
%       v1(t)~N(0,V1) v1(t)~N(0,V1) V12 covariance between v1,v2
%   
%   The object model can be easely created using InitializeModel
%   If element not mendatory in model are empty they are substituted with
%   the default value
%   
%   See also InitializeModel
%

    if isempty( model.y ) || isempty( model.H ) || isempty( model.V1 ) || isempty( model.V2 ) 
        error('Mendatory Information Missing')
    else
        y = model.y;

        H = model.H;
        m = size(H, 2);

        V1 = model.V1;
        V2 = model.V2;
    end
     
    if isempty( model.F )
        F = eye(m);
    else
        F = model.F;
    end

    if isempty( model.G )
        G = zeros(m);
    else
        G = model.G;
    end

    if isempty( model.D )
        D = 0;
    else
        D = model.D;
    end

    if isempty( model.V12 )
        V12 = 0;
    else
        V12 = model.V12;
    end
    
end % retrivingData
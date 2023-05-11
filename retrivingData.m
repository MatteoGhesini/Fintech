function [y, F, G, H, D, V1, V2, V12] = retrivingData(model)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    if isempty( model.y ) || isempty( model.H ) || isempty( model.V1 ) || isempty( model.V2 ) 
        warning ("Vital information are absent")
        return
    else
        y = model.y;
        n = size(y, 1);

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
    
end
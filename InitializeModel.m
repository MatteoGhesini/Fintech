function model = InitializeModel(y, F, G, H, D, V1, V2, V12)
%InitializeModel Initialize an object model
%
%   model = InitializeModel(y, F, G, H, D, V1, V2, V12) 
%     x(t+1) = Fx(t) + Gu(t) + v1(t)       {State equation}
%     y(t)   = Hx(t) + Du(t) + v2(t)       {Measurements}
%       v1(t)~N(0,V1) v1(t)~N(0,V1) V12 covariance between v1,v2
%   
%   If want to use default terms use [] to fill the variables
%   Mendatory terms: y,H,V1,V2
%   
%   See also retrivingData
%

    if isempty( y ) || isempty( H ) || isempty( V1 ) || isempty( V2 ) 
        error('Mendatory Information Missing')
    end

    model.F = F;
    model.G = G; 
    model.H = H;
    model.D = D; 
    model.V1 = V1;
    model.V2 = V2;
    model.V12 = V12;

end % end InitializeModel
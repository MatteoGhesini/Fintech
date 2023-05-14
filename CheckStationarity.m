function CheckStationarity(ts)
%CheckStationarity Use Augmented Dickey-Fuller test for a unit root to
%   determine stationarity of the TimeSeries
%
%   CheckStationarity(ts) 
%       where ts is the time series as a vector
%   
%   It will print the result of the analys as text
%   The function adftest that is called already gives us a conclusion on
%   the test but we prefer to do it our own hands
%
%   The function uses: adftest
%
%   See also adftest
%    
    
    [~,pValue,stat,cValue] = adftest(ts);

    if (pValue<0.05) && (stat<cValue)
        disp('    The series is stationary')
    else
        disp('    The series is not stationary')
    end
end % end CheckStationarity



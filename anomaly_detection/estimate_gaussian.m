function [mean_values variances] = estimate_gaussian(X)
    % mean_values = zeros(1,1);
    % variances = zeros(1,1);
    [m, n] = size(X);   
    %initializam cu 0
    mean_values = zeros(1, n);
    variances = zeros(n, n);
    %calculam vectorul
    for j = 1 : n
        s = 0;
        for i = 1 : m
            s = s + X(i, j);
        end
        mean_values(1, j) = s / m;
    end
    %calculam matricea 
    for i = 1 : m
        y = X(i, :) - mean_values;
        variances = variances + y' * y;
    end
    variances = variances / m;
endfunction

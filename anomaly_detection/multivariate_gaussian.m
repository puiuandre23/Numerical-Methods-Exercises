% Computes the probability density function of the multivariate gaussian distribution.
function probabilities = multivariate_gaussian(X, mean_values, variances)
    % probabilities = zeros(1, 1);
    probabilities = gaussian_distribution(X, mean_values, variances);
endfunction

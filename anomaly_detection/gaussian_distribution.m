function probabilities = gaussian_distribution(X, mean_value, covariance_matrix)
    % Aceasta functie calculeaza densitatea de probabilitate pentru datasetul dat,
    % folosind distributia gaussiana.
    [n, m] = size(X);
    det_covariance = det(covariance_matrix);
    inv_covariance = inv(covariance_matrix);
    %initializam vectorul cu 0
    probabilities = zeros(n, 1);
    for i = 1:n
        %pentru fiecare x(i), calculam valoarea corespunzatoare din vector
        exponent = -0.5 * (X(i, :)' - mean_value')' * inv_covariance * (X(i, :)' - mean_value');
        probabilities(i) = (1 / ((2 * pi)^(size(X, 2) / 2) * sqrt(det_covariance))) * exp(exponent);
    end
end

function [a] = get_prediction_params (K, y, lambda)
  # TO DO: folosind metode neiterative, implementati logica
  # pentru a obtine vectorul coloana a, asa cum este descris in enuntul temei
  m = size(K, 1);
  A = lambda * eye(m) + K;
  %aplic cholesky pentru A
  L = cholesky(A);
  %inversez L
  P = get_lower_inverse(L);
  a = lambda * P' * (P * y); 
endfunction

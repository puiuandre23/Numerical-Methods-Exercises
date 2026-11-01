function [P] = get_lower_inverse (L)
  # TO DO: Determinati printr-o metoda matriceala neiterativa inversa
  # unei matrici de tipul lower
  [n, n] = size(L);
  Le = [L, eye(n)];
  %aplic eliminare Gauss Jordan pentru a afla inversa
  for p = 1 : n
    if Le(p, p) == 0
    %daca elementul diagonal e nul, aplic pivotare partiala
      [piv, l_piv] = max(abs(Le(p:n, p)));
      l_piv = l_piv + p - 1;
      temp = Le(l_piv, :);
      Le(l_piv,:) = Le(p, :);
      Le(p, :) = temp;
    end
    %impart toata linia la elementul diagonal
    Le(p, :) /= Le(p, p);
    for l = p+1 : n
      Le(l, :) -= Le(l, p) * Le(p, :);
    end
  end
  P = Le(:, n+1 : 2*n);
endfunction

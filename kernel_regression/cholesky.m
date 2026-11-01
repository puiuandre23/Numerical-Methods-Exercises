function [L] = cholesky (A)
    # TO DO: realizati descompunerea cholesky pentru o matrice
    # positiv definita
    [n, n] = size(A);
    L = zeros(n, n);
    for i = 1 : n
        %valorile non diagonale
        for j = 1 : i-1
            S = sum(L(i, 1:j-1) .* L(j, 1:j-1));
            L(i,j) = (A(i,j) - S) / L(j,j);
        end
        %valorile diagonale
        S = sum(L(i, 1:i-1) .^ 2);
        L(i,i) = sqrt(A(i,i) - S);
    end
endfunction

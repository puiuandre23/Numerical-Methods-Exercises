function [x] = conjugate_gradient(A, b, x0, tol, max_iter) 
    %algoritmul din enunt
    r = b - A * x0;
    v = r;
    x = x0;
    k = 1;
    while k <= max_iter && norm(r) > tol
        Av = A * v;
        tk = (r' * r) / (v' * Av);
        x = x + tk * v;
        r_new = r - tk * Av;
        sk = (r_new' * r_new) / (r' * r);
        v = r_new + sk * v;
        r = r_new;
        k = k + 1;
    end
end

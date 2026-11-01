function B = k_secv (A, k)
  % given an array [a b a b c] and k=2
  % should return [ab ba ab bc]
  % HINT: use strjoin
  if(k > numel(A))
  %nu putem lua k elemente dintr-un
  %vector de lungime <k
    B = {};
    return;
  end
  %initializez B care e cell array
  B = cell(numel(A) - k, 1);
  for ind = 1 : numel(A) - k
  %iau k elemente de la ind incolo
    b = A(ind : ind + k - 1);
    %construiesc B
    B{ind, 1} = strjoin(b, ' ');
  endfor
endfunction

function retval = word_idx (distinct_wds)
    % return the word_idx dictionary HINT: containers.Map
    n = numel(distinct_wds);
    for i = 1:n
      aux(i) = i;
    endfor
    %construiesc dictionarul 
    retval = containers.Map(distinct_wds, aux);
endfunction

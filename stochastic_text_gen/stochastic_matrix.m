function retval = stochastic_matrix(k_secv_corpus, corpus_words, words_set, k_secv_set, k)
    % build the stochastic matrix. Bonus if it is sparse
    % The 'stochastic' matrix SHOULD NOT be scaled (divided by sum of all)
    % It should just be entry-wise
    % This is how the checker tests it, to not have to deal with floating point errors
    retval = {};
    mat = sparse(numel(k_secv_set), numel(words_set));
    %initializez matricea sparse
    nr_secv = numel(k_secv_corpus);
    for i = 1 : nr_secv
    %pentru fiecare secventa, ii gasesc indicele in set
        secv_index = find(strcmp(k_secv_corpus{i}, k_secv_set));
        %la secventa i, trebuie luat cuvantul de la i+k
        %pentru ca acela urmeaza dupa secventa 
        word_index = find(strcmp(corpus_words{i + k}, words_set));
        %actualizez matricea stocastica 
        mat(secv_index, word_index) = mat(secv_index, word_index) + 1;
    end
    retval = mat;
end

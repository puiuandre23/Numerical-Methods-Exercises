function [false_pozitives false_negatives true_pozitives] = check_predictions(predictions, truths)
    false_pozitives = 0;
    false_negatives = 0;
    true_pozitives = 0;
    len = length(truths)
    for i = 1 : len
        if predictions(i) == 0 && truths(i) == 1
        %daca predictia zice ca e fals, dar
        %de fapt e adevarat, avem un fals negativ
            false_negatives = false_negatives + 1;
        end
        if predictions(i) == 1 && truths(i) == 0
        %daca predictia zice ca e adevarat, dar
        %de fapt e fals, avem un fals pozitiv
            false_pozitives = false_pozitives + 1;
        end
        if predictions(i) == 1 && truths(i) == 1
        %daca predictia zice ca e adevarat, dar
        %de fapt e adevarat, avem un adevarat pozitiv
            true_pozitives = true_pozitives + 1;
        end
    end
end
function [best_epsilon best_F1 associated_precision associated_recall] = optimal_threshold(truths, probabilities)
    % best_epsilon = 0;
    % best_F1 = 0;
    % associated_precision = 0;
    % associated_recall = 0;
    start_point = min(probabilities);
    end_point = max(probabilities);
    %ne trebuie cea mai mare valoare a lui F1
    %deci il initializam cu -1
    best_F1 = -1;
    %v contine 1001 elemente echidistante, primul fiind
    %start_point, iar ultimul end_point
    v = linspace(start_point, end_point, 1001);
    for epsilon = v
    %construim vectorul predictions
        for i = 1 : length(probabilities)
            if probabilities(i) < epsilon 
                predictions(i) = 1;
            else
                predictions(i) = 0;
            end
        end
        %aflam parametrii pentru vectorul creat
        [false_pozitives false_negatives true_pozitives] = check_predictions(predictions, truths);
        %obtinem parametrii pentru epsilon actual
        [precision recall F1] = metrics(true_pozitives, false_pozitives, false_negatives);
        %daca F1 pentru acest epsilon e mai bun decat ce aveam pana acum 
        if F1 > best_F1
            best_F1 = F1;
            best_epsilon = epsilon;
            associated_precision = precision;
            associated_recall = recall;
        end
    end
end

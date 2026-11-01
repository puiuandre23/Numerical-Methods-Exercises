function [X_train, y_train, X_pred, y_pred] = split_dataset (X, y, percentage)
  # TO DO: împarte setul de date în 2 seturi: 
  # un set de training si un set de test,
  # ambele reprezentate printr-o matrice de features un vector de clase
  # percentage este un parametru considerat intre 0 si 1
  
  # Fiecare linie a matricii X reprezinta x^{(i)} si fiecare element de pe
  # linia coloanei y reprezinta y^{(i)}
  n = size(X, 1);
  nr1 = round(n * percentage);
  %primele nr1 linii sunt cele 
  %care antreneaza modelul
  X_train = X(1 : nr1, :);
  y_train = y(1 : nr1);
  %ultimele linii sunt cele pe care 
  %le avem de prezis 
  X_pred = X(nr1+1 : end, :);
  y_pred = y(nr1+1 : end);
endfunction

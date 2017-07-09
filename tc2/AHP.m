function [xBest, fBest] = AHP(X, custos, w)

alternativas = zeros(5, 500);
alternativas(1, :) = X(125, :);
alternativas(2, :) = X(80, :);
alternativas(3, :) = X(50, :);
alternativas(4, :) = X(9, :);
alternativas(5, :) = X(1, :);

solucoes = zeros(5, 2);
solucoes(1, :) = custos(125, :);
solucoes(2, :) = custos(80, :);
solucoes(3, :) = custos(50, :);
solucoes(4, :) = custos(9, :);
solucoes(5, :) = custos(1, :);

criterio1 = csvread('AHPcriterio1.csv');
criterio2 = csvread('AHPcriterio2.csv');

prioridades = zeros(5, 2);
normalizacao1 = zeros(5, 5);
somaColunas1 = sum(criterio1, 1);
normalizacao2 = zeros(5, 5);
somaColunas2 = sum(criterio2, 1);
for i = 1:5
    normalizacao1(:, i) = criterio1(:, i)/somaColunas1(i);
    normalizacao2(:, i) = criterio2(:, i)/somaColunas2(i);
end

prioridades(:, 1) = mean(normalizacao1, 2);
prioridades(:, 2) = mean(normalizacao2, 2);

prioridadesFinais = prioridades*w';

xBest = alternativas(prioridadesFinais == max(prioridadesFinais), :);
fBest = solucoes(prioridadesFinais == max(prioridadesFinais), :);
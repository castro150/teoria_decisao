function [] = AHP(X, G, w)

%G = unique(G,'rows');

l = length(G);
intervaloIndice = floor(l/5);
alternativas = zeros(5, 2);
alternativas(1, :) = G(1, :);
alternativas(2, :) = G(150, :);
alternativas(3, :) = G(1, :);
alternativas(4, :) = G(1, :);
alternativas(5, :) = G(1, :);

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

decisao = prioridades*w';
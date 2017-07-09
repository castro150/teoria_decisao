ClusterDBCSV = 'ClusterDB.csv';
EquipDBCSV = 'EquipDB.csv';
MPDBCSV = 'MPDB.csv';

% Parâmetros
horizonte_tempo = 5;

T = csvread(MPDBCSV);
custo_manutencao = T(:,3)';
fator_risco = T(:,2)';

T = csvread(EquipDBCSV);
t0 = T(:,2)';
cluster = T(:,3)';
custo_falha = T(:,4)';

T = csvread(ClusterDBCSV);
eta = T(:,2)';
beta = T(:,3)';

% Otimização do custo de manutenção e de falha esperado
[xBest, fBest, X, Pareto] = SomaPonderada(custo_manutencao, fator_risco,...
    horizonte_tempo, t0, cluster, custo_falha, eta, beta);

plot(Pareto(:,1),Pareto(:,2),'ro');
xlabel('Custo de Manutenção Total'), ylabel('Custo de Falha Total');
title('Fronteira Pareto');

% Avaliação dos critérios
[n, m] = size(X);
G = zeros(n, 2);

for i = 1:n
    plano = X(i, :);
    
    custoPorMaquina = custo_manutencao(plano);
    custoTotalManutencao =  sum(custoPorMaquina);
    
    Ft = wblcdf(t0 + (horizonte_tempo * fator_risco(plano)), ...
        eta(cluster), beta(cluster));
    Ft0 = wblcdf(t0, eta(cluster), beta(cluster));
    probFalha = (Ft - Ft0) ./ (1 - Ft0);
    custoFalhaEsperado = probFalha * custo_falha(:);
    
    G(i, 1) = custoTotalManutencao;
    G(i, 2) = custoFalhaEsperado;
end

% Ajustando a escala
fatorEscala = max(G(:));
normG(:, 1) = fatorEscala * G(:, 1) / sum(G(:, 1));
normG(:, 2) = fatorEscala * G(:, 2) / sum(G(:, 2));
normG(:, 1) = normG(:, 1) / sum(normG(:, 1));
normG(:, 2) = normG(:, 2) / sum(normG(:, 2));

w = [0.6 0.4];

ElectreII(normG, w);
[AHPxBest, AHPfBest] = AHP(X, G, [0.4 0.6]);

% csvwrite('Result.csv', );
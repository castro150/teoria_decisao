ClusterDBCSV = 'ClusterDB.csv';
EquipDBCSV = 'EquipDB.csv';
MPDBCSV = 'MPDB.csv';

% Par�metros
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

% Otimiza��o do custo de manuten��o e de falha esperado
[xBest, fBest, X, Pareto] = Guloso(custo_manutencao, fator_risco, horizonte_tempo, t0, cluster, custo_falha, eta, beta);
csvwrite('Result.csv', X);

for plano = transpose(X)
    custoPorMaquina = custo_manutencao(plano);
    custoTotalManutencao =  sum(custoPorMaquina);
    custoTotalManutencao = custoManutencao(plano, custo_manutencao);
end


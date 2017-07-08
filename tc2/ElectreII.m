function [] = ElectreII(planos)

% Passar para o main:
% Soluções[200, 500]

MPDBCSV = 'MPDB.csv';
EquipDBCSV = 'EquipDB.csv';
ClusterDBCSV = 'ClusterDB.csv';
ExResult = 'ExResult.csv';

% Carrega valores parametros
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

planos = csvread(ExResult); 

[n, m] = size(planos);
planos = zeros(200, 2);


end


MPDBCSV = 'MPDB.csv';
EquipDBCSV = 'EquipDB.csv';
ClusterDBCSV = 'ClusterDB.csv';

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

ExResult = csvread('ExResult.csv');

fVal = zeros(1,200);

n= 500;
for i=1:length(ExResult(:,1))
    x = ExResult(i,:);
    [jx] = fobj(x,n, custo_manutencao, custo_falha, fator_risco, horizonte_tempo, t0, cluster, eta, beta);
    
    fVal(i) = jx;
end
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

csvwrite('CamposCastroViana.csv', X);
X = unique(X, 'rows');

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
    
    Custo(i, 1) = custoTotalManutencao;
    Custo(i, 2) = custoFalhaEsperado;
end

% Ajustando a escala
escala = max(Custo(:));
G(:, 1) = escala * (Custo(:, 1) - min(Custo(:, 1))) ./ (max(Custo(:, 1)) - min(Custo(:, 1)));
G(:, 2) = escala * (Custo(:, 2) - min(Custo(:, 2))) ./ (max(Custo(:, 2)) - min(Custo(:, 2)));

% Como deseja-se o menor valor de cada custo, a escala será invertida
G = escala - G;

w = [0.7 0.3];

% ElectreII
cp = 0.65;
cm = 0.35;
D = 0.75 * escala;
[ElectrexBest, rank] = ElectreII(X, G, w, cp, cm, D);

% PrometheeII
[Sobreclassificacao, xBest, fBest] = PrometheeII(X, G, w);

% AHP
[AHPxBest, AHPfBest] = AHP(X, G, [0.4 0.6]);


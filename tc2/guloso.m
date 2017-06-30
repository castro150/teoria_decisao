%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Depto. de Engenharia Elétrica
%
% Autor:
%   Lucas S. Batista
%
% Atualização: 18/05/2017
%
% Nota:
%   Aproxima o ponto de ótimo (minimização) de um problema irrestrito
%   usando o Algoritmo Simulated Annealing (VERSÃO SIMPLES).
% =========================================================================


function [xbest, jxbest, nfe] = SAdiscreto()
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

nSolucoes = 10000;

M = zeros(nSolucoes,500);
n = 500;
w = [0 0];
for i = 1:nSolucoes   % número de soluções Pareto-ótimas ESTIMADAS
    fprintf('Calculando #%d solucao pareto-otima\n', i);
    
    w(1) = w(1) + 1/nSolucoes;
    w(2) = 1 - w(1);
    
    x = zeros(1,500);
    jxBest = 0;
    for j=1:500
        for k=1:3
            x(j) = k;
            jx = fobjunitario(x, n, w, custo_manutencao, custo_falha, fator_risco, horizonte_tempo, t0, cluster, eta, beta, j);    
            if(k == 1)
                jxBest = jx;
                kBest = k;
            elseif(jx < jxBest)
                jxBest = jx;
                kBest = k;
            end
        end
        x(j) = kBest;
    end
    
    M(i,:) = x;
end
fprintf('\n')

csvwrite('Result.csv',M);

lEvalHVI


%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Depto. de Engenharia Elétrica
%
% Autores:
%   Davi Pinheiro Viana
%   Rafael Carneiro de Castro
%   Vinícius
%
% Atualização: 08/07/2017
%
% Nota:
%   Calcula o otimo da modelagem biojetivo do problema da definicao do
% plano de manutencao dos equipamentos.
% =========================================================================

function [xBest, fBest, X, Pareto] = Guloso()
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

nSolucoes = 1000;

w1 = 0:1/nSolucoes:1;
w2 = 1:-1/nSolucoes:0;
X = zeros(nSolucoes,500);
Pareto = zeros(nSolucoes, 2);
for i = 1:length(w1)
    if(i == 1 || mod(i,(nSolucoes/10)) == 0)
        fprintf('Calculando #%d solucao pareto-otima\n', i);
    end
    
    x = zeros(1,500);
    fBest = 0;
    sum_f1 = 0;
    sum_f2 = 0;
    for j=1:500
        for k=1:3
            f1 = fobj1(k, custo_manutencao);
            f2 = fobj2(k, horizonte_tempo, fator_risco, t0(j), ...
            cluster(j), eta, beta, custo_falha(j));
            
            fobj = w1(i)*f1 + w2(i)*f2;
            if(k == 1)
                fBest = fobj;
                kBest = k;
            elseif(fobj < fBest)
                fBest = fobj;
                kBest = k;
            end
        end
        sum_f1 = sum_f1 + w1(i)*f1;
        sum_f2 = sum_f2 + w2(i)*f2;
        x(j) = kBest;
    end
    
    Pareto(i,:) = [sum_f1  sum_f2]';
    X(i,:) = x;
    
    if(i == 1 || x < xBest)
        xBest = x;
    end
    if(i == 1 || (sum_f1 + sum_f2) < fBest)
        fBest = sum_f1 + sum_f2;
    end
end
fprintf('\n')
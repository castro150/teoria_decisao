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

function [xBest, fBest, X, Pareto] = SomaPonderada(custo_manutencao, ...
    fator_risco, horizonte_tempo, t0, cluster, custo_falha, eta, beta)
nSolucoes = 1000;

w1 = 0:1/nSolucoes:1;
w2 = 1:-1/nSolucoes:0;
X = zeros(nSolucoes,500);
Pareto = zeros(nSolucoes, 2);

fBest = 0;
for i = 1:nSolucoes
    if(i == 1 || mod(i,(nSolucoes/10)) == 0)
        fprintf('Calculando #%d solucao pareto-otima\n', i);
    end
    
    [x, f1, f2] = Guloso(500, w1(i), w2(i), custo_manutencao,...
        fator_risco, horizonte_tempo, t0, cluster, custo_falha, eta, beta);
    
    Pareto(i,:) = [f1  f2]';
    X(i,:) = x;
    
    if(i == 1 || (f1 + f2) < fBest)
        xBest = x;
        fBest = f1 + f2;
    end
end
fprintf('\n')
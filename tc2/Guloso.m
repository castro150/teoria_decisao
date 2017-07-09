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

function [x, sum_f1, sum_f2] = Guloso(n, w1, w2, custo_manutencao, fator_risco, ...
    horizonte_tempo, t0, cluster, custo_falha, eta, beta)

x = zeros(1, n);
sum_f1 = 0;
sum_f2 = 0;
for j=1:n
    for k=1:3
        f1 = fobj1(k, custo_manutencao);
        f2 = fobj2(k, horizonte_tempo, fator_risco, t0(j), ...
        cluster(j), eta, beta, custo_falha(j));

        fobj = w1*f1 + w2*f2;
        if(k == 1)
            fBest = fobj;
            kBest = k;
            f1Best = f1;
            f2Best = f2;
        elseif(fobj < fBest)
            fBest = fobj;
            kBest = k;
            f1Best = f1;
            f2Best = f2;
        end
    end
    sum_f1 = sum_f1 + f1Best;
    sum_f2 = sum_f2 + f2Best;
    x(j) = kBest;
end
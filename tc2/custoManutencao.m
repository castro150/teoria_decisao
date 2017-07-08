%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Depto. de Engenharia Elétrica
%
% Nota:
%   Cálculo do custo de manutenção para dado plano
% 
% Entradas:
%   planoManutencao: plano de manutenção de cada equipamento
%   custoManutencaoCluster: custo de cada plano
%
% Saída:
%   custoTotal: custo total para o plano de manutenção escolhido
% =========================================================================

function custoTotalManutencao = custoManutencao(planoManutencao, custoManutencao)
    custoPorMaquina = custoManutencao(planoManutencao);
    custoTotalManutencao =  sum(custoPorMaquina);
end


%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Depto. de Engenharia El�trica
%
% Nota:
%   C�lculo do custo de manuten��o para dado plano
% 
% Entradas:
%   planoManutencao: plano de manuten��o de cada equipamento
%   custoManutencaoCluster: custo de cada plano
%
% Sa�da:
%   custoTotal: custo total para o plano de manuten��o escolhido
% =========================================================================

function custoTotalManutencao = custoManutencao(planoManutencao, custoManutencao)
    custoPorMaquina = custoManutencao(planoManutencao);
    custoTotalManutencao =  sum(custoPorMaquina);
end


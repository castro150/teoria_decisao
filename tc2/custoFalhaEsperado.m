%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Depto. de Engenharia Elétrica
%
% Nota:
%   Calculo do custo de manutenção para dado plano
% 
% Entradas:
%   planoManutencao: plano de manutenção de cada equipamento
%
%   custoFalhaEquip: custo decorrente da eventual falha do equipamento
%
%   fatorRisco: utilizado como multiplicador do tempo para o qual se
%       está estimando a probabilidade de falha do equipamento
%
%   horizonteTempo: horizonte de planejamento da manutenção
%
%   t0: tempo em que o equipamento est´a operando desde sua data de
%       instalação até o dia atual
%
%   cluster: código do cluster (grupo) que melhor modela a probabilidade
%       de falha daquele equipamento
%
%   eta e beta: parâmetros de escala do modelo de Weibull que descrevem o 
%       cluster
%
% =========================================================================

function custoFalhaEsperado = custoFalhaEsperado(planoManutencao, custoFalhaEquip, fatorRisco, horizonteTempo, t0, cluster, eta, beta)
    Ft = wblcdf(t0 + (horizonteTempo * fatorRisco(planoManutencao)), eta(cluster), beta(cluster));
    Ft0 = wblcdf(t0, eta(cluster), beta(cluster));
    probFalha = (Ft - Ft0) / (1 - Ft0);
    custoFalhaEsperado = probFalha * custoFalhaEquip(:);
end


%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Depto. de Engenharia El�trica
%
% Nota:
%   Calculo do custo de manuten��o para dado plano
% 
% Entradas:
%   planoManutencao: plano de manuten��o de cada equipamento
%
%   custoFalhaEquip: custo decorrente da eventual falha do equipamento
%
%   fatorRisco: utilizado como multiplicador do tempo para o qual se
%       est� estimando a probabilidade de falha do equipamento
%
%   horizonteTempo: horizonte de planejamento da manuten��o
%
%   t0: tempo em que o equipamento est�a operando desde sua data de
%       instala��o at� o dia atual
%
%   cluster: c�digo do cluster (grupo) que melhor modela a probabilidade
%       de falha daquele equipamento
%
%   eta e beta: par�metros de escala do modelo de Weibull que descrevem o 
%       cluster
%
% =========================================================================

function custoFalhaEsperado = custoFalhaEsperado(planoManutencao, custoFalhaEquip, fatorRisco, horizonteTempo, t0, cluster, eta, beta)
    Ft = wblcdf(t0 + (horizonteTempo * fatorRisco(planoManutencao)), eta(cluster), beta(cluster));
    Ft0 = wblcdf(t0, eta(cluster), beta(cluster));
    probFalha = (Ft - Ft0) / (1 - Ft0);
    custoFalhaEsperado = probFalha * custoFalhaEquip(:);
end


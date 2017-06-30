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
%   Define a função objetivo.
% =========================================================================


function [f] = fobjunitario(x, n, w, custo_manutencao, custo_falha, fator_risco, horizonte_tempo, t0, cluster, eta, beta, i)

% Problema de Designação Simples:
% Considere que existem n tarefas e n agentes, de tal forma
% que cada tarefa deve ser atribuída a um agente e cada
% agente só pode receber uma tarefa. A execução da tarefa i
% pelo agente j tem um custo cij. Formule um problema que
% atribua as tarefas de forma a minimizar o custo total de
% execução.

f_cm = 0;
f_cf = 0;
f_cm = f_cm + custo_manutencao(x(i));


deltaT = horizonte_tempo * fator_risco(x(i));

Ft = wblcdf(t0(i) + deltaT ,eta(cluster(i)),beta(cluster(i)));
Ft0 = wblcdf(t0(i), eta(cluster(i)), beta(cluster(i)));
Risk = (Ft - Ft0) / (1 - Ft0);
FailCost = Risk * custo_falha(i);

f_cf = f_cf + FailCost;

f =w(1)* f_cm + w(2)*f_cf;
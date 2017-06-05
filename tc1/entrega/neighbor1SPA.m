%==========================================================================
% Universidade Federal de Minas Gerais
%
% Alunos:
%   Davi Pinheiro Viana (2013029912)
%   Rafael Carneiro de Castro (2013030210)
%
% Engenharia de Sistemas
%
% Nota:
%   Define a vizinhan�a baseado na troca de m�quinas de uma tarefa.
% =========================================================================
function [y] = neighbor1SPA(x)

y = x;
M = size(x, 2);
N = size(x, 1);

task = randi(N);
% Escolhendo uma das quatro m�quinas que n�o fazem a tarefa
% para faz�-la a partir de agora.
machine = randi(4);

if (y(task, machine) == 1)
    % Se a m�quina escolhida j� faz a tarefa, basta escolher a pr�xima
    y(task, :) = zeros(1, M);
    y(task, machine + 1) = 1;
else
    % Se a m�quina escolhida estiver dispon�vel, basta us�-la
    y(task, :) = zeros(1, M);
    y(task, machine) = 1;
end
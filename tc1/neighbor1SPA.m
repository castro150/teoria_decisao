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
%   Define a vizinhança baseado na troca de máquinas de uma tarefa.
% =========================================================================
function [y] = neighbor1SPA(x)

y = x;
M = size(x, 2);
N = size(x, 1);

task = randi(N);
% Escolhendo uma das quatro máquinas que não fazem a tarefa
% para fazê-la a partir de agora.
machine = randi(4);

if (y(task, machine) == 1)
    % Se a máquina escolhida já faz a tarefa, basta escolher a próxima
    y(task, :) = zeros(1, M);
    y(task, machine + 1) = 1;
else
    % Se a máquina escolhida estiver disponível, basta usá-la
    y(task, :) = zeros(1, M);
    y(task, machine) = 1;
end
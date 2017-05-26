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
%   Define a vizinhança baseado na troca de máquinas para uma quantidade
%   n de tarefas.
% =========================================================================
function [y] = neighbor1TE(x, n)

y = x;
M = size(x, 2);
N = size(x, 1);

tasks = randi(N, 1, n);
for i = 1:n
    % Escolhendo uma das quatro máquinas que não fazem a tarefa i
    % para fazê-la a partir de agora.
    machine = randi(4);
    
    if (y(tasks(i), machine) == 1)
        % Se a máquina escolhida já faz a tarefa, basta escolher a próxima
        y(tasks(i), :) = zeros(1, M);
        y(tasks(i), machine + 1) = 1;
    else
        % Se a máquina escolhida estiver disponível, basta usá-la
        y(tasks(i), :) = zeros(1, M);
        y(tasks(i), machine) = 1;
    end
end
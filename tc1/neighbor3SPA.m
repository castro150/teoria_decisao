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
%   Define a vizinhança baseado na troca de todas as tarefas de duas
%   máquinas, sem alterar a ordem entre elas na máquina.
% =========================================================================
function [y] = neighbor3SPA(x)

y = x;
M = size(x, 2);

machines = randi(M, 1, 2);
temp = y(:, machines(1));
y(:, machines(1)) = y(:, machines(2));
y(:, machines(2)) = temp;

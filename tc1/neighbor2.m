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
%   Define a vizinhança baseado na troca de tarefas entre duas máquinas.
% =========================================================================
function [y] = neighbor2(x)

y = x;
N = size(x, 1);

machines = randi(N, 1, 2);
temp = y(machines(1), :);
y(machines(1), :) = y(machines(2), :);
y(machines(2), :) = temp;

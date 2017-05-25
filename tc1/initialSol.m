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
%   Define uma solução inicial para o problema da minimização do
%   tempo total de entrega.
% =========================================================================
function [x,M,N] = initialSol()

M = 5;
N = 25;
x = zeros(N, M);

% Uma solução para o problema é uma matriz cujas linhas são compostas
% por 0s, e apenas um número 1, que representa a máquina que faz a tarefa
% correspondente a aquela linha.
for i = 1:N
    machine = randi(5);
    x(i, machine) = 1;
end
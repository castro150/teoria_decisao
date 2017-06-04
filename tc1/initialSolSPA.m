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
%   Define uma solução inicial para o problema da minimização da
%   soma ponderada dos atrasos e adiantamentos.
% =========================================================================
function [x, order, M, N] = initialSolSPA()

M = 5;
N = 25;
x = initialSolTE();

% Uma solução para este problema possui o mesmo formato da solução do
% problema da minimização do tempo de entrega, acrescido de um vetor
% que representa a ordem em que as tarefas são feitas.

% Cria uma ordem aleatória das N tarefas
order = randperm(N);
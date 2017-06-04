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
%   Define uma solu��o inicial para o problema da minimiza��o da
%   soma ponderada dos atrasos e adiantamentos.
% =========================================================================
function [x, order, M, N] = initialSolSPA()

M = 5;
N = 25;
x = initialSolTE();

% Uma solu��o para este problema possui o mesmo formato da solu��o do
% problema da minimiza��o do tempo de entrega, acrescido de um vetor
% que representa a ordem em que as tarefas s�o feitas.

% Cria uma ordem aleat�ria das N tarefas
order = randperm(N);
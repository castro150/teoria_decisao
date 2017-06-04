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
function [x, M, N] = initialSolSPA()

M = 5;
N = 25;
x = zeros(M, N);

% Uma solu��o para o problema � uma matriz cujas linhas s�o compostas
% por inteiros entre 1 e N, sendo que estas s�o as tarefas executadas
% pela m�quina daquela linha, na ordem que aparecem na linha. Existem
% posi��es na matriz preenchidas com 0, para que a diemns�o da mesma
% seja sempre constante.

% Cria uma ordem aleat�ria das N tarefas
taskOrder = randperm(N);

% Cria uma divis�o das tarefas para as M m�quinas, partindo o vetor
% das tasks em M partes, ou seja, com M - 1 cortes
machineOrder = sort(randperm(N, M - 1));

% Guarda a partir de qual tarefa a pr�xima m�quina recebe tarefas
nextToOrganize = 1;

% Divis�o das tarefas entre as m�quinas
for i = 1:(M - 1)
    temp = x(i,:);
    temp(1:(machineOrder(i) - nextToOrganize + 1)) = taskOrder(nextToOrganize:machineOrder(i));
    x(i,:) = temp;
    nextToOrganize = machineOrder(i) + 1;
end
% Dividindo tarefas para a �ltima m�quina
temp = x(M,:);
temp(1:(N - nextToOrganize + 1)) = taskOrder(nextToOrganize:N);
x(M,:) = temp;
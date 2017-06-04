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
function [x, M, N] = initialSolSPA()

M = 5;
N = 25;
x = zeros(M, N);

% Uma solução para o problema é uma matriz cujas linhas são compostas
% por inteiros entre 1 e N, sendo que estas são as tarefas executadas
% pela máquina daquela linha, na ordem que aparecem na linha. Existem
% posições na matriz preenchidas com 0, para que a diemnsão da mesma
% seja sempre constante.

% Cria uma ordem aleatória das N tarefas
taskOrder = randperm(N);

% Cria uma divisão das tarefas para as M máquinas, partindo o vetor
% das tasks em M partes, ou seja, com M - 1 cortes
machineOrder = sort(randperm(N, M - 1));

% Guarda a partir de qual tarefa a próxima máquina recebe tarefas
nextToOrganize = 1;

% Divisão das tarefas entre as máquinas
for i = 1:(M - 1)
    temp = x(i,:);
    temp(1:(machineOrder(i) - nextToOrganize + 1)) = taskOrder(nextToOrganize:machineOrder(i));
    x(i,:) = temp;
    nextToOrganize = machineOrder(i) + 1;
end
% Dividindo tarefas para a última máquina
temp = x(M,:);
temp(1:(N - nextToOrganize + 1)) = taskOrder(nextToOrganize:N);
x(M,:) = temp;
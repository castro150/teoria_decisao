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
%   Define a vizinhan�a baseado na troca de ordem entre duas darefas de
%   uma mesma m�quina.
% =========================================================================
function [y, newOrder] = neighbor2SPA(x, order)

y = x;
newOrder = order;
M = size(x, 2);

% Definindo uma m�quina que vai ter duas tarefas trocadas de ordem
machine = randi(M);

% Obtendo todas as tarefas desta m�quina
tasksInMachine = find(y(:,machine));

% Escolhendo aleatoriamente duas tarefas dentre as da m�quina para
% trocarem de ordem
if(length(tasksInMachine) ~= 0)
    tasksToChange = randi(length(tasksInMachine), 1, 2);

    % Obtendo a ordem atual das duas tarefas
    orderTask1 = find(newOrder == tasksInMachine(tasksToChange(1)));
    orderTask2 = find(newOrder == tasksInMachine(tasksToChange(2)));

    % Trocando as ordens entre si
    temp = newOrder(orderTask1);
    newOrder(orderTask1) = newOrder(orderTask2);
    newOrder(orderTask2) = temp;
end
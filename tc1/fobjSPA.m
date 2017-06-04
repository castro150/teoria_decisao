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
%   Define a função objetivo para somatorio dos atrasos e adiantamentos.
% =========================================================================
function f = fobjSPA(x, order, t, w, d)

M = length(x(1,:));

f = 0;
for j = 1:M
    % Extrai todas as tarefas de uma máquina
    tasksInMachine = find(x(:,j));
    
    % Percorre as tarefas da máquina
    for k = 1:length(tasksInMachine)
        e = 0;
        
        % Percorre o vetor de ordenação das tarefas
        for i = 1:length(order)
            % Se a tarefa atual está entre as tarefas da máquina,
            % soma o tempo dela no e.
            if (isempty(tasksInMachine(tasksInMachine == order(i))) == 0)
                e = e + t(j,order(i));
            end
            
            % Se já chegou na tarefa de avaliação atual, sair do loop
            if (order(i) == tasksInMachine(k))
                break;
            end
        end
        
        % Soma a penalidade pelo atraso da tarefa de avaliação atual
        f = f + w(tasksInMachine(k))*abs(e-d);
    end
end
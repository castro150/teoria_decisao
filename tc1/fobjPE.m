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
%   Define a função objetivo para o problema da minimização da soma
%   ponderada dos objetivos: tempo total de entrega e soma dos atrasos e
%   adiantamentos.
% =========================================================================
function f = fobjPE(x, t, w, d)

nTarefas = length(x(:,1));
nMaquinas = length(x(1,:));
C = zeros(nMaquinas, 1);

% Obtendo o tempo de operação de cada máquina.
for i = 1:nMaquinas
    C(i) = t(i, :)*x(:, i);
end

% Extraindo o maior tempo entre as máquinas.
f1 = max(C);


e = zeros(1, nTarefas);

f2 = 0;
for i=1:nTarefas
    maquina = find(x(i,:));
    
    for j=1:i
        e(i) = e(i)+x(j,maquina)*t(maquina,j);
    end
    
    f2 = f2 + w(i)*abs(e(i)-d);
end

f = [f1 f2]';
end
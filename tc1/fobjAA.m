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
function f = fobjAA(x, t, w, d)

nTarefas = length(x(:,1));

e = zeros(1, nTarefas);

f = 0;
for i=1:nTarefas
    maquina = find(x(i,:));
    
    for j=1:i
        e(i) = e(i)+x(j,maquina)*t(maquina,j);
    end
    
    f = f + w(i)*abs(e(i)-d);
end

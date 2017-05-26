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
%   Define a função objetivo
% =========================================================================
function [f] = fobj(x, t)

M = size(x, 2);
C = zeros(M, 1);

% Obtendo o tempo de operação de cada máquina.
for i = 1:M
    C(i) = t(i, :)*x(:, i);
end

% Extraindo o maior tempo entre as máquinas.
f = max(C);
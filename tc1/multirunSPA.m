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
%   Execu��es multiplas de um algoritmo.
% =========================================================================
n = 100;

xbest = zeros(25, 5, n);
jxbest = zeros(1, n);
nfe = zeros(1, n);

for i = 1:n
    [xbest(:, :, i), jxbest(i), nfe(i)] = minAtrasoAdiantamento(0.9);
    fprintf('#%d\n', i);
end

figure;
subplot(2,1,1);
plot(1:n, jxbest, 'b', 1:n, mean(jxbest), 'black');
title('Valores de �timo');
xlabel('N�mero da execu��o do algoritmo');
ylabel('Valor �timo encontrado');

subplot(2,1,2);
plot(1:n, nfe, 'r', 1:n, mean(nfe), 'black');
title('N�mero de itera��es');
xlabel('N�mero da execu��o do algoritmo');
ylabel('N�mero de itera��es');
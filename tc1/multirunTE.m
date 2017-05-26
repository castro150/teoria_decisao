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
%   Execuções multiplas de um algoritmo.
% =========================================================================
n = 100;

xbest = zeros(25, 5, n);
jxbest = zeros(1, n);
nfe = zeros(1, n);

for i = 1:n
    [xbest(:, :, i), jxbest(i), nfe(i)] = minTempoEntrega(0.01, 1);
    fprintf('#%d\n', i);
end

plot(jxbest);
%0.1 ficou 3 ficou interessante
%0.1 ficou 1 ficou melhor

% fprintf('\n')
% 
% figure
% plot(0:size(memoryfile,1)-1,memoryfile(:,end),'k-','linewidth',2)
% xlabel('Número de iterações')
% ylabel('Valor da função objetivo')
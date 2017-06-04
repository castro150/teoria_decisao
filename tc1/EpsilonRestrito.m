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
%   Estrategia epsilon-restrito para minimizacao dos objetivos tempo total
%   de entrega e soma dos atrasos e adiantamentos.
% =========================================================================

clear all
close all
clc


fobj = @fobj1;  % problema de otimiza��o multiobjetivo
n = 2;          % n�mero de vari�veis de decis�o
m = 2;          % n�mero de objetivos

nef  = 1000;
xlim = repmat([0 1],1,n);
lb = xlim(1:2:end);
ub = xlim(2:2:end);


% Determina a solu��o ut�pica usando Pw
I = eye(m);
for k = 1:m
    xo = rand(n,1);
    w  = I(:,k);
    X(:,k)  = SAreal(@(x) problemaPw(fobj,x,w), xo, xlim);
    jX(:,k) = fobj(X(:,k));    
end
eps = [ min(jX,[],2) max(jX,[],2) ];


xo = (ub(:)-lb(:)).*rand(n,1) + lb(:);  % gera solu��o inicial

for i = 1:100   % n�mero de solu��es Pareto-�timas ESTIMADAS
    
    e = (eps(:,2)-eps(:,1)).*rand(m,1) + eps(:,1);
    
    X(:,i) = SAreal(@(x) problemaPe(fobj,x,e), xo, xlim);
        
    jX(:,i) = fobj(X(:,i));
    
    xo = X(:,i);
    
end

plot(jX(1,:),jX(2,:),'ro')
xlabel('f1'), ylabel('f2')

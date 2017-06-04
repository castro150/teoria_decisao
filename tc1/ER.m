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
%   Estrategia da soma ponderada para minimizacao dos objetivos tempo total
%   de entrega e soma dos atrasos e adiantamentos.
% =========================================================================

clear all
close all
clc


fobj = [@fobjTE @fobjAA]';
n = 2;          % número de variáveis de decisão
m = 2;          % número de objetivos

%nef  = 1000;
%xlim = repmat([0 1],1,n);
%lb = xlim(1:2:end);
%ub = xlim(2:2:end);

%xo = (ub(:)-lb(:)).*rand(n,1) + lb(:);  % gera solução inicial

%for i = 1:100   % número de soluções Pareto-ótimas ESTIMADAS

%    w = rand(m,1);
%    w = w/sum(w);       
    
%    X(:,i) = SAreal(@(x) problemaPw(fobj,x,w), xo, xlim);
    
    %X(:,i) = randomsearch(@(x) problemaPw(fobj,x,w), xo, nef, xlim);
    
    %options = saoptimset('MaxFunEvals', 100, 'Display', 'off');
    %X(:,i) = simulannealbnd(@(x) problemaPw(fobj,x,w), xo, lb, ub, options);
    
%    jX(:,i) = fobj(X(:,i));
    
%    xo = X(:,i);
    
%end

% Plota espaço de objetivos se m = 2 ou m = 3
%if m == 2    
%    plot(jX(1,:),jX(2,:),'ro')
%    xlabel('f1'), ylabel('f2')      
%elseif m == 3
%    plot3(jX(1,:),jX(2,:),jX(3,:), 'ro')
%    xlabel('f1'), ylabel('f2'), zlabel('f3')
%    box on
%end

% Plota espaço de decisão se n = 2 ou n = 3
%if n == 2
%    figure
%    plot(X(1,:),X(2,:),'ro')
%    xlabel('x1'), ylabel('x2')      
%elseif n == 3
%    figure
%    plot3(X(1,:),X(2,:),X(3,:), 'ro')
%    xlabel('x1'), ylabel('x2'), zlabel('x3')
%    box on
%end



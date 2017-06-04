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
%   Estratégia para escolha de soluções de programação de compromisso
% =========================================================================

clear all
close all
clc

fobj = @fobjPW;

u = 0.1;
n = 1;
m = 2;          % número de objetivos
f_estrela = [14 400]';
r = 0.5;

[xo, ~, N] = initialSolTE();

load('i5x25.mat');
for i = 1:100   % número de soluções Pareto-ótimas ESTIMADAS

    w = rand(1,m);
    w = w/sum(w);       
    
    % INICIO
    k = 0;
    
    % Contadordo número de avaliações de f(.)
    nfe = 0; 

    % Temperatura inicial
    t = 100;
    
    [jxs] = fobjPW(xo, PT, WE, DD);
    jx = 0;
    for j=1:m
        jx = jx + w(j)*(abs(jxs(j) - f_estrela(j))^r);
    end
    jx = jx^(1/r);
    
    nfe = nfe + 1; 

    % Armazena melhor solução encontrada
    xbest  = xo;
    jxbest = jx;

    % Critério de parada do algoritmo
    numEstagiosEstagnados = 0;

    % Critério de parada
    while (numEstagiosEstagnados <= 10 && nfe < 2000) 

        % Critérios para mudança de temperatura
        numAceites = 0;
        numTentativas = 0;

        % Fitness da solução submetida ao estágio k
        fevalin = jxbest;

        while (numAceites < 3*N && numTentativas < 25*N)

            % Gera uma solução na vizinhança de x
            temp = neighbor1TE(xo, n);
            y = neighbor2TE(temp);
            [jys] = fobjPW(y, PT, WE, DD);
            
            jy = 0;
            for j=1:m
                jy = jy + w(j)*(abs(jys(j) - f_estrela(j))^r);
            end
            jy = jy^(1/r);
            
            nfe = nfe + 1;

            % Atualiza solução    
            DeltaE = jy - jx;
            if (DeltaE <= 0 || rand <= exp(-DeltaE/t))
                xo = y;
                jx = jy;            
                numAceites = numAceites + 1;

                % Atualiza melhor solução encontrada
                if (jx < jxbest)
                    xbest  = xo;
                    jxbest = jx;                
                end        
            end
            numTentativas = numTentativas + 1;   
        end

        % Atualiza a temperatura
        t = u*t;

        % Avalia critério de estagnação
        if (jxbest < fevalin)
            numEstagiosEstagnados = 0;
        else
            numEstagiosEstagnados = numEstagiosEstagnados + 1;        
        end

        % Atualiza contador de estágios de temperatura
        k = k + 1;
    end
    
    %FIM
    
    X(:,:,i) = xo;
    
    jX(:,i) = fobjPW(xo, PT, WE, DD);
    
    xo = X(:,:,i);
    
end

% Plota espaço de objetivos se m = 2 ou m = 3
plot(jX(1,:),jX(2,:),'ro')
xlabel('f1'), ylabel('f2')

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



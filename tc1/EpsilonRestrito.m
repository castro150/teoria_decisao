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


fobj = @fobjPE;  % problema de otimiza��o multiobjetivo

u = 0.1;
n = 1;
m = 2;          % n�mero de objetivos

nef  = 1000;
xlim = repmat([0 1],1,n);

[xo, ~, N] = initialSolTE();
load('i5x25.mat');
I = eye(m);
for k = 1:m
    w  = I(:,k);
    
    % INICIO
    k = 0;
    
    % Contadordo n�mero de avalia��es de f(.)
    nfe = 0; 

    % Temperatura inicial
    t = 100;
    
    [jxs] = fobjPW(xo, PT, WE, DD);
    jx = (w')*jxs;
    
    nfe = nfe + 1; 

    % Armazena melhor solu��o encontrada
    xbest  = xo;
    jxbest = jx;

    % Crit�rio de parada do algoritmo
    numEstagiosEstagnados = 0;

    % Crit�rio de parada
    while (numEstagiosEstagnados <= 10 && nfe < 2000) 

        % Crit�rios para mudan�a de temperatura
        numAceites = 0;
        numTentativas = 0;

        % Fitness da solu��o submetida ao est�gio k
        fevalin = jxbest;

        while (numAceites < 3*N && numTentativas < 25*N)

            % Gera uma solu��o na vizinhan�a de x
            temp = neighbor1TE(xo, n);
            y = neighbor2TE(temp);
            [jys] = fobjPW(y, PT, WE, DD);
            jy = (w')*jys;
            nfe = nfe + 1;

            % Atualiza solu��o    
            DeltaE = jy - jx;
            if (DeltaE <= 0 || rand <= exp(-DeltaE/t))
                xo = y;
                jx = jy;            
                numAceites = numAceites + 1;

                % Atualiza melhor solu��o encontrada
                if (jx < jxbest)
                    xbest  = xo;
                    jxbest = jx;                
                end        
            end
            numTentativas = numTentativas + 1;   
        end

        % Atualiza a temperatura
        t = u*t;

        % Avalia crit�rio de estagna��o
        if (jxbest < fevalin)
            numEstagiosEstagnados = 0;
        else
            numEstagiosEstagnados = numEstagiosEstagnados + 1;        
        end

        % Atualiza contador de est�gios de temperatura
        k = k + 1;
    end
    
    %FIM
    
    X(:,:,k)  = xo;
    
    jX(:,k) = fobjPW(xo, PT, WE, DD);    
end
eps = [ min(jX,[],2) max(jX,[],2) ];


[xo, ~, N] = initialSolTE();

for i = 1:100   % n�mero de solu��es Pareto-�timas ESTIMADAS
    
    e = (eps(:,2)-eps(:,1)).*rand(m,1) + eps(:,1);
    
    % INICIO
    k = 0;
    
    % Contadordo n�mero de avalia��es de f(.)
    nfe = 0; 

    % Temperatura inicial
    t = 100;
    
    [jxs] = fobjPW(xo, PT, WE, DD);
    jfobj  = 2;             % �ndice da fun��o objetivo a ser minimizada
    jconst = 1:length(jxs);
    jconst(jfobj) = [];
    jx = jxs(jfobj) + 1000 * sum( max(0,jxs(jconst)-e(jconst)).^2 );
    
    nfe = nfe + 1; 

    % Armazena melhor solu��o encontrada
    xbest  = xo;
    jxbest = jx;

    % Crit�rio de parada do algoritmo
    numEstagiosEstagnados = 0;

    % Crit�rio de parada
    while (numEstagiosEstagnados <= 10 && nfe < 2000) 

        % Crit�rios para mudan�a de temperatura
        numAceites = 0;
        numTentativas = 0;

        % Fitness da solu��o submetida ao est�gio k
        fevalin = jxbest;

        while (numAceites < 3*N && numTentativas < 25*N)

            % Gera uma solu��o na vizinhan�a de x
            temp = neighbor1TE(xo, n);
            y = neighbor2TE(temp);
            [jys] = fobjPW(y, PT, WE, DD);
            jfobj  = 2;             % �ndice da fun��o objetivo a ser minimizada
            jconst = 1:length(jys);
            jconst(jfobj) = [];
            jy = jys(jfobj) + 1000 * sum( max(0,jys(jconst)-e(jconst)).^2 );
            
            nfe = nfe + 1;

            % Atualiza solu��o    
            DeltaE = jy - jx;
            if (DeltaE <= 0 || rand <= exp(-DeltaE/t))
                xo = y;
                jx = jy;            
                numAceites = numAceites + 1;

                % Atualiza melhor solu��o encontrada
                if (jx < jxbest)
                    xbest  = xo;
                    jxbest = jx;                
                end        
            end
            numTentativas = numTentativas + 1;   
        end

        % Atualiza a temperatura
        t = u*t;

        % Avalia crit�rio de estagna��o
        if (jxbest < fevalin)
            numEstagiosEstagnados = 0;
        else
            numEstagiosEstagnados = numEstagiosEstagnados + 1;        
        end

        % Atualiza contador de est�gios de temperatura
        k = k + 1;
    end
    
    %FIM
    
    X(:,:,i)  = xo;
        
    jX(:,i) = fobjPW(xo, PT, WE, DD);
    
    xo = X(:,:,i);
    
end

plot(jX(1,:),jX(2,:),'ro')
xlabel('f1'), ylabel('f2')

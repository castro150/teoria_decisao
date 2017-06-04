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
%
% Parametros:
%   u: taxa de decaimento da temperatura
%
% Retorno:
%   X: valores das solucoes pareto-otimas
%  jX: Imagem de X
% 
% Exemplo de execucao: somaPonderada(0.1,1);
% =========================================================================
function [X, jX] = epsilonRestrito(u)

m = 2;          % n�mero de objetivos
[xo, order, N] = initialSolSPA();

% Determina a solu��o utopica usando Pw +++++++++++++++++++++++++++++++++++
load('i5x25.mat');
I = eye(m);
for k = 1:m
    w  = I(:,k);
    
    %-----------------------------Inicio do SA-----------------------------
    l = 0;
    
    % Contadordo n�mero de avalia��es de f(.)
    nfe = 0; 

    % Temperatura inicial
    t = 100;
    
    % Calcula funcao objetivo da soma ponderada
    f1 = fobjTE(xo, PT);
    f2 = fobjSPA(xo, order, PT, WE, DD);
    jx = w(1)*f1 + w(2)*f2;
    
    nfe = nfe + 1; 

    % Armazena melhor solu��o encontrada
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
            if (numEstagiosEstagnados == 5)
                % Se certo n�mero de est�gios estagnados for alcan�ado, uma
                % fun��o de vizinhan�a que gera solu��es mais espa�adas � 
                % chamada, de forma a criar uma solu��o numa regi�o n�o
                % explorada mais distante
                y = neighbor3SPA(xo);
            else
                temp = neighbor1SPA(xo);
                [y, order] = neighbor2SPA(temp, order);
            end
            
            % Avalia nova solucao gerada
            f1 = fobjTE(y, PT);
            f2 = fobjSPA(y, order, PT, WE, DD);
            jy = w(1)*f1 + w(2)*f2;
            
            nfe = nfe + 1;

            % Atualiza solu��o    
            DeltaE = jy - jx;
            if (DeltaE <= 0 || rand <= exp(-DeltaE/t))
                xo = y;
                jx = jy;            
                numAceites = numAceites + 1;

                % Atualiza melhor solu��o encontrada
                if (jx < jxbest)
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
        l = l + 1;
    end
    %------------------------------Fim do SA-------------------------------
    
    % Armazena solucao encontrada
    X(:,:,k) = xo;
    
    f1 = fobjTE(xo, PT);
    f2 = fobjSPA(xo, order, PT, WE, DD);
    jX(:,k) = [f1  f2]';
    
    % Atualiza solucao
    xo = X(:,:,k);
end
eps = [ min(jX,[],2) max(jX,[],2) ];
% Fim da determinacao da solucao utopica usando Pw ++++++++++++++++++++++++


% Inicio da obtencao das solucoes pareto-otimas +++++++++++++++++++++++++++
[xo, order, N] = initialSolSPA();
for i = 1:100   % n�mero de solu��es Pareto-�timas ESTIMADAS
    fprintf('Calculando #%d solucao pareto-otima\n', i);
    e = (eps(:,2)-eps(:,1)).*rand(m,1) + eps(:,1);
    
    %-----------------------------Inicio do SA-----------------------------
    k = 0;
    
    % Contadordo n�mero de avalia��es de f(.)
    nfe = 0; 

    % Temperatura inicial
    t = 100;
    
    % Calcula funcao objetivo do epsilon-restrito
    f1 = fobjTE(xo, PT);
    f2 = fobjSPA(xo, order, PT, WE, DD);
    jx = f2 + 1000 * sum( max(0,f1-e(1)).^2 );
    
    nfe = nfe + 1; 

    % Armazena melhor solu��o encontrada
    
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
            if (numEstagiosEstagnados == 5)
                % Se certo n�mero de est�gios estagnados for alcan�ado, uma
                % fun��o de vizinhan�a que gera solu��es mais espa�adas � 
                % chamada, de forma a criar uma solu��o numa regi�o n�o
                % explorada mais distante
                y = neighbor3SPA(xo);
            else
                temp = neighbor1SPA(xo);
                [y, order] = neighbor2SPA(temp, order);
            end
            
            % Avalia nova solucao gerada
            f1 = fobjTE(y, PT);
            f2 = fobjSPA(y, order, PT, WE, DD);
            jy = f2 + 1000 * sum( max(0,f1-e(1)).^2 );
            
            nfe = nfe + 1;

            % Atualiza solu��o    
            DeltaE = jy - jx;
            if (DeltaE <= 0 || rand <= exp(-DeltaE/t))
                xo = y;
                jx = jy;            
                numAceites = numAceites + 1;

                % Atualiza melhor solu��o encontrada
                if (jx < jxbest)
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
    %------------------------------Fim do SA-------------------------------
    
    % Armazena solucao encontrada
    X(:,:,i) = xo;
    
    f1 = fobjTE(xo, PT);
    f2 = fobjSPA(xo, order, PT, WE, DD);
    jX(:,i) = [f1  f2]';
    
    % Atualiza solucao
    xo = X(:,:,i);
end
% Fim da obtencao das solucoes pareto-otimas ++++++++++++++++++++++++++++++

% Plota espa�o de objetivos
plot(jX(1,:),jX(2,:),'ro')
xlabel('f1'), ylabel('f2')

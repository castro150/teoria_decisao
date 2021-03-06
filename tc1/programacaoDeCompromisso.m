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
%   Estrat�gia para escolha de solu��es de programa��o de compromisso
%
% Parametros:
%   u: taxa de decaimento da temperatura
% 
% Retorno:
%   X: valores das solucoes pareto-otimas
%  jX: Imagem de X
%
% Exemplo de execucao: programacaoDeCompromisso(0.1);
% =========================================================================
function [X, jX] = programacaoDeCompromisso(u)

m = 2;          % n�mero de objetivos
f_star = [14 400]';
r = 0.5;

[xo, order, N] = initialSolSPA();

load('i5x25.mat');
for i = 1:100   % n�mero de solu��es Pareto-�timas ESTIMADAS
    fprintf('Calculando #%d solucao pareto-otima\n', i);
    
    w = rand(1,m);
    w = w/sum(w);       
    
    %-----------------------------Inicio do SA-----------------------------
    k = 0;
    
    % Contador do n�mero de avalia��es de f(.)
    nfe = 0; 

    % Temperatura inicial
    t = 100;
    
    % Calcula funcao objetivo da programacao de compromissos
    f1 = fobjTE(xo, PT);
    f2 = fobjSPA(xo, order, PT, WE, DD);
    jx = w(1)*(abs(f1 - f_star(1))^r)+ w(2)*(abs(f2 - f_star(2))^r);
    jx = jx^(1/r);
    
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
            
            f1 = fobjTE(y, PT);
            f2 = fobjSPA(y, order, PT, WE, DD);
            jy = w(1)*(abs(f1-f_star(1))^r)+w(2)*(abs(f2-f_star(2))^r);
            jy = jy^(1/r);
            
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
    
    xo = X(:,:,i);
end

% Plota espa�o de objetivos
plot(jX(1,:),jX(2,:),'ro')
xlabel('f1'), ylabel('f2')
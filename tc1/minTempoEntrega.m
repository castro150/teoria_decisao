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
%   Minimiza��o do tempo total de entrega usando o algoritmo
%   Simulated Annealing, como estudado em sala de aula.
% =========================================================================
function [xbest, jxbest, nfe] = minTempoEntrega()

% Carrega dados
load('i5x25.mat');

% Contador de est�gios do m�todo
k = 0;

% Contador do n�mero de avalia��es de f(.)
nfe = 0; 

% Temperatura inicial
t = 100;

% Gera e avalia solu��o inicial
[x, M, N] = initialSol();
[jx] = fobj(x, PT);
nfe = nfe + 1; 

% Armazena melhor solu��o encontrada
xbest  = x;
jxbest = jx;

% Armazena a solu��o corrente
memoryfile(1,:) = [xbest(:)' jxbest];

% Crit�rio de parada do algoritmo
numEstagiosEstagnados = 0;

% Crit�rio de parada
while (numEstagiosEstagnados <= 10 && nfe < 2000) 
        
    % Crit�rios para mudan�a de temperatura
    numAceites = 0;
    numTentativas = 0;
       
    % Fitness da solu��o submetida ao est�gio k
    fevalin = jxbest;

    while (numAceites < 12*N && numTentativas < 100*N)
        
        % Gera uma solu��o na vizinhan�a de x
        y = neighbor(x);
        [jy] = fobj(y,custo,n);
        nfe = nfe + 1;        
        
        % Atualiza solu��o    
        DeltaE = (jy - jx);
        if (DeltaE <= 0 || rand <= exp(-DeltaE/t))
            x = y;
            jx = jy;            
            numAceites = numAceites + 1;
            
            % Atualiza melhor solu��o encontrada
            if (jx < jxbest)
                xbest  = x;
                jxbest = jx;                
            end        
        end
        numTentativas = numTentativas + 1;   
        
        % Armazena a solu��o corrente
        memoryfile(size(memoryfile,1)+1,:) = [x(:)' jx];
    end
                
    % Atualiza a temperatura
    t = 0.5*t;
    
    % Avalia crit�rio de estagna��o
    if (jxbest < fevalin)
        numEstagiosEstagnados = 0;
    else
        numEstagiosEstagnados = numEstagiosEstagnados + 1;        
    end
        
    % Atualiza contador de est�gios de temperatura
    k = k + 1;   
end
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
%   Minimização do tempo total de entrega usando o algoritmo
%   Simulated Annealing, como estudado em sala de aula.
% =========================================================================
function [xbest, jxbest, nfe] = minTempoEntrega()

% Carrega dados
load('i5x25.mat');

% Contador de estágios do método
k = 0;

% Contador do número de avaliações de f(.)
nfe = 0; 

% Temperatura inicial
t = 100;

% Gera e avalia solução inicial
[x, M, N] = initialSol();
[jx] = fobj(x, PT);
nfe = nfe + 1; 

% Armazena melhor solução encontrada
xbest  = x;
jxbest = jx;

% Armazena a solução corrente
memoryfile(1,:) = [xbest(:)' jxbest];

% Critério de parada do algoritmo
numEstagiosEstagnados = 0;

% Critério de parada
while (numEstagiosEstagnados <= 10 && nfe < 2000) 
        
    % Critérios para mudança de temperatura
    numAceites = 0;
    numTentativas = 0;
       
    % Fitness da solução submetida ao estágio k
    fevalin = jxbest;

    while (numAceites < 12*N && numTentativas < 100*N)
        
        % Gera uma solução na vizinhança de x
        y = neighbor(x);
        [jy] = fobj(y,custo,n);
        nfe = nfe + 1;        
        
        % Atualiza solução    
        DeltaE = (jy - jx);
        if (DeltaE <= 0 || rand <= exp(-DeltaE/t))
            x = y;
            jx = jy;            
            numAceites = numAceites + 1;
            
            % Atualiza melhor solução encontrada
            if (jx < jxbest)
                xbest  = x;
                jxbest = jx;                
            end        
        end
        numTentativas = numTentativas + 1;   
        
        % Armazena a solução corrente
        memoryfile(size(memoryfile,1)+1,:) = [x(:)' jx];
    end
                
    % Atualiza a temperatura
    t = 0.5*t;
    
    % Avalia critério de estagnação
    if (jxbest < fevalin)
        numEstagiosEstagnados = 0;
    else
        numEstagiosEstagnados = numEstagiosEstagnados + 1;        
    end
        
    % Atualiza contador de estágios de temperatura
    k = k + 1;   
end
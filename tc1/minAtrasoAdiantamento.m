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
function [xbest, jxbest, nfe] = minAtrasoAdiantamento(u, n)

% Carrega dados
load('i5x25.mat');

% Contador de estágios do método
k = 0;

% Contador do número de avaliações de f(.)
nfe = 0; 

% Temperatura inicial
t = 100;

% Gera e avalia solução inicial
[x, ~, N] = initialSolTE();
[jx] = fobjAA(x, PT, WE, DD);
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

    while (numAceites < 3*N && numTentativas < 25*N)
        
        % Gera uma solução na vizinhança de x
        temp = neighbor1TE(x, n);
        y = neighbor2TE(temp);
        [jy] = fobjAA(y, PT, WE, DD);
        nfe = nfe + 1;
        
        % Atualiza solução    
        DeltaE = jy - jx;
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
fprintf('\n')

figure
plot(0:size(memoryfile,1)-1,memoryfile(:,end),'k-','linewidth',2)
xlabel('Número de iterações')
ylabel('Valor da função objetivo')
%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Depto. de Engenharia Elétrica
%
% Autor:
%   Lucas S. Batista
%
% Atualização: 18/05/2017
%
% Nota:
%   Aproxima o ponto de ótimo (minimização) de um problema irrestrito
%   usando o Algoritmo Simulated Annealing (VERSÃO SIMPLES).
% =========================================================================


function [xbest, jxbest, nfe] = SAdiscreto()
MPDBCSV = 'MPDB.csv';
EquipDBCSV = 'EquipDB.csv';
ClusterDBCSV = 'ClusterDB.csv';
%
% Sintaxe
% [xbest, jxbest, nfe] = SAdiscreto()
%
% Exemplo
% [xbest, jxbest, nfe] = SAdiscreto()
%

% Contador do número de avaliações de f(.)


% Carrega valores parametros
horizonte_tempo = 5;

T = csvread(MPDBCSV);
custo_manutencao = T(:,3)';
fator_risco = T(:,2)';

T = csvread(EquipDBCSV);
t0 = T(:,2)';
cluster = T(:,3)';
custo_falha = T(:,4)';

T = csvread(ClusterDBCSV);
eta = T(:,2)';
beta = T(:,3)';

M = zeros(100,500);
for i = 1:10   % número de soluções Pareto-ótimas ESTIMADAS
    fprintf('Calculando #%d solucao pareto-otima\n', i);
    % obtem pesos aleatoriamente e normalizados
    w = rand(1,2);
    w = w/sum(w);
    
    % Gera e avalia solução inicial
    [x, n] = initialSol();
    [jx] = fobj(x, n, w, custo_manutencao, custo_falha, fator_risco, horizonte_tempo, t0, cluster, eta, beta);

    

    % Armazena melhor solução encontrada
    xbest  = x;
    jxbest = jx;

    % Critério de parada do algoritmo
    numEstagiosEstagnados = 0;    

    % Temperatura inicial
    t = 100;
    
    nfe = 0; 


    % Critério de parada
    while (nfe < 5000) 

        % Critérios para mudança de temperatura
        numAceites = 0;
        numTentativas = 0;

        % Fitness da solução submetida ao estágio k
        fevalin = jxbest;

        neighborStruct = 1;
        numSubEstagiosEstagnados = 0;
        while (numAceites < n/10 && numTentativas < n)

            % Gera uma solução na vizinhança de x
            y = neighbor(x, neighborStruct);
            [jy] = fobj(y,n,w, custo_manutencao, custo_falha, fator_risco, horizonte_tempo, t0, cluster, eta, beta);
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
            else
                if(neighborStruct == 3)
                    neighborStruct = 1;
                else
                    neighborStruct = neighborStruct + 1;
                end
                numSubEstagiosEstagnados = numSubEstagiosEstagnados + 1;
            end
            
            if(numSubEstagiosEstagnados == 50)
                break;
            end
            
            numTentativas = numTentativas + 1;   
        end

        % Atualiza a temperatura
        t = 0.5*t;

        % Avalia critério de estagnação
        if (jxbest < fevalin)
            numEstagiosEstagnados = 0;
        else
            numEstagiosEstagnados = numEstagiosEstagnados + 1;        
        end
        
        if(numEstagiosEstagnados == 10)
            break;
        end
        
        nfe = nfe + 1; 
    end
    
    M(i,:) = xbest;
end
fprintf('\n')

csvwrite('Result.csv',M);



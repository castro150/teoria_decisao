%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Depto. de Engenharia El�trica
%
% Autor:
%   Lucas S. Batista
%
% Atualiza��o: 18/05/2017
%
% Nota:
%   Aproxima o ponto de �timo (minimiza��o) de um problema irrestrito
%   usando o Algoritmo Simulated Annealing (VERS�O SIMPLES).
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

% Contador do n�mero de avalia��es de f(.)


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
for i = 1:10   % n�mero de solu��es Pareto-�timas ESTIMADAS
    fprintf('Calculando #%d solucao pareto-otima\n', i);
    % obtem pesos aleatoriamente e normalizados
    w = rand(1,2);
    w = w/sum(w);
    
    % Gera e avalia solu��o inicial
    [x, n] = initialSol();
    [jx] = fobj(x, n, w, custo_manutencao, custo_falha, fator_risco, horizonte_tempo, t0, cluster, eta, beta);

    

    % Armazena melhor solu��o encontrada
    xbest  = x;
    jxbest = jx;

    % Crit�rio de parada do algoritmo
    numEstagiosEstagnados = 0;    

    % Temperatura inicial
    t = 100;
    
    nfe = 0; 


    % Crit�rio de parada
    while (nfe < 5000) 

        % Crit�rios para mudan�a de temperatura
        numAceites = 0;
        numTentativas = 0;

        % Fitness da solu��o submetida ao est�gio k
        fevalin = jxbest;

        neighborStruct = 1;
        numSubEstagiosEstagnados = 0;
        while (numAceites < n/10 && numTentativas < n)

            % Gera uma solu��o na vizinhan�a de x
            y = neighbor(x, neighborStruct);
            [jy] = fobj(y,n,w, custo_manutencao, custo_falha, fator_risco, horizonte_tempo, t0, cluster, eta, beta);
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

        % Avalia crit�rio de estagna��o
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



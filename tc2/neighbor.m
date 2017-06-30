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
%   Define a vizinhança.
% =========================================================================


function y = neighbor(x, neigborStruct)

y = x;

if(neigborStruct == 1)    
    y(randi(500)) = randi(3);
elseif(neigborStruct == 2)
    indexA = randi(500);
    indexB = randi(500);

    while(indexA ~= indexB)
        indexA = randi(500);
        indexB = randi(500);
    end

    tmp = y(indexA);
    y(indexA) = y(indexB);
    y(indexB) = tmp;
else
    indexA = randi(250);
    indexB = randi(250) + 250;
    
    for i=indexA:indexB
        if(i < 500)
            tmp = y(i);
            y(i) = y(i+1);
            y(i+1) = tmp;
        end
    end
end





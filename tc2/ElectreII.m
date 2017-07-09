function [melhorAlternativa, rank] = ElectreII(Alternativas, G, w, cp, cm, D)
    [na nc] = size(G);

    % Comparação entre as ações
    % (J+) = 1, (J=) = 0, (J-) = -1
    J = zeros(na, na, nc);

    for c = 1:nc
        for a = 1:na
           iJp = G(a, c) > G(:, c);
           iJe = G(a, c) == G(:, c);
           iJm = G(a, c) < G(:, c);

           J(a, iJp, c) = 1;
           J(a, iJe, c) = 0;
           J(a, iJm, c) = -1;
        end
    end
    
    % Cálculo dos coeficientes P
    Pp = zeros(na, na);
    Pe = zeros(na, na);
    Pm = zeros(na, na);

    iPp = J == 1;
    iPe = J == 0;
    iPm = J == -1;

    for c = 1:nc
       Pp = Pp + iPp(:, :, c) * w(c); 
       Pe = Pe + iPe(:, :, c) * w(c); 
       Pm = Pm + iPm(:, :, c) * w(c); 
    end

    for a = 1:na 
        Pe(a, a) = 0;
    end

    % Coeficientes de concordância
    C = zeros(na, na);
    C = (Pp + Pe);

    % Coeficiente P+/P-
    PpPm = Pp ./ Pm;


    % Coeficientes Gcak = Gc(ak) - Gc(ai)
    Gc = zeros(na, na, nc);

    for c = 1:nc
        for a = 1:na
           Gc(a, :, c) = transpose(G(a, c) - G(:, c));
        end
    end

    % Matriz de sobreclassificação forte
    Ss = zeros(na, na);
    iSs = C > cp & PpPm >= 1;
    for c = 1:nc
        iSs = iSs & Gc(:, :, c) <= D;
    end

    Ss(iSs) = 1; 


    % Matriz de sobreclassificação fraca
    Sw = zeros(na, na);
    iSw = C < cm & PpPm >= 1;
    for c = 1:nc
        iSw = iSw & Gc(:, :, c) <= D;
    end

    Sw(iSw) = 1; 

    % Ordenação dos resultados
    Ordenacao = zeros(na, 2);
    Ordenacao(:,1) = 1:na;
    Ordenacao(:,2) = transpose(sum(transpose(Ss)));
    Ordenacao = sortrows(Ordenacao, -2);
    
    melhorAlternativa = Alternativas(Ordenacao(1, 1), :);
    rank = Ordenacao(:, 1);
end
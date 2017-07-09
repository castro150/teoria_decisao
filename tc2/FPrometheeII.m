function [Sobreclassificacao, xBest, fBest] = FPrometheeII(X, custos, w)
    na = size(X, 1);
    
    P1 = zeros(na, na);
    P2 = zeros(na, na);
    P = zeros(na, na);
    
    for i=1:na
        for j=1:na
            if custos(i,1) < custos(j,1)
                P1(i,j) = 1;
            end
            if custos(i,2) < custos(j,2)
                P2(i,j) = 1;
            end
            P(i,j) = w(1)*P1(i,j) + w(2)*P2(i,j);
        end
    end

    FluxoPositivo = sum(P,2)';
    FluxoNegativo = sum(P,1);
    Fluxo = FluxoPositivo - FluxoNegativo;

    Sobreclassificacao = zeros(na, na);
    for i=1:na
        for j=1:na
            if Fluxo(i) > Fluxo(j)
                Sobreclassificacao(i,j) = 1;
            elseif Fluxo (i) < Fluxo (j)
                Sobreclassificacao(i,j) = -1;
            end
        end
    end

    SPorAlternativa = sum(Sobreclassificacao, 2);
    xBest = X(SPorAlternativa == max(SPorAlternativa), :);
    fBest = custos(SPorAlternativa == max(SPorAlternativa), :);
end


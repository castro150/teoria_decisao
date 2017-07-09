function [Sobreclassificacao, xBest, fBest] = PrometheeII(X, G, w)
    [na nc] = size(X);
    
    P1 = zeros(na, na);
    P2 = zeros(na, na);
    P = zeros(na, na);
    
    for i=1:na
        for j=1:na
            if G(i,1) > G(j,1)
                P1(i,j) = 1;
            end
            if G(i,2) > G(j,2)
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
    fBest = G(SPorAlternativa == max(SPorAlternativa), :);
end


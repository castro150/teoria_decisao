function [] = ElectreII(G, w)
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

% Cálculo dos coeficientes de concordância
C = zeros(na, na);
C = (Pp + Pe);



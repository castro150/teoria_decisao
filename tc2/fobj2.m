function [f] = fobj2(x, horizonte_tempo, fator_risco, t0, cluster, eta, ...
beta, custo_falha)

deltaT = horizonte_tempo * fator_risco(x);

Ft = wblcdf(t0 + deltaT ,eta(cluster),beta(cluster));
Ft0 = wblcdf(t0, eta(cluster), beta(cluster));
Risk = (Ft - Ft0) / (1 - Ft0);

f = Risk * custo_falha;
end


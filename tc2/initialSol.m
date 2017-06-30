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
%   Define a solução inicial.
% =========================================================================


function [x,n] = initialSol()
n = 500;

x = randi(3,1,n);


function[S] = getResidualSum(E)
% Get the residual sum for a matrix E.
% Looks for rank deficiencies in the input matrix.
% If an element is close to zero then the row is linearly depenedent on
% other rows in the matrix.
% See "Components Analysis of hidden Markov model in
% Computer Vision" by Caelli and McCane for more information.

S = zeros(1,size(E,2));

E = E';

for i=1:size(E,1)
    S(i) = sqrt(sum(E(i,:).^2));
end
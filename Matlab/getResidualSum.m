function[S] = getResidualSum(E)


S = zeros(1,size(E,2));

E = E';

for i=1:size(E,1)
    S(i) = sqrt(sum(E(i,:).^2));
end
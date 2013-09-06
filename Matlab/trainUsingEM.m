nstates = 4;
users = size(data,1);
len = size(data,2);

PI =@(x, n) (ones(1,n)/(eye(n) -x + ones(n)))';

viterbiPaths = zeros(users, len);

% Initialise struct with empty values, the last value will e overwritten.
modelBW(users).A = trans;

for i=1:users
    observed = data(i,:);
    [ptr,pe] = hmmtrain(observed, trans, emis);
    
    modelBW(i).A = ptr;
    modelBW(i).emission = tabularCpdCreate(pe);
    modelBW(i).pi = PI(trans, 4)';
    
    viterbiPath = hmmMap(modelBW(i), observed);
    viterbiPaths(i,:) = viterbiPath;
end

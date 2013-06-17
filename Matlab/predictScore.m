function [ score ] = predictScore( viterbiPath, predictedHidden )
% The score function that determines the capability of the prediction.

alpha = exp(3);
beta = exp(2);
gamma = exp(1);

[one,two] = closenessScore(viterbiPath, predictedHidden);

x = sum(predictedHidden ~= 1 & predictedHidden == viterbiPath);
u = sum(viterbiPath ~= 1);

z = sum(predictedHidden == 1 & predictedHidden == viterbiPath);

t = u+z;

if(t == 0)
    score = 0;
else
    score = ((x*alpha) + (one*beta) + (z*gamma)) / (t*alpha);
end

if(score < 0 || score > 1)
    error('Score must be between 0 and 1.');
end

end


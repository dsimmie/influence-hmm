function [ logLks ] = hmmSampleLogLks( pi, A, emission, len, nsamples)
%hmmSampleLogLks Get the series of log likelihoods for samples created from
%the model parameters.

markov.pi = pi;
markov.A = A;
markov.emission = tabularCpdCreate(emission);
hidden = markovSample(markov, len, nsamples);
observed = zeros(1, len);
logLks = zeros(1, len);
for t=1:len
   observed(1, t) = sampleDiscrete(emission(hidden(t), :));
   logLks(1, t) = (hmmLogprob(markov, observed(1:t)));
end
end


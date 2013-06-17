function plotMixing( A, emission, pi_1, pi_2, len, nsamples)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
logLks_1 = hmmSampleLogLks(pi_1, A, emission, len, nsamples);
logLks_2 = hmmSampleLogLks(pi_2, A, emission, len, nsamples);

xmax = max(max(logLks_1),max(logLks_2));
ymin = min(min(logLks_1),min(logLks_2));

subplot(1,2,1), plot(logLks_1);
subplot(1,2,2), plot(logLks_2);
% axis([0 xmax ymin 0])

end


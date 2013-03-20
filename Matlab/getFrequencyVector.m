function[freq] = getFrequencyVector(vector, range)
% Get a relative frequency vector of the integers in the bounded vector
% where the vector consists of integers {1,...,range}.
% Example: vector = {1 2 2 3}, freq = [0.25 0.5 0.25]

freq = zeros(1,range);

for i=1:range
    freq(i) = length(vector(vector==i))/length(vector);
end
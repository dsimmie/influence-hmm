function[freq] = getFrequencyVector(vector, range)

freq = zeros(1,range);

for i=1:range
    freq(i) = length(vector(vector==i))/length(vector);
end
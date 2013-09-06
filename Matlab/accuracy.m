function [ buzzData, nbinData, naiveData, randData ] = accuracyData(buzzAccuracy, nbinAccuracy, naiveAccuracy, randAccuracy, label, type)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

len = size(buzzAccuracy,2);
buzzData = zeros(1,len);
nbinData = zeros(1,len);
naiveData = zeros(1,len);
randData = zeros(1,len);

for i=1:len
    buzzData(i) = buzzAccuracy(i).(label).(type);
    nbinData(i) = nbinAccuracy(i).(label).(type);
    naiveData(i) = naiveAccuracy(i).(label).(type);
    randData(i) = randAccuracy(i).(label).(type);
end


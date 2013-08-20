function [ precision ] = precision( confusionTable )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
precision = 0;
if(confusionTable.tp + confusionTable.fp > 0)
    precision = confusionTable.tp/(confusionTable.tp + confusionTable.fp);

if(precision > 1)
    err('Precision cannot be greater than 1');
end

end


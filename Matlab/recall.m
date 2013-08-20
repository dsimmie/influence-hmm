function [ recall ] = recall( confusionTable )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
recall = 0;
if(confusionTable.tp + confusionTable.fp > 0)
    recall = confusionTable.tp/(confusionTable.tp + confusionTable.fn);
end

if(recall > 1)
    err('Recall cannot be greater than 1');
end

end


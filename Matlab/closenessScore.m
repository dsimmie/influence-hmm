function [ oneStep, twoStep ] = closenessScore( viterbiPath, predictedHidden )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
oneStep=0;
twoStep=0;
for i=1:length(viterbiPath)
    if(viterbiPath(i)>1)
        if(predictedHidden(i)>1)
            diff = abs(viterbiPath(i)-predictedHidden(i));
            if(diff == 1)
                oneStep = oneStep + 1;
            elseif(diff == 2)
                twoStep = twoStep + 1;
            end
        end
    end
end


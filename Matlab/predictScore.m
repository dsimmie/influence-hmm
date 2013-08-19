function [ score ] = predictScore( actualPosteriorStates, predictedStates )
% The score function that determines the capability of the prediction.
if(length(actualPosteriorStates) ~= length(predictedStates))
    error('Predicted and actual observation lengths must be the same')
end

score = sum(actualPosteriorStates == predictedStates)/length(actualPosteriorStates);


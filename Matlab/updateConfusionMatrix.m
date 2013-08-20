function confusionMatrix = updateConfusionMatrix(confusionMatrix, actualPosteriorStates, predictedStates )
% The score function that determines the capability of the prediction.
if(length(actualPosteriorStates) ~= length(predictedStates))
    error('Predicted and actual observation lengths must be the same')
end

for i=1:length(predictedStates)
    row = actualPosteriorStates(i);
    col = predictedStates(i);
    confusionMatrix(row,col) = confusionMatrix(row,col) + 1;
end
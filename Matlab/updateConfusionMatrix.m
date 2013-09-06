function confusionMatrix = updateConfusionMatrix(confusionMatrix, actualState, predictedState)
% Update the current entry in the confusion matrix with this state
% comparison.
confusionMatrix(actualState,predictedState) = confusionMatrix(actualState,predictedState) + 1;
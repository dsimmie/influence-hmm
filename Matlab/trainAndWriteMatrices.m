function [ trainedTrans, trainedEmis ] = trainAndWriteMatrices( dataPath, data, trans, emis )
% Train the input matrices using Baum-Welch parameter estimation.
% Trains the input matrices, assesses the quality of the trained matrcies, 
% saves the resulting matrcies to file and returns them to the caller.

fprintf('Commencing Baum-Welch Parameter Training..\n');

[trainedTrans, trainedEmis] = hmmtrain(data, trans, emis);

fprintf('Completed Baum-Welch Parameter Training.\n');

assessHMMQuality(trainedTrans, trainedEmis);

dlmwrite(strcat(dataPath, 'trained-trans.txt'), trainedTrans);
dlmwrite(strcat(dataPath, 'trained-emis.txt'), trainedEmis);

end


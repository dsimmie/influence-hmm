% Import the data into the workspace.
initialiseBuzzModel;

% Assess quality of initial trained/estimated matrices.
assessHMMQuality(trans, emis);

% Train the data
[trainedTrans, trainedEmis] = trainAndWriteMatrices(dataPath, data, trans, emis);

% Calculate buzz rankings and produce Buzz Analysis files (temporal and
% rank).
exportHMMBuzz(networkFile, data, headers, trainedTrans, trainedEmis, 1, rankFile, outputFile)

% Requires external transmission matrix.
% For now use hard-coded

% Import the data
importBuzzNormalizedWeeklyData

% Configure file paths
configureBuzzHmmFiles

% Create the emission matrix
createBuzzEmissionFromUserEmission

% Train the data
trainAndWriteMatrices

% Asses quality of trained/estimated matrices.
assessHMMQuality

% Calculate buzz rankings and produce Buzz Analysis
exportHmmBuzz

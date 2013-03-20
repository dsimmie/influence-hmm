% Setup file paths and any required initialisation values for the Buzz HMM
% model.

dataPath = '~/data/';

% Network centrality file path
networkFile = strcat(dataPath,'network-nodes-table.csv');

% Read in the observations data
mentions = importdata(strcat(dataPath, 'mentions_per_week.csv'));
unique_interactions = importdata(strcat(dataPath, 'unique_interactions_per_week.csv'));
retweets = importdata(strcat(dataPath, 'retweets_per_week.csv'));
modelData = importdata(strcat(dataPath, 'buzz_model.csv'));

data = modelData.data;
headers = modelData.textdata(2:end,1);

% Output Files
rankFile = strcat(dataPath,'buzz-rank.csv');
outputFile = strcat(dataPath,'buzz-temporal-output.csv');

% Use the transition matrix created by R.
% TODO read from file instead of hard-coded.
trans = [0.89830996 0.07397387 0.02521029 0.002505888
0.36016852 0.54829544 0.08225491 0.009281129
0.18502579 0.20485268 0.52774683 0.082374701
0.09659003 0.23633426 0.30448407 0.362591642];

% Create the initial emission matrix.

% Create the user-based emission matrix from the data and symbol count.
el = createEmissionRows(retweets, mentions, unique_interactions, headers, data, 3, 16);

% Transform the user-based matrix into a buzz based matrix.
emis = createBuzzEmissionFromUserEmission(el);
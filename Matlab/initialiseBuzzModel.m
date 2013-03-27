% Setup file paths and any required initialisation values for the Buzz HMM
% model.

dataPath = '~/data/';

% Network centrality file path
networkFile = strcat(dataPath,'network-nodes-table.csv');

% Read in the observations data
mentions = importdata(strcat(dataPath, 'mentions_per_week.csv'));
unique_interactions = importdata(strcat(dataPath, 'unique_interactions_per_week.csv'));
retweets = importdata(strcat(dataPath, 'retweets_per_week.csv'));
observations = importdata(strcat(dataPath, 'buzz_model.csv'));

data = observations.data;
headers = observations.textdata(2:end,1);

% Output Files
rankFile = strcat(dataPath,'buzz-rank-output.csv');
outputFile = strcat(dataPath,'buzz-temporal-output.csv');

% Use the transition matrix created by R.
trans = importdata(strcat(dataPath, 'initial-trans.csv'));
trans = trans.data;

% Create the initial emission matrix.

% Create the user-based emission matrix from the data and symbol count.
el = createEmissionRows(retweets, mentions, unique_interactions, headers, data, 3, 16);

% Transform the user-based matrix into a buzz based matrix.
emis = createBuzzEmissionFromUserEmission(el);
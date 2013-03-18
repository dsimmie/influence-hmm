procPath = '~/Dropbox/research/Imperial/influence-evo/data/shared/data/new-model/processed/';
symbolPath = '~/Dropbox/research/Imperial/influence-evo/data/shared/data/new-model/symbol/';
obsFileName = 'buzz_model.csv';
mentions = importdata(strcat(procPath, 'buzz_norm_mentions_per_week.csv'));
unique_interactions = importdata(strcat(procPath, 'buzz_norm_unique_interactions_per_week.csv'));
retweets = importdata(strcat(procPath, 'buzz_norm_retweets_per_week.csv'));

% Import the normalized weekly observations data
modelData = importdata(strcat(symbolPath, obsFileName));

rtMtUiData = modelData.data;
rtMtUiHeaders = modelData.textdata(2:end,1);


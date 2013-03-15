procPath = '/Users/dsimmie/Dropbox/research/Imperial/influence-evo/data/shared/data/new-model/processed/';
gephipath = '/Users/dsimmie/Dropbox/research/Imperial/influence-evo/data/shared/data/new-model/processed/gephi/';
symbolPath = '/Users/dsimmie/Dropbox/research/Imperial/influence-evo/data/shared/data/new-model/symbol/';
imagePath = '/Users/dsimmie/Dropbox/research/Imperial/influence-evo/data/shared/images/new-model/processed/';

analysisFile = strcat(procPath, 'buzz-analysis.csv');
outputFile = strcat(procPath, 'buzz-temporal-output.csv');
networkFile = strcat(gephipath,'scala-sample2-network-nodes-table.csv');
buzzModel = strcat(symbolPath,'buzz_model.csv');

buzzData = importdata(buzzModel);

trans = [0.89830996 0.07397387 0.02521029 0.002505888
0.36016852 0.54829544 0.08225491 0.009281129
0.18502579 0.20485268 0.52774683 0.082374701
0.09659003 0.23633426 0.30448407 0.362591642];

el = createEmissionRows(procPath, imagePath, retweets, mentions, unique_interactions, rtMtUiHeaders, rtMtUiData,3,16);
emis = createBuzzEmissionFromUserEmission(el);
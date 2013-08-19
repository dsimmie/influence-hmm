function[emis] = createEmissionRows(retweets, mentions, unique_interactions, headers, data, numStates, numSymbols)
% Create the user-based initial emission rows from samplnig the data and
% examining the different distributions of influence relevant data.

mtpd = mentions.data;
rtpd = retweets.data;
uipd = unique_interactions.data;

% The names of the users
mtpdheaders = mentions.textdata(2:end,1);
rtpdheaders = retweets.textdata(2:end,1);
uipdheaders = unique_interactions.textdata(2:end,1);

% One percent of the user size
onePercent = (length(mtpd)/100);
halfPercent = onePercent*0.5;

% Start of very high sample
vhighSampleStart = round(length(mtpd)-halfPercent);

% Start of high sample
highSampleStart = round(vhighSampleStart-(onePercent*5));

% The sample users for each different influence metric.
[mtSample1,mtSample2,mtSample3] = getSampleUsers(mtpd, mtpdheaders, highSampleStart, vhighSampleStart);
[uiSample1,uiSample2,uiSample3] = getSampleUsers(uipd, uipdheaders, highSampleStart, vhighSampleStart);
[rtSample1,rtSample2,rtSample3] = getSampleUsers(rtpd, rtpdheaders, highSampleStart, vhighSampleStart);

% The very high, high and no influence individuals.
veryHighInfluencers = union(union(mtSample3, uiSample3),rtSample3);
highInfluencers = union(union(mtSample2, uiSample2),rtSample2);
notInfluencers = union(union(mtSample1, uiSample1),rtSample1);

vhSample = veryHighInfluencers;
hSample = setdiff(highInfluencers, vhSample);
% Sample of 6000 useres from the rest.
nSample = setdiff(setdiff(notInfluencers(randsample(1:length(notInfluencers), 6000)),highInfluencers), veryHighInfluencers);

% Find the indices of the sample users from population screen names.
vhMembers = ismember(headers, vhSample);
hMembers = ismember(headers, hSample);
nMembers = ismember(headers, nSample);

% Get all the data elements from the observations data and combine those.
vhData = data(vhMembers==1,:);
hData = data(hMembers==1,:);
nData = data(nMembers==1,:);

% Flatten this matrix into a column vector
vhVector = reshape(vhData.',[],1);
hVector = reshape(hData.',[],1);
nVector = reshape(nData.',[],1);

% Create the emission rows for the initial model from the data
vhFreqVec = getFrequencyVector(vhVector, numSymbols);
hFreqVec = getFrequencyVector(hVector, numSymbols);
nFreqVec = getFrequencyVector(nVector, numSymbols);

emis = zeros(numStates,numSymbols);

% Set the three rows of the user emission matrix.
emis(1,:) = nFreqVec;
emis(2,:) = hFreqVec;
emis(3,:) = vhFreqVec;

function[emis, sampleData] = createEmissionRows(procPath, imagePath, retweets, mentions, unique_interactions, rtMtUiHeaders, rtMtUiData, numStates, numSymbols)
% Requires influence data already loaded.
mtpd = mentions.data;
rtpd = retweets.data;
uipd = unique_interactions.data;

mtpdheaders = mentions.textdata(2:end,1);
rtpdheaders = retweets.textdata(2:end,1);
uipdheaders = unique_interactions.textdata(2:end,1);

onePercent = (length(mtpd)/100);
halfPercent = onePercent*0.5;
vhighSampleStart = round(length(mtpd)-halfPercent);
highSampleStart = round(vhighSampleStart-(onePercent*5));

[mtSample1,mtSample2,mtSample3] = getSampleUsers(mtpd, mtpdheaders, highSampleStart, vhighSampleStart);
[uiSample1,uiSample2,uiSample3] = getSampleUsers(uipd, uipdheaders, highSampleStart, vhighSampleStart);
[rtSample1,rtSample2,rtSample3] = getSampleUsers(rtpd, rtpdheaders, highSampleStart, vhighSampleStart);

veryHighInfluencers = union(union(mtSample3, uiSample3),rtSample3);
highInfluencers = union(union(mtSample2, uiSample2),rtSample2);
notInfluencers = union(union(mtSample1, uiSample1),rtSample1);

% Question: Should we sample or use all?
vhSample = veryHighInfluencers;
hSample = setdiff(highInfluencers, vhSample);
nSample = setdiff(setdiff(notInfluencers(randsample(1:length(notInfluencers), 6000)),highInfluencers), veryHighInfluencers);

% Find the indices of the sample users from population screen names.
vhMembers = ismember(rtMtUiHeaders, vhSample);
hMembers = ismember(rtMtUiHeaders, hSample);
nMembers = ismember(rtMtUiHeaders, nSample);

% Get all the data elements from the observations data and combine those
vhData = rtMtUiData(vhMembers==1,:);
hData = rtMtUiData(hMembers==1,:);
nData = rtMtUiData(nMembers==1,:);

sampleData = rtMtUiData(nMembers | hMembers | vhMembers,:);

% Put together headers and data and write to csv file.
vhHeaders = rtMtUiHeaders(vhMembers==1);
hHeaders = rtMtUiHeaders(hMembers==1);
nHeaders = rtMtUiHeaders(nMembers==1);

firstRow = retweets.textdata(1,:);

cellCsv(firstRow, vhHeaders, vhData, strcat(procPath, 'very-high-influence-sample.csv'));
cellCsv(firstRow, hHeaders, hData, strcat(procPath, 'high-influence-sample.csv'));
cellCsv(firstRow, nHeaders, nData, strcat(procPath, 'no-influence-sample.csv'));

% Flatten this matrix into a column vector
vhVector = reshape(vhData.',[],1);
hVector = reshape(hData.',[],1);
nVector = reshape(nData.',[],1);

% Uncomment to plot and save historgrams of the sample distributions
%vh = figure;
%hist(vhVector);
%print(vh, '-depsc', strcat(imagePath, 'very-high-influence-sample-dist.eps'))

%h = figure;
%hist(hVector);
%print(h, '-depsc', strcat(imagePath, 'high-influence-sample-dist.eps'))

%nh = figure;
%hist(nVector);
%print(nh, '-depsc', strcat(imagePath, 'no-influence-sample-dist.eps'))


% Create the emission rows for the initial model from the data
vhFreqVec = getFrequencyVector(vhVector, numSymbols);
hFreqVec = getFrequencyVector(hVector, numSymbols);
nFreqVec = getFrequencyVector(nVector, numSymbols);

emis = zeros(numStates,numSymbols);

emis(1,:) = nFreqVec;
emis(2,:) = hFreqVec;
emis(3,:) = vhFreqVec;

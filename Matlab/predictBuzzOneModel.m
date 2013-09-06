obsLen = size(data, 2);
numUsers = size(data, 1);

trainLen = ceil(obsLen/2);
testLen = floor(obsLen/2);

% Determine the count of the useres who have any other observation other
% than all ones.
nonOnesNumUsers = numUsers - sum(sum(data, 2) == obsLen);

trainingData = data(:,1:trainLen);
testData = data(:,testLen:end);

predictedHiddens = zeros(nonOnesNumUsers,testLen);
controlDists = zeros(nonOnesNumUsers,testLen);
predDists = zeros(nonOnesNumUsers,testLen);
naiveDists = zeros(nonOnesNumUsers,testLen);
reducedData = zeros(nonOnesNumUsers,obsLen);
trainedPaths = zeros(nonOnesNumUsers,testLen);

% For all users
k=1;
sampleCount = 10;

buzzConfusion = zeros(nstates,nstates,testLen);
nbinConfusion = zeros(nstates,nstates,testLen);
naiveConfusion = zeros(nstates,nstates,testLen);
randConfusion = zeros(nstates,nstates,testLen);

totalPredConfusion = zeros(nstates,nstates);
totalControlConfusion = zeros(nstates,nstates);
totalNaiveConfusion = zeros(nstates,nstates);
totalRandConfusion = zeros(nstates,nstates);

predPrecision = zeros(1, testLen);
controlPrecision = zeros(1, testLen);
naivePrecision = zeros(1, testLen);
randPrecision = zeros(1, testLen);

predRecall = zeros(1, testLen);
controlRecall = zeros(1, testLen);
naiveRecall = zeros(1, testLen);
randRecall = zeros(1, testLen);

predF1 = zeros(1, testLen);
controlF1 = zeros(1, testLen);
naiveF1 = zeros(1, testLen);
randF1 = zeros(1, testLen);

for i=1:numUsers
    userTrainedData = trainingData(i,:);
    
    updatedData = userTrainedData;
    predictedHidden = zeros(1,testLen);
    
    controlDist = zeros(1,testLen);
    predDist = zeros(1,testLen);
    naiveDist = zeros(1,testLen);
    
    % Calculate posterior state probabilities for 1-t
    pStates = hmmdecode(userTrainedData, trans, emis);
    
    obsSum = sum(data(i,:));
    
    if(obsSum <= obsLen)
        continue
    end
    
    reducedData(k,:) = data(i,:);
       
    % For each sequence in testing phase
    for j=1:testLen
        nextObs = zeros(1,sampleCount);
        % Repeat prediction n times and average result.
        for n=1:sampleCount
            % Most likely next state = max posterior state probability * transition
            % probability
            % Find max posterior state for current timepoint.
            [C,I] = max(pStates(:,end));
            % Pick next state using the current state transition
            % probability for sampling.
            nextState = sampleDiscrete(trans(I, :));

            try
                predictedHidden(j) = nextState;
            catch err
                display(err);
                error('Error determining next possible state');
            end

            % Generate a sample observation.
            nextObs(n) = sampleDiscrete(emis(nextState, :));

            % Store euclidean distance from predicted to actual.
            try
                maxPosteriors = maxPosteriorStates(k,trainLen+1:trainLen+j);
            catch err
                error('Error getting max posterior state')
            end
            randnb = 1 + nbinrnd(2,0.8,1,j);
            randnb(randnb>4) = 4;
            nbinPath = randnb;
            naivePath = ones(1,j);
            randPath = randi([1, nstates], 1, j);

            buzzConfusion(:,:,j) = updateConfusionMatrix(buzzConfusion(:,:,j), maxPosteriors, predictedHidden(1:j));
            nbinConfusion(:,:,j) = updateConfusionMatrix(nbinConfusion(:,:,j), maxPosteriors, nbinPath);
            naiveConfusion(:,:,j) = updateConfusionMatrix(naiveConfusion(:,:,j), maxPosteriors, naivePath);
            randConfusion(:,:,j) = updateConfusionMatrix(randConfusion(:,:,j), maxPosteriors, randPath);
            
            if(n == sampleCount)
                buzzAccuracy(j) = calcAccuracy(buzzConfusion(:,:,j));
                nbinAccuracy(j) = calcAccuracy(nbinConfusion(:,:,j));
                naiveAccuracy(j) = calcAccuracy(naiveConfusion(:,:,j));
                randAccuracy(j) = calcAccuracy(randConfusion(:,:,j));
            end
        end
        % Add the most common generated observation onto the existing data.
        updatedData(length(updatedData)+1) = mode(nextObs);

        % Update posterior state probabilities for t+1
        pStates = hmmdecode(updatedData, trans, emis);
    end
    predictedHiddens(k,:) = predictedHidden;
    trainedPaths(k,:) = maxPosteriors;
    k = k+1;
end

analysis.path = '/Users/dsimmie/Dropbox/research/Imperial/influence-evo/workspaces/influence-analysis/results/';
dlmwrite(strcat(analysis.path,'predicted-confusion-mat.csv')', totalPredConfusion);
dlmwrite(strcat(analysis.path,'control-confusion-mat.csv'), totalControlConfusion);
dlmwrite(strcat(analysis.path,'naive-confusion-mat.csv')', totalNaiveConfusion);
dlmwrite(strcat(analysis.path,'reduced-data.csv')', reducedData);
dlmwrite(strcat(analysis.path,'trained-paths.csv')', trainedPaths);
dlmwrite(strcat(analysis.path,'predicted-states.csv')', predictedHiddens);
    
% Missing data and transition model only predictions
% Mixing time

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
reducedData = zeros(nonOnesNumUsers,obsLen);
trainedPaths = zeros(nonOnesNumUsers,testLen);

% For all users
k=1;
for i=1:numUsers
    userTrainedData = trainingData(i,:);
    userTrainedModel = modelBW(i);
    userTrans = userTrainedModel.A;
    userEmis = userTrainedModel.emission;
    
    trainTr = userTrans;
    trainEmis = userEmis.T;
    updatedData = userTrainedData;
    predictedHidden = zeros(1,testLen);
    
    controlDist = zeros(1,testLen);
    predDist = zeros(1,testLen);
    
    % Calculate posterior state probabilities for 1-t
    pStates = hmmdecode(userTrainedData, userTrans, trainEmis);
    
    obsSum = sum(data(i,:));
    
    if(obsSum <= obsLen)
        continue
    end
    
    reducedData(k,:) = data(i,:);
       
    % For each sequence in testing phase
    for j=1:testLen
        predictionScore = zeros(1,k);
        controlScore = zeros(1,k);
        nextObs = zeros(1,n);
        % Repeat prediction n times and average result.
        for n=1:10
            % Most likely next state = max posterior state probability * transition
            % probability
            % Find max posterior state for current timepoint.
            [C,I] = max(pStates(:,end));
            % Pick next state using the current state transition
            % probability for sampling.
            nextState = sampleDiscrete(trainTr(I, :));

            try
                predictedHidden(j) = nextState;
            catch err
                display(err);
                error('Error determining next possible state');
            end

            % Generate a sample observation.
            nextObs(n) = sampleDiscrete(trainEmis(nextState, :));

            % Store euclidean distance from predicted to actual.
            try
                maxPosteriors = maxPosteriorStates(k,trainLen+1:trainLen+j);
            catch err
                error('Error getting max posterior state')
                rethrow(err)
            end
            randnb = 1 + nbinrnd(2,0.8,1,j);
            randnb(randnb>4) = 4;
            controlPath = randnb;

            predictionScore(n) = predictScore(maxPosteriors, predictedHidden(1:j));
            controlScore(n) = predictScore(maxPosteriors, controlPath);
            
            % Add the distance from prediction for active users.
            if(n==10)
                predDist(j) = mean(predictionScore);
                controlDist(j) = mean(controlScore);
            end
        end
        % Add the most common generated observation onto the existing data.
        updatedData(length(updatedData)+1) = mode(nextObs);

        % Update model with generated evidence
        [updatedTrain,updatedEmis] = hmmtrain(updatedData, trainTr, trainEmis);

        % Hack to fix case where poorly trained model is re-trained and
        % produces all zero entries.
        if(norm(trainTr,inf) ~= 0)
            trainTr = updatedTrain;
        end
        if(norm(trainEmis,inf) ~= 0)
            trainEmis = updatedEmis;
        end

        % Update posterior state probabilities for t+1
        pStates = hmmdecode(updatedData, trainTr, trainEmis);
    end
    predictedHiddens(k,:) = predictedHidden;
    trainedPaths(k,:) = maxPosteriors;
    predDists(k,:) = predDist;
    controlDists(k,:) = controlDist;
    k = k+1;
end

inf.analysis.path = 'Users/dsimmie/Dropbox/research/Imperial/influence-evo/workspaces/influence-analysis/';
dlmwrite(strcat(inf.analysis.path,'control-dists.csv'), controlDists);
dlmwrite(strcat(inf.analysis.path,'predicted-dists.csv')', predDists);
dlmwrite(strcat(inf.analysis.path,'reduced-data.csv')', reducedData);
dlmwrite(strcat(inf.analysis.path,'trained-paths.csv')', trainedPaths);
dlmwrite(strcat(inf.analysis.path,'predicted-states.csv')', predictedHiddens);
    
% Missing data and transition model only predictions
% Mixing time

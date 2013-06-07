obsLen = size(data, 2);
numUsers = size(data, 1);

trainLen = ceil(obsLen/2);
testLen = floor(obsLen/2);

trainingData = data(:,1:trainLen);
testData = data(:,testLen:end);

predDists = zeros(1, numUsers);
predictedHiddens = zeros(numUsers,testLen);

% For all users
for i=1:numUsers
    userTrainedData = trainingData(i,:);
    userTrainedModel = modelBW(i);
    userTrans = userTrainedModel.A;
    userEmis = userTrainedModel.emission;
    
    trainTr = userTrans;
    trainEmis = userEmis.T;
    updatedData = userTrainedData;
    predictedHidden = zeros(1,testLen);
    
    % Calculate posterior stat probabilities for 1-t
    pStates = hmmdecode(userTrainedData, userTrans, trainEmis);
    
    % For each sequence in testing phase
    for j=1:testLen
        % Most likely next state = posterior state probability * transition
        % probability
        nextStates = pStates(:,end)' * trainTr;
        maxProbState = find(nextStates == max(nextStates));
        
        try
            predictedHidden(j) = maxProbState;
        catch err
            error('Error determining next possible state');
        end
        
        % Generate observation.
        nextObs = sampleDiscrete(pe(1, :));
        
        updatedData(length(updatedData)+1) = nextObs;
        
        % Update model with generated evidence
        [trainTr,trainEmis] = hmmtrain(updatedData, trainTr, trainEmis);
        
        % Hack to fix case where poorly trained model is re-trained and
        % produces all zero entries.
        if(norm(trainTr,inf) == 0)
            trainTr = btr;
        end
        if(norm(trainEmis,inf) == 0)
            trainEmis = be;
        end
        
        
        % Update posterior state probabilities for t+1
        pStates = hmmdecode(updatedData, trainTr, trainEmis);
    end
    % Store euclidean distance from predicted to actual.
    trainedPath = viterbiPaths(i,trainLen+1:end);
    predDist = pdist([trainedPath; predictedHidden]);
    predictedHiddens(i,:) = predictedHidden;
    predDists(i) = predDist;
end

dlmwrite('~/git/influence-hmm/prediction-dists.csv', predDists);
dlmwrite('~/git/influence-hmm/predicted-states.csv', predictedHiddens);
    
% Missing data and transition model only predictions
% Mixing time

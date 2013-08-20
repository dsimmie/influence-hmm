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

predConfusion = zeros(nstates,nstates,testLen);
controlConfusion = zeros(nstates,nstates,testLen);
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
    userTrainedModel = modelBW(i);
    userTrans = userTrainedModel.A;
    userEmis = userTrainedModel.emission;
    
    trainTr = userTrans;
    trainEmis = userEmis.T;
    updatedData = userTrainedData;
    predictedHidden = zeros(1,testLen);
    
    controlDist = zeros(1,testLen);
    predDist = zeros(1,testLen);
    naiveDist = zeros(1,testLen);
    
    % Calculate posterior state probabilities for 1-t
    pStates = hmmdecode(userTrainedData, userTrans, trainEmis);
    
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
            end
            randnb = 1 + nbinrnd(2,0.8,1,j);
            randnb(randnb>4) = 4;
            controlPath = randnb;
            naivePath = ones(1,j);
            randPath = randi([1, nstates], 1, j);

            predConfusion(:,:,j) = updateConfusionMatrix(predConfusion(:,:,j), maxPosteriors, predictedHidden(1:j));
            controlConfusion(:,:,j) = updateConfusionMatrix(controlConfusion(:,:,j), maxPosteriors, controlPath);
            naiveConfusion(:,:,j) = updateConfusionMatrix(naiveConfusion(:,:,j), maxPosteriors, naivePath);
            randConfusion(:,:,j) = updateConfusionMatrix(randConfusion(:,:,j), maxPosteriors, randPath);
            
            [p,r,f] = multiclassF1(predConfusion(:,:,j));
            predPrecision(j) = p;
            [p,r,f] = multiclassF1(controlConfusion(:,:,j));
            controlPrecision(j) = p;
            [p,r,f] = multiclassF1(naiveConfusion(:,:,j));
            naivePrecision(j) = p;
            [p,r,f] = multiclassF1(randConfusion(:,:,j));
            randPrecision(j) = p;
            
            [p,r,f] = multiclassF1(predConfusion(:,:,j));
            predRecall(j) = r;
            [p,r,f] = multiclassF1(controlConfusion(:,:,j));
            controlRecall(j) = r;
            [p,r,f] = multiclassF1(naiveConfusion(:,:,j));
            naiveRecall(j) = r;
            [p,r,f] = multiclassF1(randConfusion(:,:,j));
            randRecall(j) = r;
            
            [p,r,f] = multiclassF1(predConfusion(:,:,j));
            predF1(j) = f;
            [p,r,f] = multiclassF1(controlConfusion(:,:,j));
            controlF1(j) = f;
            [p,r,f] = multiclassF1(naiveConfusion(:,:,j));
            naiveF1(j) = f;
            [p,r,f] = multiclassF1(randConfusion(:,:,j));
            randF1(j) = f;
            
            totalPredConfusion = updateConfusionMatrix(totalPredConfusion, maxPosteriors, predictedHidden(1:j));
            totalControlConfusion = updateConfusionMatrix(totalControlConfusion, maxPosteriors, controlPath);
            totalNaiveConfusion = updateConfusionMatrix(totalNaiveConfusion, maxPosteriors, naivePath);
            totalRandConfusion = updateConfusionMatrix(totalRandConfusion, maxPosteriors, randPath);
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
    k = k+1;
end

% Convert confusion matrices to confusion tables for each class
[totalPredPrec,totalPredRec,totalPredF1] = multiclassF1(totalPredConfusion);
[totalControlPrec,totalControlRec,totalControlF1] = multiclassF1(totalControlConfusion);
[totalNaivePrec,totalNaiveRec,totalNaiveF1] = multiclassF1(totalNaiveConfusion);

% Determine precision/recall and f1 measure


analysis.path = '/Users/dsimmie/Dropbox/research/Imperial/influence-evo/workspaces/influence-analysis/results/';
dlmwrite(strcat(analysis.path,'predicted-confusion-mat.csv')', totalPredConfusion);
dlmwrite(strcat(analysis.path,'control-confusion-mat.csv'), totalControlConfusion);
dlmwrite(strcat(analysis.path,'naive-confusion-mat.csv')', totalNaiveConfusion);
dlmwrite(strcat(analysis.path,'reduced-data.csv')', reducedData);
dlmwrite(strcat(analysis.path,'trained-paths.csv')', trainedPaths);
dlmwrite(strcat(analysis.path,'predicted-states.csv')', predictedHiddens);
    
% Missing data and transition model only predictions
% Mixing time

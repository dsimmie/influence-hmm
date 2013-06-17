obsLen = size(data, 2);
numUsers = size(data,1);
maxPosteriorStates = zeros(nonOnesNumUsers, len);

k=1;
for i=1:numUsers
    obsSum = sum(data(i,:));
    
    if(obsSum <= obsLen)
        continue
    end
    
    userTrainedModel = modelBW(i);
    userTrans = userTrainedModel.A;
    userEmis = userTrainedModel.emission;
    
    userData = data(i,:);
    
    pStates = hmmdecode(userData, userTrans, userEmis.T);
    
    [C,I] = max(pStates);
    
    maxPosteriorStates(k,:) = I;
    k = k+1;
end

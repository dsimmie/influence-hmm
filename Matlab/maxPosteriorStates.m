obsLen = size(data, 2);
numUsers = size(data,1);
maxPosteriorStates = zeros(users, len);

for i=1:numUsers
    obsSum = sum(data(i,:));
    
    if(obsSum <= obsLen)
        continue
    end
    
    userTrainedModel = modelBW(i);
    userTrans = userTrainedModel.A;
    userEmis = userTrainedModel.emission;
    pStates = hmmdecode(data(i,:), userTrans, userEmis);
    
    [C,I] = max(pStates);
    
    maxPosteriorStates(i,:) = I;
end

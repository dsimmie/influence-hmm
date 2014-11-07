function [ buzzConf, nbinConf, naiveConf, randConf ] = getConfMats(buzzAccuracy, nbinAccuracy, naiveAccuracy, randAccuracy)
len = size(buzzAccuracy,2);

buzzConf = zeros(4,4);
nbinConf = zeros(4,4);
naiveConf = zeros(4,4);
randConf = zeros(4,4);

for i=1:len
    buzzConf = buzzConf + buzzAccuracy(i).confMat;
    nbinConf = nbinConf + nbinAccuracy(i).confMat;
    naiveConf = naiveConf + naiveAccuracy(i).confMat;
    randConf = randConf + randAccuracy(i).confMat;
end

buzzConf = buzzConf/len;
nbinConf = nbinConf/len;
naiveConf = naiveConf/len;
randConf = randConf/len;

end


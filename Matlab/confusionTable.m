function[confusionTable] = confusionTable(confusionMat, class)
    truePos = confusionMat(class, class);
    falsePos = sum(confusionMat(:,class)) - truePos;
    falseNeg = sum(confusionMat(class,:)) - truePos;
    total = sum(sum(confusionMat));
    trueNeg = total - truePos - falsePos - falseNeg;
    confusionTable.tp = truePos;
    confusionTable.fp = falsePos;
    confusionTable.tn = trueNeg;
    confusionTable.fn = falseNeg;
    
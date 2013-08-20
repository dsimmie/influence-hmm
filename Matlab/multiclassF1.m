function[avgPrec,avgRec,avgF1] = multiclassF1(confMat)
noBuzzConfTab = confusionTable(confMat, 1);
someBuzzConfTab = confusionTable(confMat, 2);
highBuzzConfTab = confusionTable(confMat, 3);
vhighBuzzConfTab = confusionTable(confMat, 4);

noBuzzPrec = precision(noBuzzConfTab);
someBuzzPrec = precision(someBuzzConfTab);
highBuzzPrec = precision(highBuzzConfTab);
vhighBuzzPrec = precision(vhighBuzzConfTab);

if(noBuzzPrec > 1 || someBuzzPrec > 1 || highBuzzPrec > 1 || vhighBuzzPrec > 1)
    err('Precision cannot be greater than 1');
end

noBuzzRec = recall(noBuzzConfTab);
someBuzzRec = recall(someBuzzConfTab);
highBuzzRec = recall(highBuzzConfTab);
vhighBuzzRec = recall(vhighBuzzConfTab);

if(noBuzzRec > 1 || someBuzzRec > 1 || highBuzzRec > 1 || vhighBuzzRec > 1)
    err('Recall cannot be greater than 1');
end

noBuzzF1 = f1(noBuzzPrec,noBuzzRec);
someBuzzF1 = f1(someBuzzPrec,someBuzzRec);
highBuzzF1 = f1(highBuzzPrec,highBuzzRec);
vhighBuzzF1 = f1(vhighBuzzPrec,vhighBuzzRec);

avgPrec = (noBuzzPrec + someBuzzPrec + highBuzzPrec + vhighBuzzPrec)/4;
avgRec = (noBuzzRec + someBuzzRec + highBuzzRec + vhighBuzzRec)/4;
avgF1 = (noBuzzF1 + someBuzzF1 + highBuzzF1 + vhighBuzzF1)/4;

function [ accuracy ] = calcAccuracy(confMat)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
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

accuracy.noBuzz.confTab = noBuzzConfTab;
accuracy.noBuzz.prec = noBuzzPrec;
accuracy.noBuzz.rec = noBuzzRec;
accuracy.noBuzz.f1 = noBuzzPrec;

accuracy.someBuzz.confTab = someBuzzConfTab;
accuracy.someBuzz.prec = someBuzzPrec;
accuracy.someBuzz.rec = someBuzzPrec;
accuracy.someBuzz.f1 = someBuzzPrec;

accuracy.highBuzz.confTab = highBuzzConfTab;
accuracy.highBuzz.prec = highBuzzPrec;
accuracy.highBuzz.rec = highBuzzPrec;
accuracy.highBuzz.f1 = highBuzzPrec;

accuracy.vhighBuzz.confTab = vhighBuzzConfTab;
accuracy.vhighBuzz.prec = vhighBuzzPrec;
accuracy.vhighBuzz.rec = vhighBuzzRec;
accuracy.vhighBuzz.f1 = vhighBuzzF1;

accuracy.mean.prec = (noBuzzPrec + someBuzzPrec + highBuzzPrec + vhighBuzzPrec)/4;
accuracy.mean.rec = (noBuzzRec + someBuzzRec + highBuzzRec + vhighBuzzRec)/4;
accuracy.mean.f1 = (noBuzzF1 + someBuzzF1 + highBuzzF1 + vhighBuzzF1)/4;

accuracy.confMat = confMat;

end


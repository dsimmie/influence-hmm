function plotAccuracy(buzzAccuracy, nbinAccuracy, naiveAccuracy, randAccuracy, label, type, ylab, ymin)

[buzzData,nbinData,naiveData,randData] = accuracy(buzzAccuracy, nbinAccuracy, naiveAccuracy, randAccuracy, label, type);

figure;
hold on;
plot(buzzData);
plot(nbinData, 'o');
plot(naiveData, 'x');
plot(randData, '.');
axis([0,22,ymin,1]);
legend('Buzz','Neg. Bin.','Ones','Uniform');
xlabel('Weeks','FontSize',16);
ylabel(ylab,'FontSize',16);
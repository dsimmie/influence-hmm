figure;

[buzzData,nbinData,naiveData,randData] = accuracy(buzzAccuracy, nbinAccuracy, naiveAccuracy, randAccuracy, 'mean', 'prec');

subplot(1,3,1)
plot(buzzData); hold on;
plot(nbinData, 'o');
plot(naiveData, 'x');
plot(randData, '.'); hold off;
axis([0,22,0,1]);
h_leg = legend('Buzz','Neg. Bin.','Ones','Uniform');
set(h_leg,'FontSize',14);
xlabel('Weeks','FontSize',16);
ylabel('Precision','FontSize',16);

[buzzData,nbinData,naiveData,randData] = accuracy(buzzAccuracy, nbinAccuracy, naiveAccuracy, randAccuracy, 'mean', 'rec');

subplot(1,3,2)
plot(buzzData); hold on;
plot(nbinData, 'o');
plot(naiveData, 'x');
plot(randData, '.'); hold off;
axis([0,22,0,1]);
h_leg = legend('Buzz','Neg. Bin.','Ones','Uniform');
set(h_leg,'FontSize',14);
xlabel('Weeks','FontSize',16);
ylabel('Recall','FontSize',16);

[buzzData,nbinData,naiveData,randData] = accuracy(buzzAccuracy, nbinAccuracy, naiveAccuracy, randAccuracy, 'mean', 'f1');

subplot(1,3,3)
plot(buzzData); hold on;
plot(nbinData, 'o');
plot(naiveData, 'x');
plot(randData, '.'); hold off;
axis([0,22,0,1]);
h_leg = legend('Buzz','Neg. Bin.','Ones','Uniform');
set(h_leg,'FontSize',14);
xlabel('Weeks','FontSize',16);
ylabel('F1 Measure','FontSize',16);
function plotTiledAccuracy(buzzAccuracy, nbinAccuracy, naiveAccuracy, randAccuracy, type, ylab)
%UNTITLED16 Summary of this function goes here
%   Detailed explanation goes here

figure;

[buzzData,nbinData,naiveData,randData] = accuracy(buzzAccuracy, nbinAccuracy, naiveAccuracy, randAccuracy, 'noBuzz', type);

subplot(2,2,1);
plot(buzzData); hold on;
plot(nbinData, 'o');
plot(naiveData, 'x');
plot(randData, '.'); hold off;
axis([0,22,0,1]);
xlabel('Weeks', 'FontSize', 16);
ylabel(ylab, 'FontSize', 16);
legend('Buzz','Neg. Bin.','Ones','Uniform');

[buzzData,nbinData,naiveData,randData] = accuracy(buzzAccuracy, nbinAccuracy, naiveAccuracy, randAccuracy, 'someBuzz', type);

subplot(2,2,2);
plot(buzzData); hold on;
plot(nbinData, 'o');
plot(naiveData, 'x');
plot(randData, '.'); hold off;
axis([0,22,0,1]);
xlabel('Weeks', 'FontSize', 16);
ylabel(ylab, 'FontSize', 16);
legend('Buzz','Neg. Bin.','Ones','Uniform');

[buzzData,nbinData,naiveData,randData] = accuracy(buzzAccuracy, nbinAccuracy, naiveAccuracy, randAccuracy, 'highBuzz', type);

subplot(2,2,3);
plot(buzzData); hold on;
plot(nbinData, 'o');
plot(naiveData, 'x');
plot(randData, '.'); hold off;
axis([0,22,0,1]);
xlabel('Weeks', 'FontSize', 16);
ylabel(ylab, 'FontSize', 16);
legend('Buzz','Neg. Bin.','Ones','Uniform');


[buzzData,nbinData,naiveData,randData] = accuracy(buzzAccuracy, nbinAccuracy, naiveAccuracy, randAccuracy, 'vhighBuzz', type);

subplot(2,2,4);
plot(buzzData); hold on;
plot(nbinData, 'o');
plot(naiveData, 'x');
plot(randData, '.'); hold off;
axis([0,22,0,1]);
xlabel('Weeks', 'FontSize', 16);
ylabel(ylab, 'FontSize', 16);
legend('Buzz','Neg. Bin.','Ones','Uniform');


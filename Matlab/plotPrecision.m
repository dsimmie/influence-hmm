function plotAccuracy(buzzAccuracy, nbinAccuracy, naiveAccuracy, randAccuracy, label, type)

len = size(accuracy,2);
buzzData = zeros(1,len);
nbinData = zeros(1,len);
naiveData = zeros(1,len);
randData = zeros(1,len);

for i=1:len
    buzzData(i) = accuracy.(label).(type);
    nbinData(i) = accuracy.(label).(type);
    naiveData(i) = accuracy.(label).(type);
    randData(i) = accuracy.(label).(type);
end

figure
hold on
plot(buzzData)
plot(nbinData, 'red')
plot(naiveData, 'green')
plot(randData, 'orange')
axis([0,22,0,2])
legend('Buzz','Neg. Bin.','Ones','Uniform');
xlabel('Weeks','FontSize',16)
ylabel('Precision','FontSize',16)
figure
hold on
plot(predPrecision)
plot(naivePrecision, 'red')
plot(controlPrecision, 'green')
axis([0,22,0,2])
legend('Predicted','Naive','Control')
xlabel('Weeks','FontSize',16)
ylabel('Precision','FontSize',16)
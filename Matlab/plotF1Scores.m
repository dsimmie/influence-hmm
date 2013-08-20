figure
hold on
plot(f1Scores(1,:))
plot(f1Scores(2,:), 'red')
plot(f1Scores(3,:), 'green')
axis([0,22,0,7])
legend('Predicted','Naive','Control')
xlabel('Weeks','FontSize',16)
ylabel('F1 Measure','FontSize',16)
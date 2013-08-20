figure
hold on
plot(predRecall)
plot(naiveRecall, 'red')
plot(controlRecall, 'green')
axis([0,22,0,2])
legend('Predicted','Naive','Control')
xlabel('Weeks','FontSize',16)
ylabel('Recall','FontSize',16)
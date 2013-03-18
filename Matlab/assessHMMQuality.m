% Assess the quality of the HMM matrices using HMM quality metrics proposed by Caelli and McCane
% in "Componenta Analysis of hidden Markov model in Computer Vision".
% The Inverse Condition Number captures the discrimination between states
% and the Residual Sum is used to see which states/observations are
% contributing the most/least to the model.
function assessHMMQuality(trans, emis)
AU = [trans emis];

fprintf(strcat('Inverse condition number of row augmented matrix:\t' ,num2str(invCond(AU), 4)));

E = getResidualMatrix(AU);

S = getResidualSum(E);

fprintf('\nResidual sum vector:');
disp(S);


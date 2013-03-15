function assessHMMQuality(trans, emis)

AU = [trans emis];

fprintf(strcat('Inverse condition number of row augmented matrix:\t' ,num2str(inv_cond(AU), 4)));

E = getResidualMatrix(AU);

S = getResidualSum(E);

fprintf('\nResidual sum vector:');
disp(S);

% TODO last quality metric.


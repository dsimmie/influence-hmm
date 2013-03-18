% Create the Buzzz emission matrix from the user-based matrix.
% The user matrix has three states the buzz version has four.
% The first state is the same for both the others are assigned from their
% most likely buzz state.
function [ buzzEmis ] = createBuzzEmissionFromUserEmission( userEmis )

buzzEmis(1,:) = userEmis(1,:);
buzzEmis(2:4,:) = zeros(3,size(userEmis, 2));

userEmisNorm = sum(userEmis/norm(sum(userEmis)));

someBuzz = userEmisNorm([2,4:7]);
highBuzz = userEmisNorm(8:11);
veryHighBuzz = userEmisNorm(12:16);

buzzEmis(2,[2,4:7]) = (someBuzz/norm(someBuzz)) .^ 2;
buzzEmis(3,8:11) = (highBuzz/norm(highBuzz)) .^ 2;
buzzEmis(4,12:16) = (veryHighBuzz/norm(veryHighBuzz)) .^ 2;

% Take discrecepancy from the max value.
[m1,max1] = max(buzzEmis(1,:));
[m2,max2] = max(buzzEmis(2,:));
[m3,max3] = max(buzzEmis(3,:));
[m4,max4] = max(buzzEmis(4,:));

diff1 = sum(buzzEmis(1,:)) - 1;
diff2 = sum(buzzEmis(2,:)) - 1;
diff3 = sum(buzzEmis(3,:)) - 1;
diff4 = sum(buzzEmis(4,:)) - 1;

buzzEmis(1,max1) = buzzEmis(1,max1) + (-1*diff1);
buzzEmis(2,max2) = buzzEmis(2,max2) + (-1*diff2);
buzzEmis(3,max3) = buzzEmis(3,max3) + (-1*diff3);
buzzEmis(4,max4) = buzzEmis(4,max4) + (-1*diff4);

% As dealing with probabilities all rows need to sum to 1.
% Checking the infinity norm of the matrix is a shortcut to verifying this.
if(norm(buzzEmis,inf) ~= 1)
    error('Error in function logic the infinity norm of buzz emission matrix must be 1');
end


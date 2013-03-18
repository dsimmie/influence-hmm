% Gets the BuzzRanks for all users in the dataset.
% Parameters:
% screenNames: the screen names of the users
% observations: the discrete integer symbols for each user per timepoint.
% trans: the model transition matrix
% emis: the emission matrix
% outputFile: the path to the temporal buzz ranks output file
function[buzzUsers] = getBuzzRankedUsers(screenNames, observations, trans, emis, outputFile)
    
seqLen = size(observations, 1);
obsLen = size(observations, 2);

% The summation of the the transformed viterbi path.
buzzUsers = cell(seqLen,2);
% The transformed buzz value for each time point.
temporalBuzz = cell(seqLen, obsLen+1);

for i=1:seqLen
    obs = observations(i,:);
    vit_path = hmmviterbi(obs,trans,emis);
    tr_vit_path = transformViterbiPath(vit_path);
    sum_vit = sum(tr_vit_path);
    buzzUsers{i,1} = sum_vit;
    screenNameCell = screenNames(i);
    buzzUsers{i,2} = screenNameCell{1};
    temporalBuzz{i,1} = screenNameCell{1};
    temporalBuzz(i,2:end) = num2cell(tr_vit_path);
end

% Save the results of the temporal buzz ranked users (for each time point)
% to file.
fid = fopen(outputFile,'wt');
formatString = repmat('%2.4f,', 1, obsLen-1);
formatString = ['%s, ', formatString, '%2.4f\n'];

for i=1:seqLen
    fprintf(fid, formatString, temporalBuzz{i,1}, temporalBuzz{i,2:end});
end
fclose(fid);

% Transform the Viterbi Path using the Buzz function.
function[expViterbiPath] = transformViterbiPath(viterbiPath)

expViterbiPath = zeros(1,length(viterbiPath));
for i=1:length(viterbiPath)
    expViterbiPath(i) = transformValue(viterbiPath(i));
end

function[transformedValue] = transformValue(value)

if(value==1)
    transformedValue = 0;
else if(value==2)
        transformedValue = 2.7183;
    else if(value==3)
            transformedValue = 7.3891;
        else if(value==4)
                transformedValue = 20.0855;
            else
                error('Invalid value of input only 4 hidden states supported.');
            end
        end
    end
end
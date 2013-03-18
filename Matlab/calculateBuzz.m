% Calculate the top n percent of the Buzz ranked users.
% The output for the temporal buzz ranks are stored in the output file.

% Parameters.
% data: the temporal observation data
% names: the names of the users
% trans: the transition matrix
% emis: the emission matrix
% nprct: the numeric percentage to choose
% outputFile: the path to the output file for storing tthe temporal buzz
% users output.
function[topNPrct] = calculateBuzz(data, names, trans, emis, nprct, outputFile)

rlist = getBuzzRankedUsers(names, data, trans, emis, outputFile);

srList = sortcell(rlist,1);

oneprct = length(data(:,1))/100;

sampleCount = int16(oneprct*nprct);

descList = flipud(srList);

topNPrct = descList(1:sampleCount, :);
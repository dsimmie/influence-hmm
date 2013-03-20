function exportHMMBuzz( networkFile, data, headers, trans, emis, nprct, rankFile, outputFile )
% Export the BuzzRank and also the temporal Buzz for each user.
% At this point the offline reach data is also integrated via loading from
% file.

% Import the reach based data from the network structure file.
networkData = importdata(networkFile);
numericNetData = networkData.data;
textNetData = networkData.textdata;
networkHeaders = textNetData(2:end,1);

% Re-combine the header and row data into one cell array.
netCell = cell(size(numericNetData,1), 6);
netCell(:,1) = networkHeaders;
netCell(:,2:6) = num2cell(numericNetData);

% Sort cells by name.
sortedNetCell = sortcell(netCell,1);

% Calculate the buzz ranks for each time point in the observation interval.
buzzRanks = calculateBuzz(data, headers, trans, emis, nprct, outputFile);

% Extract the names from the cell array.
sortedNetHeaders = sortedNetCell(:,1);

rowCount = size(buzzRanks,1);

% Produce file with name, in-degree, reach, buzz
% Export as csv
fid = fopen(rankFile,'wt');
fprintf(fid, 'Ident,In-Deg,Reach,Buzz\n');
for i=1:rowCount
    row = getRow(sortedNetCell, sortedNetHeaders, buzzRanks{i,2});
    fprintf(fid, '%s,%d,%1.8d,%3.2d\n', buzzRanks{i,2}, row{2}, row{6}, buzzRanks{i,1});
end
fclose(fid);

function[row] = getRow( sortedNetCell, sortedNetHeaders, identifier )
% Get the corresponding row from the network data cell array matching on
% the screen name of the user.
[i,j] = ind2sub(size(sortedNetHeaders), strmatch(getScreenName(identifier), sortedNetHeaders, 'exact'));

row = sortedNetCell(i,:);
function exportHMMBuzz( networkFile, data, rowheaders, trans, emis, nprct, analysisFile, outputFile )
% read in gephi csv summary
networkData = importdata(networkFile);

numericNetData = networkData.data;
textNetData = networkData.textdata;
networkHeaders = textNetData(2:end,1);

netCell = cell(size(numericNetData,1), 3);

netCell(:,1) = networkHeaders;
netCell(:,2:3) = num2cell(numericNetData);

sortedNetCell = sortcell(netCell,1);

vsr = calculateBuzz(data, rowheaders, trans, emis, nprct, outputFile);

% Need to find user by screen name in network list and get corresponding
% data.

% Produce file with name, in-degree, reach and buzz.
% Export as csv

sortedNetHeaders = sortedNetCell(:,1);

rowCount = size(vsr,1);

display(size(vsr,1))

fid = fopen(analysisFile,'wt');
fprintf(fid, 'Ident,In-Deg,Reach,Buzz\n');
for i=1:rowCount-1
    try
        identifier = vsr{i,2};
        row = getRow(sortedNetCell, sortedNetHeaders, identifier);
        fprintf(fid, '%s,%d,%1.8d,%3.2d\n', identifier, row{2}, row{3}, vsr{i,1});
    catch err
        display(strcat('Could not find user: ',vsr{i,2}));
    end
end
fclose(fid);
        
function[row] = getRow( sortedNetCell, sortedNetHeaders, identifier )

[i,j] = ind2sub(size(sortedNetHeaders), strmatch(getScreenName(identifier), sortedNetHeaders, 'exact'));

row = sortedNetCell(i,:);

function screenName = getScreenName(nameId)

lastUIndex = max(findstr('_', nameId));

screenName = nameId(1:lastUIndex-1);
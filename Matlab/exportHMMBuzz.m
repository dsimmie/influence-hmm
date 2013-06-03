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

i=0;
try
    fid = fopen(analysisFile,'wt');
    fprintf(fid, 'Ident,In-Deg,Reach,Buzz\n');
    for i=1:rowCount-1
    %     if(i >= 8975)
    %         display(i)
    %         display(sprintf(fid, '%s,%d,%1.8d,%3.2d\n', vsr{i,2}, row{2}, row{3}, vsr{i,1}));
    %     end
    %     row = getRow(sortedNetCell, sortedNetHeaders, vsr{i,2});
    %     if(i >= 8975 || isempty(row))
    %         display(sprintf(fid, '%s,%d,%1.8d,%3.2d\n', vsr{i,2}, row{2}, row{3}, vsr{i,1}));
    %     end
        row = getRow(sortedNetCell, sortedNetHeaders, vsr{i,2});
        fprintf(fid, '%s,%d,%1.8d,%3.2d\n', vsr{i,2}, row{2}, row{3}, vsr{i,1});
    end
    fclose(fid);
catch err
    display(i)
    rethrow(err);
end
        
function[row] = getRow( sortedNetCell, sortedNetHeaders, identifier )

[i,j] = ind2sub(size(sortedNetHeaders), strmatch(getScreenName(identifier), sortedNetHeaders, 'exact'));

row = sortedNetCell(i,:);

function screenName = getScreenName(nameId)

lastUIndex = max(findstr('_', nameId));

screenName = nameId(1:lastUIndex-1);
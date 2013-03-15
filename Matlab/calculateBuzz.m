function[topNPrct] = calculateBuzz(data, rowheaders, trans, emis, nprct, outputFile)

rlist = getBuzzRankedUsers(rowheaders, data, trans, emis, outputFile);

srList = sortcell(rlist,1);

oneprct = length(data(:,1))/100;

sampleCount = int16(oneprct*nprct);

descList = flipud(srList);

topNPrct = descList(1:sampleCount, :);
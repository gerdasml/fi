day = 'C:/Users/smlge/Desktop/FI/intcdaily.csv';
dayData = readData(day, 'day');
data = createStruct(dayData, 'day');

money = 1000;

interval = 9;
startIndex = 1:(length(data.high)-interval);
endIndex = interval:length(data.high);

wmaData = weightedMovingAverage(startIndex, endIndex, interval, data);
lrData = linearRegression(startIndex, endIndex, interval, data);

bs = buySell(wmaData.wma, lrData.y, data, 1, size(wmaData.wma, 2), money);
graphic(datenum(wmaData.dateTime), wmaData.wma, lrData.y, dayData, interval, bs.values);
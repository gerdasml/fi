day = 'C:/Users/smlge/Desktop/FI/intcdaily.csv';
dayData = readData(day, 'day');
data = createStruct(dayData, 'day');

interval = 9;
startIndex = 1:(length(data.high)-interval);
endIndex = interval:length(data.high);

wmaData = weightedMovingAverage(startIndex, endIndex, interval, data);
lrData = linearRegression(startIndex, endIndex, interval, data);

plotTwoGraphs(data.dateTime, wmaData.wma, lrData.y, data, interval);
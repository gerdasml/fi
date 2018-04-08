%day = 'C:/Users/smlge/Desktop/FI/intcdaily.csv';
day = 'C:/Users/smlge/Desktop/FI/tsladay2.csv';
%day = 'C:/Users/smlge/Desktop/FI/aaplday1.csv';
%day = 'C:/Users/smlge/Desktop/FI/aaplday2.csv';
dayData = readData(day, 'day');
data = createStruct(dayData, 'day');

money = 1000;
taxes = 0.02;
percentage = 1.2;
percentage2 = 1;

interval = 9;
interval2= 2;

startIndex = 1:(length(data.high)-interval);
endIndex = interval:length(data.high);

startIndex2 = 1:(length(data.high)-interval2);
endIndex2 = interval2:length(data.high);

wmaData = weightedMovingAverage(startIndex, endIndex, interval, data);  
lrData = linearRegression(startIndex, endIndex, interval, data);

wmaData2 = weightedMovingAverage(startIndex2, endIndex2, interval2, data);  
lrData2 = linearRegression(startIndex2, endIndex2, interval2, data);


bs = buySell(wmaData.wma, lrData.y, data, 1, size(wmaData.wma, 2), money, taxes, percentage);
%graphic(datenum(wmaData.dateTime), wmaData.wma, lrData.y, dayData, interval, bs);

bs2 = buySell(wmaData2.wma, lrData2.y, data, 1, size(wmaData2.wma, 2), money, taxes, percentage2);
%graphic(datenum(wmaData2.dateTime), wmaData2.wma, lrData2.y, dayData, interval2, bs2);
optimise(data, money, taxes);
%% aroon
aroonMin = 'C:/Users/smlge/Desktop/FI/tslamin2.csv';
% nuskaitom duomenis paduodami failo pavadinima ir duomenu tipa
minData = readData(aroonMin, 'min');
% nupiesia grafika

%plotas(minData, 'min', 'Laikas', 'Akciju verte', 'Tesla minutiniai duomenys 2018-03-02', datetime(2018, 3, 2), datetime(2018, 3, 3));
data = createStruct(minData);

interval = 25;
startIndex = 1:(length(data.high)-interval);
endIndex = interval:length(data.high);

d = aroon(startIndex, endIndex, interval, data); 
%piesiam grafika
twoLinePlot(d.dateTime, d.aroonUp, d.aroonDown, minData, interval);

%% weighted moving average

wmaMin = 'C:/Users/smlge/Desktop/FI/tslamin2.csv';
% nuskaitom duomenis paduodami failo pavadinima ir duomenu tipa
minData = readData(wmaMin, 'min');

data = createStruct(minData);

interval = 9;
startIndex = 1:(length(data.high)-interval);
endIndex = interval:length(data.high);

d = weightedMovingAverage(startIndex, endIndex, interval, data);
%piesiam grafika
oneLinePlot(d.dateTime, d.wma, minData, interval, "Weighted moving average indikatorius", "Reiksme", "Laikas");

%% linear regression
lrMin = 'C:/Users/smlge/Desktop/FI/tslamin2.csv';
% nuskaitom duomenis paduodami failo pavadinima ir duomenu tipa
minData = readData(lrMin, 'min');

data = createStruct(minData);

interval = 9;
startIndex = 1:(length(data.high)-interval);
endIndex = interval:length(data.high);

d = linearRegression(startIndex, endIndex, interval, data);
%piesiam grafika
oneLinePlot(d.dateTime, d.y, minData, interval, "Linear regression indikatorius", "Reiksme", "Laikas");
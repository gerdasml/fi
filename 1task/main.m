%% tick data
nameTick = 'C:/Users/smlge/Desktop/FI/tslatick.csv';
% nuskaitom duomenis paduodami failo pavadinima ir duomenu tipa
tickData = readData(nameTick, 'tick');
% nupiesia grafika
simpleGraph(tickData, 'Ivykiu skaicius', 'Akciju verte', 'Tesla tikiniai duomenys 2018-02-16');

%% min data
nameMin = 'C:/Users/smlge/Desktop/FI/tslamin.csv';
minData = readData(nameMin, 'min');
plotas(minData, 'min', 'Laikas', 'Akciju verte', 'Tesla minutiniai duomenys 2018-02-15', datetime(2018, 2, 15), datetime(2018, 2, 16));

%% day data
nameDay = 'C:/Users/smlge/Desktop/FI/tsladay.csv';
dayData = readData(nameDay, 'day');
plotas(dayData, 'day', 'Data', 'Akciju verte', 'Tesla dieniniai duomenys laikotarpiu nuo 2017-11-01 iki 2018-02-16', datetime(2017, 11, 1), datetime(2018, 2, 16));

%% rand data
randData = generate(datetime(2018,02,02));
plotas(randData, 'day', 'Data', 'Akciju verte', 'Sugeneruotu duomenu grafikas', randData.dateTime(1), randData.dateTime(end));

%% papildoma uzduotis nr. 10
nameTick = 'C:/Users/smlge/Desktop/FI/tslatick.csv';
tickData = readData(nameTick, 'tick');
plotas(groups(tickData, 'min'), 'min', 'Laikas', 'Akciju verte', 'Tesla minutiniai duomenys gauti is tikiniu 2018-02-16', datetime(2018, 2, 16), datetime(2018, 2, 17));

%% papildoma uzduotis nr. 9
nameYear = 'C:/Users/smlge/Desktop/FI/tslamin.csv';
yearData = readData(nameYear, 'day');
disp('--------------------');
breaks(yearData.dateTime, 10);

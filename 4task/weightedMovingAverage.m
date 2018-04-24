function [d] = weightedMovingAverage(startIndex, endIndex, interval, data)
    d.wma = [];
    d.dateTime = [];
    for i=1:startIndex(end)
        %atfiltruojam duomenis
        closeData = data.close(startIndex(i):endIndex(i));
        calculatedWma = 0;
        %paskaiciuojam kiekvieno laiko momentu wma komponentes sudedamaja
        for j=interval:-1:1
            calculatedWma = calculatedWma + (closeData(j) * j);
        end
        %paskaiciuojam indikatoriaus reiksmes kiekvieno laiko momentu
        calculatedWma = calculatedWma / ( interval * ( interval + 1 ) / 2 );
        %idedame i struktura
        d.wma = [d.wma calculatedWma];
        d.dateTime = [d.dateTime data.dateTime(i+interval)];
    end
end
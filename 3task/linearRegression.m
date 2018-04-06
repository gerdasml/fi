function [d] = linearRegression(startIndex, endIndex, interval, data)
    d.y = [];
    d.dateTime = [];
    for i=1:startIndex(end)
        %atfiltruojam duomenis
        closeData = data.close(startIndex(i):endIndex(i));
        sumX = 0;
        sumY = 0;
        sumXY = 0;
        sumX2 = 0;
        %paskaiciuojam pagal formule sumas x, y, x kvadratu ir xy
        for j=interval:-1:1
            sumX = sumX + j;
            sumX2 = sumX + j*j;
            sumY = sumY + closeData(j);
            sumXY = sumXY + (closeData(j) * j);
        end
        %panaudoje tas sumas, randame pagal formule reiksmes
        m = ((interval*sumXY) - (sumX * sumY)) / ((interval * sumX2) - (sumX * sumX));
        b = (sumY - (m * sumX)) / interval;
        %gaunam kiekvieno momento reiksme
        y = m * interval + b;
        %idedame i struktura
        d.y = [d.y y];
        d.dateTime = [d.dateTime data.dateTime(i+interval)];
    end
end
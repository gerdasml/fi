function [d] = aroon(startIndex, endIndex, interval, data)
    d.aroonUp = [];
    d.aroonDown = [];
    d.dateTime = [];
    for i=1:startIndex(end)
        %atfiltruojam duomenis
        highData = data.high(startIndex(i):endIndex(i));
        lowData = data.low(startIndex(i):endIndex(i));
        %issirenkam is tu minuciu didziausia ir maziausia reiksmes
        maximum = max(highData);
        minimum = min(lowData);
        %randam indeksus tu minuciu, kurios turejo didziausia ir maziausia
        %reiksmes
        minuteHighIndex = find(highData==maximum,1,'last');
        minuteLowIndex = find(lowData==minimum,1,'last');
        %apskaiciuojam indikatoriaus up ir down reiksmes kiekvieno laiko
        %momentu
        aroonUp = ((interval - (interval - minuteHighIndex))/interval)*100;
        aroonDown = ((interval - (interval - minuteLowIndex))/interval)*100;
        %tas reiksmes idedame i struktura
        d.aroonUp = [d.aroonUp aroonUp];
        d.aroonDown = [d.aroonDown aroonDown];
        d.dateTime = [d.dateTime data.dateTime(endIndex(i))];
    end
end
function [pair] = optimise(data, money, taxes)
    %funkcija, skaiciuojanti sharp rodikli. per parametrus paima pelno
    %masyva, suranda vidurki, ji padaugina is darbo dienu skaiciaus ir
    %padalina 
    sharpeRatio = @(profit) (mean(profit)*252) ./ (std(profit) * sqrt(252));
    best.sr = 0;
    best.profit = 0;
    %bus ieskoma geriausio intervalo ir take profit skaiciaus
    for i = 1:10
        a = 0;
        b = 60;
        interval = floor(a+(b-a).*rand(1,1));
        percentage = rand(1,1) + 1;
        startIndex = 1:(length(data.high)-interval);
        endIndex = interval:length(data.high);
        
        wmaData = weightedMovingAverage(startIndex, endIndex, interval, data);  
        lrData = linearRegression(startIndex, endIndex, interval, data);
        
        bs = buySell(wmaData.wma, lrData.y, data, 1, size(wmaData.wma, 2), money, taxes, percentage);
        prof = bs.profitPercentage;
        sr = sharpeRatio(prof);
        %jeigu randama kazkas geresnio uz buvusi sharp indeksa, tai
        %tuomet issaugoma
        if(sr > best.sr)
            best.sr = sr;
            best.profit = prof;
            best.pair = [interval percentage];
        end
    end
    pair.interval = best.pair(1);
    pair.percentage = best.pair(2);
end
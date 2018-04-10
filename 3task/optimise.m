function optimise(data, money, taxes)
    %funkcija, skaiciuojanti sharp rodikli. per parametrus paima pelno
    %masyva, suranda vidurki, ji padaugina is darbo dienu skaiciaus ir
    %padalina 
    sharpeRatio = @(profit) (mean(profit)*252) ./ (std(profit) * sqrt(252));
    best.sr = 0;
    best.profit = 0;
    %bus ieskoma geriausio intervalo ir take profit skaiciaus
    for interval = 1:20
        for percentage = 1:0.05:1.5   
            %zemiau atliekami zingsniai kaip ir main'e norint gauti pelno
            %masyva
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
    end
    best.pair
end
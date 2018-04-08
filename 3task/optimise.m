function optimise(data, money, taxes)
    sharpeRatio = @(profit) (mean(profit)*252) ./ (std(profit) * sqrt(252));
    best.sr = 0;
    best.profit = 0;
    for interval = 1:20
        for percentage = 1:0.05:2            
            startIndex = 1:(length(data.high)-interval);
            endIndex = interval:length(data.high);
            
            wmaData = weightedMovingAverage(startIndex, endIndex, interval, data);  
            lrData = linearRegression(startIndex, endIndex, interval, data);

            bs = buySell(wmaData.wma, lrData.y, data, 1, size(wmaData.wma, 2), money, taxes, percentage);
            prof = bs.profitPercentage;
            sr = sharpeRatio(prof);
            if(sr > best.sr)
                best.sr = sr;
                best.profit = prof;
                best.pair = [interval percentage];
            end
        end
    end
    best.pair
end
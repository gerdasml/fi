function [bs] = readAllFiles(directory, money, taxes)
    %pasiimam visus failus nurodyta direktorija
    files = dir(directory);
    figure('Name','Pelno kitimo grafikai');
    for i = size(files,1):-1:1
        day = strcat(strcat(files(i).folder, '\'), files(i).name);
        dayData = readData(day, 'day');
        from = dayData.dateTime(1);
        to = dayData.dateTime(end);
        data = createStruct(dayData, 'day', from, to);
        
        %pasiimam geriausia pora, kuri buvo pasiulyta po optimizavimo -
        %take profit procentai ir indikatoriu skaiciavimo intervalas
        pair = optimise(data, money, taxes);
        percentage = pair.percentage;
        interval = pair.interval;
        
        startIndex = 1:(length(data.high)-interval);
        endIndex = interval:length(data.high);
        
        %indikatoriu apskaiciavimas
        wmaData = weightedMovingAverage(startIndex, endIndex, interval, data);
        lrData = linearRegression(startIndex, endIndex, interval, data);
        
        bs = buySell(wmaData.wma, lrData.y, data, 1, size(wmaData.wma, 2), money, taxes, percentage);
        op(i).date = wmaData.dateTime;
        op(i).profit = bs.profit;
        op(i).holdProfit = bs.holdProfit;
        
        %nupiesiam kiekvienos imones gauta pelna
        subGraphic(files, i, wmaData, op);
    end
    %answer yra pelnas, o modifiedData, tai sutvarkyti kiekvienos imones
    %pelno duomenys isimant tarpus
    [answer, modifiedData] = combineData(op, size(files,1));
    for i = 1:size(files,1)
        totalMoney = modifiedData(i).profit + money;
        modifiedData(i).profitPercentage = diff(totalMoney) ./ totalMoney(1:end-1);
        
    end
    
    %nupiesiam bendra portfelio pelna
    subplot(3,3,7);
    plot(answer.date, answer.profit, answer.date, answer.holdProfit);
    title('Bendras pelnas');
    ylabel('Pelnas');
    xlabel('Laikas');
    legend('Optimized profit', 'Not optimized profit', 'Location', 'southeast');
    matrixPlot(modifiedData,files);
end
function [hasCollapsed] =  buySell(data1, data2, data, startIndex, endIndex, money, taxes, percentage)
    %susikuriamas struct'as
    hasCollapsed.values(startIndex:endIndex) = 0;
    hasCollapsed.money = money;
    hasCollapsed.moneyHistory(1) = money;
    hasCollapsed.shares = 0;
    hasCollapsed.profit(1) = 0;
    hasCollapsed.buyIndex = 0;  
    hasCollapsed.sellIndex = 0;
    
    hasCollapsed.holdProfit(1) = 0;
    hasCollapsed.holdShares = 0;
    hasCollapsed.holdLeft = 0;
    for i=(startIndex+1):endIndex
        %siandienos kaina
        price = data.close(i);
           % hasCollapsed.profit(i) = hasCollapsed.profit(i - 1);
        %paziurima kiek akciju galima nusipirkti
        hasCollapsed.moneyHistory(i) = hasCollapsed.moneyHistory(i-1);
        hasCollapsed.profit(i) = hasCollapsed.money + hasCollapsed.shares * price - money;
        hasCollapsed.profitPercentage(i) = hasCollapsed.profit(i) - hasCollapsed.profit(i-1);%(((hasCollapsed.profit(i) * 100) / hasCollapsed.profit(i-1)) - 100) / 100;
        
        sub = floor(hasCollapsed.money / price);
        hasCollapsed.holdShares = floor(money / data.close(startIndex+1));
        hasCollapsed.holdProfit(startIndex+1) = money - (hasCollapsed.holdShares * price) - (hasCollapsed.holdShares * taxes)-abs(money);
        hasCollapsed.holdLeft = money - hasCollapsed.holdProfit(startIndex+1);
        %jeigu kainos kyla per daug ilgai, tai nusprendzia kada reikia
        %parduoti
        if((checkIfLoss(data.close, hasCollapsed.buyIndex, hasCollapsed.sellIndex, i, percentage) == 2))
            %jeigu neturi akciju, tai nieko neparduoda
            if(hasCollapsed.shares <= 0) 
                continue;
            end
            %kitu atveju parduoda visas akcijas, kurias turi
            hasCollapsed.profit(i) = hasCollapsed.profit(i) - (sub * taxes);
            hasCollapsed.profitPercentage(i) = hasCollapsed.profit(i) - hasCollapsed.profit(i-1);%(((hasCollapsed.profit(i) * 100) / hasCollapsed.profit(i-1)) - 100) / 100;
            hasCollapsed.money = hasCollapsed.money + (sub * price) - (sub * taxes);
            hasCollapsed.moneyHistory(i) = hasCollapsed.money;
            hasCollapsed.shares = hasCollapsed.shares - sub;
            hasCollapsed.values(i) = 2;
            hasCollapsed.sellIndex = i;
            continue;
        %jeigu kaina per daug nekyla, bet susikirto indikatoriai ir wma yra
        %auksciau uz lr, tai tada reik pirkt akcijas
        elseif(checkIfCollapsed(data1, data2, i) == 1) 
            %jeigu neturi pinigu, tai nieko nedaro
            if(hasCollapsed.money <= 0)
                continue;
            end
            %kitu atveju nusiperka akciju uz visus pinigus
            hasCollapsed.profit(i) = hasCollapsed.profit(i) - (sub * taxes);
            hasCollapsed.profitPercentage(i) = hasCollapsed.profit(i) - hasCollapsed.profit(i-1);%(((hasCollapsed.profit(i) * 100) / hasCollapsed.profit(i-1)) - 100) / 100;
            hasCollapsed.money = hasCollapsed.money - (sub * price) - (sub * taxes);
            hasCollapsed.moneyHistory(i) = hasCollapsed.money;
            hasCollapsed.shares = hasCollapsed.shares + sub;
            hasCollapsed.values(i) = 1;
            hasCollapsed.buyIndex = i;
            continue;
        %jeigu susikirto indikatoriai ir wma yra zemiau nei lr, tai tada
        %reik parduot akcijas
        elseif(checkIfCollapsed(data1, data2, i) == -1) 
            %jeigu neturejo akciju, tai nieko parduot nereik
            if(hasCollapsed.shares <= 0) 
                continue;
            end
            %neperkam is karto ateje i rinka, reikia siek tiek palaukti
            if(hasCollapsed.buyIndex == 0)
                continue;
            end
            %parduoda akcijas tik jei pries tai pirko, nes jei pries tai
            %pardave, tai neparduos i minusa
            if(hasCollapsed.sellIndex > hasCollapsed.buyIndex)
                continue;
            end
            %kitu atveju parduoda visas turetas akcijas
            hasCollapsed.profit(i) = hasCollapsed.profit(i) - (sub * taxes);
            hasCollapsed.profitPercentage(i) = hasCollapsed.profit(i) - hasCollapsed.profit(i-1);%(((hasCollapsed.profit(i) * 100) / hasCollapsed.profit(i-1)) - 100) / 100;
            hasCollapsed.money = hasCollapsed.money + (sub * price) - (sub * taxes);
            hasCollapsed.moneyHistory(i) = hasCollapsed.money;
            hasCollapsed.shares = hasCollapsed.shares - sub;
            hasCollapsed.values(i) = -1;
            hasCollapsed.sellIndex = i;
            continue;
        end
        hasCollapsed.holdProfit(i) = (hasCollapsed.holdShares * price)- abs(money);
    end
end
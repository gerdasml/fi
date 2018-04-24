function [hasCollapsed] =  buySell(data1, data2, data, startIndex, endIndex, money, taxes, percentage)
    %susikuriamas struct'as
    hasCollapsed.values(startIndex:endIndex) = 0;
    hasCollapsed.money = money;
    hasCollapsed.shares = 0;
    hasCollapsed.profit(1) = 0;
    hasCollapsed.buyIndex = 0;
    hasCollapsed.sellIndex = 0;
    for i=(startIndex+1):endIndex
        %siandienos kaina
        price = data.close(i);
        %paziurima kiek akciju galima nusipirkti
        sub = floor(money / price);
        %jeigu kainos kyla per daug ilgai, tai nusprendzia kada reikia
        %parduoti
        if((checkIfLoss(data.close, hasCollapsed.buyIndex, hasCollapsed.sellIndex, i, percentage) == 2))
            %jeigu neturi akciju, tai nieko neparduoda
            if(hasCollapsed.shares <= 0) 
                hasCollapsed.profit(i) = hasCollapsed.money + (hasCollapsed.shares * price) - abs(money);
                hasCollapsed.profitPercentage(i) = (hasCollapsed.money + (hasCollapsed.shares * price) - abs(money) - hasCollapsed.profit(i-1)) / money;
                continue;
            end
            %kitu atveju parduoda visas akcijas, kurias turi
            hasCollapsed.money = hasCollapsed.money + (sub * price) - (sub * taxes);
            hasCollapsed.shares = hasCollapsed.shares - sub;
            hasCollapsed.values(i) = 2;
            hasCollapsed.sellIndex = i;
        %jeigu kaina per daug nekyla, bet susikirto indikatoriai ir wma yra
        %auksciau uz lr, tai tada reik pirkt akcijas
        elseif(checkIfCollapsed(data1, data2, i) == 1) 
            %jeigu neturi pinigu, tai nieko nedaro
            if(hasCollapsed.money <= 0)
                hasCollapsed.profit(i) = hasCollapsed.money + (hasCollapsed.shares * price);
                hasCollapsed.profitPercentage(i) = (hasCollapsed.money + (hasCollapsed.shares * price)- hasCollapsed.profit(i-1)) / money;
                continue;
            end
            %kitu atveju nusiperka akciju uz visus pinigus
            hasCollapsed.money = hasCollapsed.money - (sub * price) - (sub * taxes);
            hasCollapsed.shares = hasCollapsed.shares + sub;
            hasCollapsed.values(i) = 1;
            hasCollapsed.buyIndex = i;
        %jeigu susikirto indikatoriai ir wma yra zemiau nei lr, tai tada
        %reik parduot akcijas
        elseif(checkIfCollapsed(data1, data2, i) == -1) 
            %jeigu neturejo akciju, tai nieko parduot nereik
            if(hasCollapsed.shares <= 0) 
                hasCollapsed.profit(i) = hasCollapsed.money + (hasCollapsed.shares * price) - abs(money);
                hasCollapsed.profitPercentage(i) = (hasCollapsed.money + (hasCollapsed.shares * price) - abs(money) - hasCollapsed.profit(i-1)) / money;
                continue;
            end
            %neperkam is karto ateje i rinka, reikia siek tiek palaukti
            if(hasCollapsed.buyIndex == 0)
                hasCollapsed.profit(i) = hasCollapsed.money + (hasCollapsed.shares * price);
                hasCollapsed.profitPercentage(i) = (hasCollapsed.money + (hasCollapsed.shares * price) - hasCollapsed.profit(i-1)) / money;
                continue;
            end
            %parduoda akcijas tik jei pries tai pirko, nes jei pries tai
            %pardave, tai neparduos i minusa
            if(hasCollapsed.sellIndex > hasCollapsed.buyIndex)
                hasCollapsed.profit(i) = hasCollapsed.money + (hasCollapsed.shares * price) - abs(money);
                hasCollapsed.profitPercentage(i) = (hasCollapsed.money + (hasCollapsed.shares * price) - abs(money) - hasCollapsed.profit(i-1)) / money;
                continue;
            end
            %kitu atveju parduoda visas turetas akcijas
            hasCollapsed.money = hasCollapsed.money + (sub * price) - (sub * taxes);
            hasCollapsed.shares = hasCollapsed.shares - sub;
            hasCollapsed.values(i) = -1;
            hasCollapsed.sellIndex = i;
        end
        hasCollapsed.profit(i) = hasCollapsed.money + (hasCollapsed.shares * price) - abs(money);
        hasCollapsed.profitPercentage(i) = (hasCollapsed.money + (hasCollapsed.shares * price) - abs(money) - hasCollapsed.profit(i-1))/ money;
    end
end
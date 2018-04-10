function [hasCollapsed] =  buySell(data1, data2, data, startIndex, endIndex, money, taxes, percentage)
    hasCollapsed.values(startIndex:endIndex) = 0;
    hasCollapsed.money = money;
    hasCollapsed.shares = 0;
    hasCollapsed.profit(1) = 0;
    hasCollapsed.buyIndex = 0;
    hasCollapsed.sellIndex = 0;
    for i=(startIndex+1):endIndex
        price = data.close(i);
        sub = floor(money / price);
        if((checkIfLoss(data.close, hasCollapsed.buyIndex, hasCollapsed.sellIndex, i, percentage) == 2))
            if(hasCollapsed.shares <= 0) 
                hasCollapsed.profit(i) = hasCollapsed.money + (hasCollapsed.shares * price) - money;
                hasCollapsed.profitPercentage(i) = (hasCollapsed.money + (hasCollapsed.shares * price) - money - hasCollapsed.profit(i-1)) / money;
                continue;
            end
            hasCollapsed.money = hasCollapsed.money + (sub * price) - (sub * taxes);
            hasCollapsed.shares = hasCollapsed.shares - sub;
            hasCollapsed.values(i) = 2;
            hasCollapsed.sellIndex = i;
        elseif(checkIfCollapsed(data1, data2, i) == 1) 
            if(hasCollapsed.money <= 0)
                hasCollapsed.profit(i) = hasCollapsed.money + (hasCollapsed.shares * price);
                hasCollapsed.profitPercentage(i) = (hasCollapsed.money + (hasCollapsed.shares * price)- hasCollapsed.profit(i-1)) / money;
                continue;
            end
            hasCollapsed.money = hasCollapsed.money - (sub * price) - (sub * taxes);
            hasCollapsed.shares = hasCollapsed.shares + sub;
            hasCollapsed.values(i) = 1;
            hasCollapsed.buyIndex = i;
        elseif(checkIfCollapsed(data1, data2, i) == -1) 
            if(hasCollapsed.shares <= 0) 
                hasCollapsed.profit(i) = hasCollapsed.money + (hasCollapsed.shares * price) - money;
                hasCollapsed.profitPercentage(i) = (hasCollapsed.money + (hasCollapsed.shares * price) - money - hasCollapsed.profit(i-1)) / money;
                continue;
            end
            if(hasCollapsed.buyIndex == 0)
                hasCollapsed.profit(i) = hasCollapsed.money + (hasCollapsed.shares * price);
                hasCollapsed.profitPercentage(i) = (hasCollapsed.money + (hasCollapsed.shares * price) - hasCollapsed.profit(i-1)) / money;
                continue;
            end
            if(hasCollapsed.sellIndex > hasCollapsed.buyIndex)
                hasCollapsed.profit(i) = hasCollapsed.money + (hasCollapsed.shares * price) - money;
                hasCollapsed.profitPercentage(i) = (hasCollapsed.money + (hasCollapsed.shares * price) - money - hasCollapsed.profit(i-1)) / money;
                continue;
            end
            hasCollapsed.money = hasCollapsed.money + (sub * price) - (sub * taxes);
            hasCollapsed.shares = hasCollapsed.shares - sub;
            hasCollapsed.values(i) = -1;
            hasCollapsed.sellIndex = i;
        end
        hasCollapsed.profit(i) = hasCollapsed.money + (hasCollapsed.shares * price) - money;
        hasCollapsed.profitPercentage(i) = (hasCollapsed.money + (hasCollapsed.shares * price) - money - hasCollapsed.profit(i-1))/ money;
    end
end
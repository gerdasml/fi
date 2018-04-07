function [hasCollapsed] =  buySell(data1, data2, data, startIndex, endIndex, money, taxes)
    hasCollapsed.values(startIndex:endIndex) = 0;
    hasCollapsed.money = money;
    hasCollapsed.shares = 0;
    hasCollapsed.profit(1) = 0;
    for i=(startIndex+1):endIndex
        price = data.close(i);
        if(checkIfCollapsed(data1, data2, i) == 1) 
            if(hasCollapsed.money <= 0)
                hasCollapsed.profit(i) = hasCollapsed.money + (hasCollapsed.shares * price) - money;
                continue;
            end
            sub = floor(money / price);
            hasCollapsed.money = hasCollapsed.money - (sub * price) - (sub * taxes);
            hasCollapsed.shares = hasCollapsed.shares + sub;
            hasCollapsed.values(i) = 1;
        end
        if(checkIfCollapsed(data1, data2, i) == -1) 
            if(hasCollapsed.shares <= 0) 
                hasCollapsed.profit(i) = hasCollapsed.money + (hasCollapsed.shares * price) - money;
                continue;
            end
            hasCollapsed.money = hasCollapsed.money + (sub * price) - (sub * taxes);
            hasCollapsed.shares = hasCollapsed.shares - sub;
            hasCollapsed.values(i) = -1;
        end
        hasCollapsed.profit(i) = hasCollapsed.money + (hasCollapsed.shares * price) - money;
    end
end
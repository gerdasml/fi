function [hasCollapsed] =  buySell(data1, data2, data, startIndex, endIndex, money)
    hasCollapsed.values(startIndex:endIndex) = 0;
    hasCollapsed.money = money;
    hasCollapsed.shares = 0;
    for i=(startIndex+1):endIndex
        if(checkIfCollapsed(data1, data2, i) == 1) 
            if(hasCollapsed.money <= 0)
                continue;
            end
            price = data.close(i);
            sub = floor(money / price);
            hasCollapsed.money = hasCollapsed.money - (sub * price);
            hasCollapsed.shares = hasCollapsed.shares + sub;
            hasCollapsed.values(i) = 1;
        end
        if(checkIfCollapsed(data1, data2, i) == -1) 
            if(hasCollapsed.shares <= 0) 
                continue;
            end
            price = data.close(i);
            if(hasCollapsed.shares > 100)
                sub = hasCollapsed.shares - 10;
            else
                sub = hasCollapsed.shares - 1;
            end
            hasCollapsed.money = hasCollapsed.money + (sub * price);
            hasCollapsed.shares = hasCollapsed.shares - sub;
            hasCollapsed.values(i) = -1;
        end
    end
end
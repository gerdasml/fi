function [hasCollapsed] =  buySell(data1, data2, startIndex, endIndex)
    hasCollapsed.values(1) = 0;
    for i=(startIndex+1):endIndex
        hasCollapsed.values(i) = checkIfCollapsed(data1, data2, i);
    end
end
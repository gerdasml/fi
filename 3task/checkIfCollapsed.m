function [d] = checkIfCollapsed(data1, data2, index)
    if((data1(index) >= data2(index)) && (data1(index-1)< data2(index-1)))
        d = 1;
    elseif ((data1(index) <= data2(index)) && (data1(index-1) > data2(index-1)))
            d = -1;
    else
        d = 0;
    end
end
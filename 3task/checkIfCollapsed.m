function [d] = checkIfCollapsed(data1, data2, index)
    %jeigu tikrinant nuo vakar indikatoriai susikirto ir wma auksciau, tai
    %reikia pirkti
    if((data1(index) >= data2(index)) && (data1(index-1)< data2(index-1)))
        d = 1;
    %jeigu susikirto ir wma zemiau, tai reikia parduoti
    elseif ((data1(index) <= data2(index)) && (data1(index-1) > data2(index-1)))
            d = -1;
    %kitu atveju nieko nedaryt
    else
        d = 0;
    end
end
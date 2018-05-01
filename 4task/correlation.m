function [matrix] = correlation(data)
    matrix = zeros(size(data, 2));
    for i = 1:size(data, 2)
        for j = i:size(data,2)
            %paskaiciuojama koreliacijos matrica
            M = corrcoef(data(i).profitPercentage, data(j).profitPercentage);
            %pasiimam koeficienta
            cof = M(1,2);
            %irasom i atitinkamus matricos laukelius
            matrix(i,j) = cof;
            matrix(j,i) = cof;
        end
    end
end
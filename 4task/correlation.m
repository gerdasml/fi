function [matrix] = correlation(data)
    matrix = zeros(size(data, 2));
    for i = 1:size(data, 2)
        for j = i:size(data,2)
            %paskaiciuojama koreliacijos matrica
            M = corrcoef(data(i).profit, data(j).profit);
            %pasiimam koeficienta
            cof = M(1,2);
            %irasom i atitinkamus matricos laukelius
            matrix(i,j) = cof;
            matrix(j,i) = cof;
        end
    end
end
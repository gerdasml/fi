function [d] = checkIfLoss(price, buyIndex, sellIndex, index, percentage)
    d = 0;
    %jeigu kainu skirtumas virsijo take profit riba, tai reikia parduot
    if(buyIndex > sellIndex)
        if((price(index) / price(buyIndex)) > percentage)
            d = 2;
        end
    end
end
function [d] = checkIfLoss(price, buyIndex, sellIndex, index, percentage)
    d = 0;
    if(buyIndex > sellIndex)
        if((price(index) / price(buyIndex)) > percentage)
            d = 2;
        end
    end
end
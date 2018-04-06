function [data] = generate(startDate)
    % susigeneruojam, kiek noresim tasku atvaizduoti
    n = randi(100,1)+30;
    data.dateTime = startDate + caldays(1:1:n);
    data.low = randi(100,1,n) ;
    data.close = data.low + randi(20,1,n);
    data.open = data.low + randi(20,1,n);
    data.high = max(data.close, data.open) + randi(100,1,n);
end
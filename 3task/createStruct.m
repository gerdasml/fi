function [data] = createStruct(d, type)
    from = datetime(2013,01,02);
    %from = datetime(2015,09,01);
    %from = datetime(2013,10,01);
    to = from + caldays(500);
    tf = find(isbetween(d.dateTime, from, to));
    data.dateTime = d.dateTime(tf);
    data.high = d.high(tf);
    data.low = d.low(tf);
    data.open = d.open(tf);
    data.close = d.close(tf);
    if strcmp('min', type)
        data.up = d.up(tf);
        data.down = d.down(tf);
    end
    if strcmp('day', type)
        data.volume = d.volume(tf);
        data.oi = d.oi(tf);
    end
end
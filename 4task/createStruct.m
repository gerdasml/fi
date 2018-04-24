function [data] = createStruct(d, type, from, to)
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
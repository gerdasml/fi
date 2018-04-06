function [data] = createStruct(d)
    from = datetime(2018,03,02);
    to = from + caldays(1);
    tf = find(isbetween(d.dateTime, from, to));
    data.dateTime = d.dateTime(tf);
    data.high = d.high(tf);
    data.low = d.low(tf);
    data.open = d.open(tf);
    data.close = d.close(tf);
    data.up = d.up(tf);
    data.down = d.down(tf);
end
function plotas(data, type, x, y, name, from, to)
    timeFormat = '';
    % patikrina ar yra optional variables
    if ~exist('to', 'var') 
        % by default vaizduoja vienos dienos grafika
        to = from + caldays(1);
    end
    if strcmp('min', type) 
       timeFormat = 'HH:MM';
    end
    if strcmp('day', type)
        timeFormat = 'yyyy-mm-dd';
    end
    % cia yra surandamos datos is duomenu tarp pateikto vartotojo laiko
    % intervalo
    data.dateTime
    tf = find(isbetween(data.dateTime, from, to));
    % nupiesiamas candle bar. Reikia prirasyt ', nes candle reikalauja
    % stulpeliniu vektoriu
    candle(data.high(tf)', data.low(tf)', data.close(tf)', data.open(tf)', 'red', data.dateTime(tf)', timeFormat);
    % uzdedam asiu pavadinimus ir grafiko pavadinima
    title(name);
    xlabel(x);
    ylabel(y);
    axis tight;
    % rasta alternatyva, kuri piesia dviem spalvom
    %cndl(data.high, data.low, data.open, data.close);
end
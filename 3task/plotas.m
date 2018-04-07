function plotas(data, type, x, y, name, from, to, interval)
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
        timeFormat = 'mm-yyyy';
    end
    % cia yra surandamos datos is duomenu tarp pateikto vartotojo laiko
    % intervalo
    data.dateTime;
    tf = find(isbetween(data.dateTime, from, to));
    
    filterData.high = data.high(tf);
    filterData.low = data.low(tf);
    filterData.close = data.close(tf);
    filterData.open = data.open(tf);
    filterData.dateTime = data.dateTime(tf);
    %(interval+1:end) - atkertam pirmus interval dydzio elementus
    % nupiesiamas candle bar. Reikia prirasyt ', nes candle reikalauja
    % stulpeliniu vektoriu
    candle(filterData.high((interval+1):end)', filterData.low((interval+1):end)', filterData.close((interval+1):end)', filterData.open((interval+1):end)', 'k', datenum(filterData.dateTime((interval+1):end)'), timeFormat);
    % uzdedam asiu pavadinimus ir grafiko pavadinima
    title(name);
    ylabel(y);
    xlabel(x);
    axis tight;
end
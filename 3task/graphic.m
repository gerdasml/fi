function graphic(xx, y1, y2, dayData, interval, bs)
    figure(1);
    h1 = subplot(7, 1, [1 4]); 
    %plotas(dayData, 'day', 'Laikas', 'Akciju verte', 'Intc 500 dienu duomenys nuo 2013-01-02', datetime(2013, 1, 2), datetime(2013, 1, 2) + caldays(500), interval);
    plotas(dayData, 'day', 'Laikas', 'Akciju verte', 'Tesla 500 dienu duomenys nuo 2015-09-01', datetime(2015, 9, 1), datetime(2015, 9, 1) + caldays(500), interval);
    %plotas(dayData, 'day', 'Laikas', 'Akciju verte', 'Apple 500 dienu duomenys nuo 2013-10-01', datetime(2013, 10, 1), datetime(2013, 10, 1) + caldays(500), interval);
    %plotas(dayData, 'day', 'Laikas', 'Akciju verte', 'Apple 500 dienu duomenys nuo 2016-04-08', datetime(2016, 4, 8), datetime(2016, 4, 8) + caldays(500), interval);
    hold on;
    h(1) = plot(xx, y1, 'm', 'DisplayName', 'WMA indicator');
    hold on;
    h(2) = plot(xx, y2, 'b', 'DisplayName', 'LR indicator');
    for i=1:size(y1, 2)
        if(bs.values(i) == 1)
            hold on;
            h(3) = plot(xx(i), y1(i), 'o', 'DisplayName', 'Buy', 'MarkerFaceColor', 'g');
        end
        if(bs.values(i) == -1)
            hold on;
            h(4) = plot(xx(i), y1(i), 'o', 'DisplayName', 'Sell', 'MarkerFaceColor', 'r');
        end
        if(bs.values(i) == 2)
            hold on;
            h(5) = plot(xx(i), y1(i), 's', 'DisplayName', 'Take profit', 'MarkerFaceColor', 'y');
        end
    end
    legend(h(1:end), 'Location','northwest');
    axis tight;
    
    h2 = subplot(7,1,[6 7]);
    plot(xx, bs.profit);
    datetick('x','mm-YYYY');
    linkaxes([h1,h2],'x');
    axis tight;
end
function graphic(xx, y1, y2, dayData, interval, bs, name, xx2, bs2)
    figure('Name',name);
    h1 = subplot(7, 1, [1 4]); 
    plotas(dayData, 'day', 'Laikas', 'Akciju verte', 'Apple 10 metu duomenys nuo 2007-04-02', datetime(2007, 4, 2), datetime(2007, 4, 2) + caldays(2000), interval);
    %plotas(dayData, 'day', 'Laikas', 'Akciju verte', 'Intc 500 dienu duomenys nuo 2013-01-02', datetime(2013, 1, 2), datetime(2013, 1, 2) + caldays(500), interval);
    %plotas(dayData, 'day', 'Laikas', 'Akciju verte', 'Tesla 500 dienu duomenys nuo 2015-09-01', datetime(2015, 9, 1), datetime(2015, 9, 1) + caldays(500), interval);
    %plotas(dayData, 'day', 'Laikas', 'Akciju verte', 'Apple 500 dienu duomenys nuo 2013-10-01', datetime(2013, 10, 1), datetime(2013, 10, 1) + caldays(500), interval);
    hold on;
    h(1) = plot(xx, y1, 'm', 'DisplayName', 'WMA indicator');
    hold on;
    h(2) = plot(xx, y2, 'b', 'DisplayName', 'LR indicator');
    %iteracijos metu yra pildomas grafikas pirkimo/pardavimo masyvo taskais
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
    
    %grafikas, rodantis pelno kitima
    h2 = subplot(7,1,[6 7]);
    %jeigu main'e buvo paduota dviem parametrais maziau, tai tada
    %neoptimizuotas sprendimo budas ir reikia vaizduot taip
    if ~exist('xx2', 'var') && ~exist('bs2', 'var')
        plot(xx, bs.profit);
    %kitu atveju vaizduoti taip, apkarpant masyvo dydzius, kad butu galima
    %graziai atvaizduoti
    elseif size(xx, 2) >= size(xx2, 2)
        start = (abs(size(xx,2) - size(xx2, 2))+1);
        plot(xx(start:end), bs.profit(start:end), xx2, bs2.profit);
        legend('Optimized profit', 'Not optimized profit', 'Location', 'southeast');
    else
        start = (abs(size(xx2,2) - size(xx, 2))+1);
        plot(xx, bs.profit, xx2(start:end), bs2.profit(start:end));
        legend('Optimized profit', 'Not optimized profit', 'Location', 'southeast');
    end
    datetick('x','mm-YYYY');
    linkaxes([h1,h2],'x');
    title('Pelno kitimo grafikas');
    ylabel('Pelnas');
    xlabel('Laikas');
    axis tight;
    axis tight;
end
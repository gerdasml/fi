function plotTwoGraphs(xx, y1, y2, data, interval)
    plotas(data, 'day', 'Laikas', 'Akciju verte', 'pavadinimas', datetime(2013, 7, 1), datetime(2013, 7, 1) + caldays(500), interval); 
    hold on;
    plot(xx, y1, xx, y2);
end
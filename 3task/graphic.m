function graphic(xx, y1, y2, minData, interval)
    figure(1);
    %subplot(2, 1, 1); 
    plotas(minData, 'day', 'Laikas', 'Akciju verte', 'Tesla minutiniai duomenys 2018-03-02', datetime(2013, 7, 1), datetime(2013, 7, 1) + caldays(500), interval);
    %subplot(2,1,2); 
    hold on;
    plot(xx, y1, 'r');
    hold on;
    plot(xx, y2, 'b');
    %title(name);
    %ylabel(yName);
    %xlabel(xName);
    axis tight;
end
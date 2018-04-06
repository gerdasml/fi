function oneLinePlot(xx, yy, minData, interval, name, yName, xName)
    figure(1);
    subplot(2, 1, 1); 
    plotas(minData, 'min', 'Laikas', 'Akciju verte', 'Tesla minutiniai duomenys 2018-03-02', datetime(2018, 3, 2), datetime(2018, 3, 3), interval);
    subplot(2,1,2); 
    plot(xx, yy);
    title(name);
    ylabel(yName);
    xlabel(xName);
    axis tight;
end
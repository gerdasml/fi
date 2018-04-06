function twoLinePlot(xx, yy1, yy2, minData, interval)
    figure(1);
    subplot(7, 1, [1 4]); 
    plotas(minData, 'min', 'Laikas', 'Akciju verte', 'Tesla minutiniai duomenys 2018-03-02', datetime(2018, 3, 2), datetime(2018, 3, 3), interval);
    subplot(7,1,[6 7]);
    plot(xx, yy1, xx, yy2);
    title("Aroon indikatorius");
    ylabel("Indikatoriaus reiksme");
    xlabel("Laikas");
    legend('Up','Down')
    axis tight;
end
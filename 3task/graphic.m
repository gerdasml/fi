function graphic(xx, y1, y2, minData, interval, values)
    figure(1);
    %subplot(2, 1, 1); 
    plotas(minData, 'day', 'Laikas', 'Akciju verte', 'Tesla 500 dienu duomenys nuo 2013-07-01', datetime(2013, 7, 1), datetime(2013, 7, 1) + caldays(500), interval);
    %subplot(2,1,2); 
    hold on;
    h(1) = plot(xx, y1, 'm', 'DisplayName', 'WMA indicator');
    hold on;
    h(2) = plot(xx, y2, 'b');
    for i=1:size(y1, 2)
        if(values(i) == 1)
            hold on;
            h(3) = plot(xx(i), y1(i), 'o', 'MarkerFaceColor', 'g');
        end
        if(values(i) == -1)
            hold on;
            h(4) = plot(xx(i), y1(i), 'o', 'MarkerFaceColor', 'r');
        end
    end
    legend(h(1:4),'WMA indicator', 'LR indicator', 'Buy', 'Sell', 'Location','northwest');
    axis tight;
end
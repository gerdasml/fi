function subGraphic(files, i, wmaData, op)
    graphTitle = strcat(erase(files(i).name, '.csv'), ' pelnas');
    subplot(3,3,i);
    plot(datenum(wmaData.dateTime), op(i).profit);
    title(graphTitle);
    ylabel('Pelnas');
    xlabel('Laikas (datetick)');
    hold on;
    axis tight;
end
function matrixPlot(modifiedData, files)
    %skaiciuojam koreliacijos matrica ir ja atviazduojam
    matrix = correlation(modifiedData);
    uf = uifigure;
    names = strings([1 size(files,1)]);
    for i = size(files,1):-1:1
        names(i) = erase(files(i).name, '.csv');
    end
    t = uitable(uf,'Data', matrix,'Position',[20 20 700 300]);
    t.ColumnName = names;
    t.RowName = names;
end
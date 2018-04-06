function breaks(data, count)
    % paskaiciuoja skirtumus tarp datu
    diffs = diff(data);
    % isrikiuoja pagal didziausius skirtumus
    [~, ind] = sort(diffs, 'descend');
    % atrenka didziausiu skirtumu indeksus
    biggestIndices = ind(1:min(end, count));
    % pagal tuos indeksus atrenka kurios tai buvo datos
    startDates = data(biggestIndices);
    % pagal tuos indeksus atrenka skirtumus
    biggestDiffs = diffs(biggestIndices);
    arrayfun(@print, biggestDiffs, startDates);
end

function print(diff, start)
    fprintf("Pertrauka prasidejo %s ir baigesi %s (trukme %f d.)\n", datestr(start), datestr(start + diff), days(diff));
end
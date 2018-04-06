function [d] = groups(data, time)
    % splitapply iskaido visus duomenis pagal kazkoki pozymi i grupes 
    % (pvz pagal ta pacia minute) ir kiekvienai grupei pritaiko paduota 
    % funkcija ir gautus rezultatus suagreguoja i nauja masyva. 
    
    % problema su splitapply yra ta, jog jai reikia masyvo duomenu. o mes
    % turim tik viena objekta, kuriame yra atskiri masyvai (dateTime
    % masyvas, up masyvas ir t.t.). Del to reikia data transformuot i
    % kitokia duomenu struktura (i masyva strukturu). Cia padeda arrayfun.
    % Jam paduodame visus masyvus atskirai ir funkcija, mokancia apjungti
    % po viena masyvo elementa is kiekvieno masyvo, o ji grazina visus tuos
    % duomenis apjungtus i masyva. 
    transformedData = arrayfun(@mapData, data.dateTime, data.low, data.high, data.open, data.close, data.up, data.down);
    groupIndices = findgroups(dateshift(data.dateTime, 'start', time));
    groupedData = splitapply(@compressToBar, transformedData, groupIndices);
    d = arrayToStruct(groupedData);
end

function [d] = mapData(dateTime, low, high, open, close, up, down)
    d.dateTime = dateTime;
    d.low = low;
    d.high = high;
    d.open = open;
    d.close = close;
    d.up = up;
    d.down = down;
end

function [modifiedData] = compressToBar(data)
    d = arrayToStruct(data);
    modifiedData.low = min(d.low);
    modifiedData.high = max(d.high);
    modifiedData.up = sum(d.up);
    modifiedData.down = sum(d.down);
    modifiedData.open = d.open(1);
    modifiedData.close = d.close(end);
    modifiedData.dateTime = dateshift(d.dateTime(1) + minutes(1),'start','minute'); 
end

function [d] = arrayToStruct(data)
    % data yra masyvas, o bandant prieit jame esanciu strukturu laukus
    % tiesiai per pati data, grazinami kiekvieno masyvo elemento
    % strukturos laukai po viena. Apskliaudus tai lauztiniais skliaustais,
    % is siu reiksmiu suformuojamas naujas masyvas.
    d.dateTime = [data.dateTime];
    d.low = [data.low]; 
    d.high = [data.high];
    d.open = [data.open];
    d.close = [data.close];
    d.up = [data.up];
    d.down = [data.down];
end
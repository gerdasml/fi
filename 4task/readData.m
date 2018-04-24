function [d] = readData(fileName, type)
    fid = fopen(fileName);
    % nurodom kokio tipo reiksmes nuskaitom, jog jos atskirtos kableliais
    % ir kad pirma eilute bus antraste, todel ja reikia ignoruoti
    b = textscan(fid,'%s %s %f %f %f %f %f %f','Delimiter',',','HeaderLines',1);
    fclose(fid);
    
    % sujungiame duomenu data su laiku i viena kintamaji. Rasome b{1,1},
    % nes taip sujungiam pirmos eilutes pirma ir antra stulpelius
    joined = strcat(b{1,1}, " ", b{1,2});
    % stringu palyginimas vyksta per strcmp
    if strcmp('tick', type)
        % datetime pavercia i datos duomenu formata
        d.dateTime = datetime(cellstr(joined),'InputFormat', 'MM/dd/yyyy HH:mm:ss')';
    else
        d.dateTime = datetime(cellstr(joined),'InputFormat', 'MM/dd/yyyy HH:mm')';
    end
    % b{3}' yra su ', nes duomenys buvo stulpeliais, tai padarem eilutem
    d.open = b{3}';
    d.high = b{4}';
    d.low = b{5}';
    d.close = b{6}';
    if strcmp('tick', type) || strcmp('min', type)
        d.up = b{7}';
        d.down = b{8}';
    end
    if strcmp('day', type)
        d.volume = b{7}';
        d.oi = b{8}';
    end
end

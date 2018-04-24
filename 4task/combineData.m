%si funkcija sulygina dvieju skirtingu laiko eiluciu duomenis papildant 
%tuscias dienas arba jas istrinant
function [a, newAnswer] = combineData(op, ArrSize)
    answer.dates = op(1).date;
    %padaroma visu duomenu datu sajunga, kad gautume visas prekybos dienas
    for i = 2:ArrSize
        answer.dates = union(answer.dates, op(i).date);
    end
    newAnswer = [];
    for i = ArrSize:-1:1
        newAnswer(i).dates = answer.dates;
        newAnswer(i).profit = zeros(1,size(answer.dates, 2));
        startz = 1;
        for j = 1:size(answer.dates, 2)
            isFound = false;
            foundProfit = 0;
            for z = startz:size(op(i).date, 2)
                %jeigu is visu datu randam data, kuri sutampa, tai isirasom
                %pelna
                if op(i).date(z) == answer.dates(j)
                    isFound = true;
                    foundProfit = op(i).profit(z);
                    startz = z;
                    break;
                end
                if op(i).date(z) > answer.dates(j)
                    startz = z;
                    break;
                end
            end
            if isFound
                newAnswer(i).profit(j) = foundProfit;
            else
                if(j == 1)
                    newAnswer(i).profit(j) = 0;
                else
                    %jeigu ta diena duomenu nera, tai uzrasom vakar dienos
                    %pelnu
                    newAnswer(i).profit(j) = newAnswer(i).profit(j-1);
                end
            end
        end
    end
    a.date = newAnswer(1).dates;
    a.profit = zeros(1,size(a.date, 2));
    %cia skaiciuojamas bendras viso portfelio pelnas
    for i = 1:size(answer.dates, 2)
        for j = 1:ArrSize
            a.profit(i) = a.profit(i) + newAnswer(j).profit(i);
        end
    end
end
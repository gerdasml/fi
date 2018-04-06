function simpleGraph(data,x, y, name)
    %dar reikia uzdet pavadinimus ant asiu
    plot(data.low);
    title(name);
    ylabel(y);
    xlabel(x);
    axis tight;
end
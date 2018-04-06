%% 1. suma dvieju vektoriu
% randn(a, b) - grazina a x b matrica
a = randn(1,10);    % sugeneruojam du masyvus
b = randn(1,10);
c = sum(a + b);     % a + b padaro, jog gaunamas masyvas, kurio reiksmes 
% yra atitinkamai a ir b suma, o sum sudeda visus naujai gauto masyvo 
% elementus
disp(c);

%% 2. anuliavimas teigiamu elementu 
a = randn(1, 10);
a (a > 0) = 0;  % parasom skliausteliuose predikata, kuris nusako, kokius 
% elementus paimti, tuomet atrinktus elementus pakeiciam i 0
% a = min(0, a); % dar galimas ir toks variantas (paliekam minimuma)
disp(a);

%% 3. ismetimas > 6 
% randi(a, b, c) - grazina b x c matrica, elementu reiksme tarp 1 ir a
a = randi(10, 1, 10);
b = a (a <= 6);     % atrenkam is masyvo a tik tuos elementus, kurie 
% mazesni uz 7, taip galima padaryti parasant predikata
disp(a);
disp(b);

%% 4. dvieju vienodu salia esanciu radimas 
disp('-------------');
a = randi(5, 1, 10);
disp(a);
disp('-------------');
i = 2:length(a);  % i nurodo indeksus nuo 2 iki 10
j = i(a(i) == a (i - 1));   % irasom i j tik tuos indeksus, kurie tenkina 
% salyga
disp(j);

%% 5. elementu, kur a elementai didesni uz b elementus, radimas
disp('--------------');
a = randn(1, 10);
b = randn(1, 10);
disp(a);
disp(b);
i = 1:length(a);  % i sudaro indeksai nuo 1 iki 10
j = i(a(i) > b(i)); % iraso tik tuos indeksus, kur a didesnis uz b. 
% Kadangi skliaustuose logine israiska, tai atrenka tik tuos indeksus,
% kurie tenkina salyga
disp(j);

%% 6. elementu perstumimas vektoriuje pakartojant paskutini
disp('----------');
a = randi(10,1,10);
disp(a);

% galima ir kitaip:
% c = a;
% d = [c(2:end) c(end)];

% circshift(A, K, dim) - A tai masyvas, K - per kiek stumsim poziciju,
% dim - kaip stumsim (jei dim = 1, tai tada keiciam matricoj eilutes, 
% jei dim = 2, tai tada keiciam stulpelius)
b = circshift(a, -1, 2);
% kadangi pirmas elementas atsidure gale, tai ji uzrasom pries paskutiniu
% elementu
b(end) = b(end - 1);
disp('********');
disp(b);

%% 7. sukeitimas elementu eiles tvarkos
disp('---------');
a = randi(10, 1, 10);
disp(a);
% filp(a) - pakeicia masyvo elementu tvarka priesinga
b = flip(a);
disp(b);

%% 8. kas antro elemento uznulinimas
disp('--------');
a = randi(10, 1, 10);
disp(a);
% indeksuojam nuo 1 vietos kas dvi vietas iki galo ir tada priskiriam 0
a(1:2:end) = 0;
disp(a);

%% 9. rasti matricos eiluciu vidurkius, rasti matricos stulpeliu vidurkius
disp('-----------');
a = randn(4, 5);
disp(a);
% mean(A, dim) - A yra matrica, o dim - jei 1, tai stupeliu vidurkis, jei 2, 
% tai eiluciu vidurkis
disp(mean(a, 1));
disp(mean(a, 2));

%% 10. rasti matricos diagonalinius elementus - negalima naudoti diag
disp('----------');
disp('----------');
% randi(a, n) grazina n x n matrica, kurios kiekvienas elementas yra nuo 1
% iki a
a = randi(10, 9, 6);
disp(a);
% paskaiciuojam kas kiek elementu kartojasi istrizaines elementas, nes
% matricos gali numeruotis stulpeliais zemyn, jeigu indekse parasom tik
% viena skaiciu. Pvz a(3) yra tas pats kaip a(3, 1), o a (4) kaip a(1, 2),
% jei matrcia 3 x 3
i = 1:size(a, 1)+1:min(size(a,1), size(a,2))*size(a,1);
disp('------------');
disp(a(i));
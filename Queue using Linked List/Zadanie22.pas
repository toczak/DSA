program Zadanie22;
uses Crt,SysUtils;

type
  lista=^tlista;
  tlista = record
    imie:string[25];
    nazwisko:string[35];
    wiek:byte;
    PESEL:string;
    wsk:lista;
  end;
  tTabDyn=array of tlista;
var
  numer:integer;
  pocz,kon:lista;

function tworzTabPosort(pocz:lista; var element:integer):tTabDyn;
var
   tab: tTabDyn;
   tabtemp: tlista;
   czyZamienil:boolean;
   i:integer;
begin
  repeat
  begin
    setLength(tab,element+1);
    tab[element].imie:=pocz^.imie;
    tab[element].nazwisko:=pocz^.nazwisko;
    tab[element].wiek:=pocz^.wiek;
    tab[element].PESEL:=pocz^.PESEL;
    pocz:=pocz^.wsk;
    inc(element);
  end;
  until pocz=nil;

  repeat
  czyZamienil:=false;
      for i:=0 to element-2 do
      begin
         if tab[i].PESEL>tab[i+1].PESEL then
         begin
            tabtemp:=tab[i];
            tab[i]:=tab[i+1];
            tab[i+1]:=tabtemp;
            czyZamienil:=true;
         end;
      end;
  until czyZamienil=false;

  tworzTabPosort:=tab;
end;

procedure dodaj(var pocz,kon:lista);
var
  temp,pesel:lista;
  czyWystapil:boolean;
begin
    new(temp);
    if temp=nil then writeln('Brak miejsca w pamieci.')
    else
    begin
      writeln('Podaj imie:');
      readln(temp^.imie);
      writeln('Podaj nazwisko:');
      readln(temp^.nazwisko);
      writeln('Podaj wiek:');
      readln(temp^.wiek);
      repeat
        pesel:=pocz;
        czyWystapil:=false;
        writeln('Podaj PESEL:');
        readln(temp^.PESEL);
        if pocz<>nil then
        begin
          repeat
          if(pesel^.PESEL=temp^.PESEL) then
          begin
             writeln('Taki PESEL juz jest w kolejce!');
             czyWystapil:=true;
          end;
          pesel:=pesel^.wsk;
          until pesel=nil;
        end
      until czyWystapil=false;
      temp^.wsk:=nil;
      if pocz=nil then
        pocz:=temp
      else
        kon^.wsk:=temp;
      kon:=temp;
      writeln('---------------------');
      writeln('Dodano nowy element do kolejki.');
    end;
    writeln('Nacisnij ENTER, aby kontynuowac...');
    readln;
end;

procedure usun(var pocz,kon:lista);
var
  temp:lista;
begin
    if pocz<>nil then
    begin
      temp:=pocz;
      pocz:=pocz^.wsk;
      dispose(temp);
      writeln('Usunieto pierwszy element z kolejki.');
    end
    else writeln('Nie mozesz nic usunac, poniewaz kolejka jest pusta!');
    if pocz=nil then kon:=nil;
    writeln('Nacisnij ENTER, aby kontynuowac...');
    readln;
end;

procedure wyswietl(pocz:lista);
var
  temp:lista;
begin
  temp:=pocz;
  if temp=nil then writeln('Kolejka jest pusta.')
  else
  repeat
    begin
      writeln('Imie: ',pocz^.imie);
      writeln('Nazwisko: ',pocz^.nazwisko);
      writeln('Wiek: ',pocz^.wiek);
      writeln('PESEL: ',pocz^.PESEL);
      writeln('---------------------');
      pocz:=pocz^.wsk;
    end;
    until pocz=nil;
  writeln('Nacisnij ENTER, aby kontynuowac...');
  readln;
end;

procedure usunWszystko(var pocz,kon:lista);
var
  temp:lista;
begin
  if pocz<>nil then
  begin
    repeat
    begin
      temp:=pocz;
      pocz:=pocz^.wsk;
      dispose(temp);
    end;
    until pocz=nil;
    kon:=nil;
    writeln('Usunieto wszystkie elementy kolejki.');
  end
  else writeln('Nie mozesz usunac kolejki, poniewaz jest pusta!');
  writeln('Nacisnij ENTER, aby kontynuowac...');
  readln;
end;

procedure zapiszDoPliku(pocz:lista);
var
  tab: array of tlista;
  element,i:integer;
  txtFile:textfile;
begin
  if pocz=nil then writeln('Nie mozesz zapisac do pliku, bo kolejka jest pusta!')
  else
  begin
    element:=0;
    tab:=tworzTabPosort(pocz,element);
    assignfile(txtFile, 'kolejka.txt');
    rewrite(txtFile);
    writeln('Zapisuje...');
    for i:=0 to element-1 do
    begin
      writeln(txtFile,'Imie: ',tab[i].imie);
      writeln(txtFile,'Nazwisko: ',tab[i].nazwisko);
      writeln(txtFile,'Wiek: ',tab[i].wiek);
      writeln(txtFile,'PESEL: ',tab[i].PESEL);
      writeln(txtFile,'---------------------');
    end;
    writeln('Zapisano!');
    closefile(txtFile);
  end;
  writeln('Nacisnij ENTER, aby kontynuowac...');
  readln;
end;

procedure wypiszTabDyn(pocz:lista);
var
  tab: array of tlista;
  element,i:integer;
begin
  if pocz=nil then writeln('Nie mozesz wyswietlic tablicy, bo kolejka jest pusta!')
  else
  begin
    element:=0;
    tab:=tworzTabPosort(pocz,element);
    for i:=0 to element-1 do
    begin
      writeln('Imie: ',tab[i].imie);
      writeln('Nazwisko: ',tab[i].nazwisko);
      writeln('Wiek: ',tab[i].wiek);
      writeln('PESEL: ',tab[i].PESEL);
      writeln('---------------------');
    end;
  end;
  writeln('Nacisnij ENTER, aby kontynuowac...');
  readln;
end;

procedure usunElementPrzezImie(var pocz,kon:lista);
var
  temp,pierwszy:lista;
  imie:string;
  czyZnalazl:boolean;
begin
  if pocz<>nil then
  begin
    pierwszy:=nil;
    writeln('Podaj imie do usuniecia:');
    readln(imie);
    //gdy szukany element jest na pierwszej pozycji
    repeat
    czyZnalazl:=false;
      if (pocz^.imie=imie) then
      begin
         temp:=pocz;
        pocz:=pocz^.wsk;
        dispose(temp);
        czyZnalazl:=true;
        temp:=nil;
      end
      else pierwszy:=pocz;
    until (czyZnalazl=false) or (pocz=nil);
    pocz:=pierwszy;
    //gdy szukany element jest dalej niz na pierwszej pozycji
    while pocz<>nil do
    begin
      if pocz^.wsk<>nil then
      begin
        temp:=pocz^.wsk;
        if (temp^.imie=imie) then
        begin
          pocz^.wsk:=nil;
          if(temp^.wsk=nil) then
            dispose(temp)
          else
          begin
            pocz^.wsk:=temp^.wsk;
            dispose(temp);
            temp:=nil;
            continue;
          end;
        end;
        if pocz^.wsk=nil then kon:=pocz;
      end;
      pocz:=pocz^.wsk;
    end;
    pocz:=pierwszy;
    writeln('Usunieto z kolejki wszystkie elementy o imieniu: ',imie);
  end
  else writeln('Nie mozesz usunac nic z pustej kolejki!');
  writeln('Nacisnij ENTER, aby kontynuowac...');
  readln;
end;

function  empty(pocz,kon:lista):boolean;
begin
  if (pocz=nil) and (kon=nil) then
     empty:=true
  else
     empty:=false;
end;

procedure czysc(var pocz,kon:lista);
var
  temp:lista;
begin
  if pocz<>nil then
  begin
    repeat
    begin
      temp:=pocz;
      pocz:=pocz^.wsk;
      dispose(temp);
    end;
    until pocz=nil;
  end;
  kon:=nil;
end;

begin
  randomize;
  kon:=nil;
  pocz:=nil;
  repeat
    clrscr;
    writeln('Czy kolejka jest pusta? ',empty(pocz,kon));
    writeln('[1] Dodaj element na koniec kolejki');
    writeln('[2] Usun element z poczatku kolejki');
    writeln('[3] Wyprowadz zawartosc kolejki na ekran');
    writeln('[4] Usun wszystkie elementy kolejki');
    writeln('[5] Zapisz do pliku elementy kolejki posortowane wg nr PESEL');
    writeln('[6] Wpisz do tablicy dynamicznej elementy kolejki');
    writeln('[7] Usun wszystkie elementy kolejki o podanym imieniu');
    writeln;
    writeln('Wybierz co mam zrobic lub wpisz [0] aby wyjsc...');
    readln(numer);
    writeln('---------------------');
    case numer of
    1: dodaj(pocz,kon);
    2: usun(pocz,kon);
    3: wyswietl(pocz);
    4: usunWszystko(pocz,kon);
    5: zapiszDoPliku(pocz);
    6: wypiszTabDyn(pocz);
    7: usunElementPrzezImie(pocz,kon);
    end;
  until (numer=0);
  czysc(pocz,kon);
  writeln('Czy kolejka jest pusta przed wylaczeniem programu? ',empty(pocz,kon));
  readln;
end.



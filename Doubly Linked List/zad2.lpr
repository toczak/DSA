program zad2;
uses Crt,SysUtils;

type
  tdana = integer;
  plista_d = ^tlista_d;
  tlista_d = record
  klucz: tdana;
  nast,pop: plista_d;
  end;
  tTabDyn=array of tlista_d;

var
  numer:integer;
  pocz,kon:plista_d;
  tabDyn:tTabDyn;

procedure dodaj(var pocz,kon:plista_d);
var
  temp:plista_d;
begin
  new(temp);
  writeln('Podaj wartosc calkowita:');
  readln(temp^.klucz);
  temp^.nast:=nil;
  if pocz=nil then
  begin
     pocz:=temp;
     pocz^.pop:=nil;
  end;
  if kon=nil then temp^.pop:=nil
  else
  begin
    temp^.pop:=kon;
    kon^.nast:= temp;
  end;
  kon:=temp;
end;

procedure usun(var pocz,kon:plista_d);
var
  temp,poczatek:plista_d;
  klucz:integer;
begin
  poczatek:=nil;
  writeln('Podaj wartosc do usuniecia:');
  readln(klucz);
  if pocz<>nil then
  begin
    if(pocz^.klucz=klucz) then
    begin
       temp:=pocz;
       if pocz^.nast<>nil then
        begin
          pocz:=pocz^.nast;
          pocz^.pop:=nil;
        end
       else pocz:=nil;
       dispose(temp);
       temp:=nil;
       writeln('Usunieto element o podanej wartosci z listy.');
    end
    else
    begin
      poczatek:=pocz;
      pocz:=pocz^.nast;
      while pocz<>nil do
      begin
         if(pocz^.klucz=klucz) then
          begin
             temp:=pocz;
             if pocz^.nast<>nil then
              begin
                pocz^.pop^.nast:=pocz^.nast;
                pocz^.nast^.pop:=pocz^.pop;
              end
             else
             begin
               kon:=pocz^.pop;
               pocz^.pop^.nast:=nil;
             end;
             dispose(temp);
             temp:=nil;
             writeln('Usunieto element o podanej wartosci z listy.');
             break;
          end
         else pocz:=pocz^.nast;
      end;
      if(pocz=nil) then writeln('Brak takiej wartosci w liscie.');
      pocz:=poczatek;
    end;
  end
  else writeln('Nie mozesz nic usunac, poniewaz lista jest pusta!');
  if pocz=nil then kon:=nil;
  writeln('Nacisnij ENTER, aby kontynuowac...');
  readln;
end;

procedure usunWszystko(var pocz,kon:plista_d);
var
  temp,poczatek:plista_d;
  licznik,klucz:integer;
begin
  licznik:=0;
  poczatek:=pocz;
  if pocz=nil then writeln('Nie mozesz nic usunac, poniewaz lista jest pusta!')
  else
  begin
  writeln('Podaj wartosc do usuniecia:');
  readln(klucz);
  while pocz<>nil do
  begin
    if(pocz^.klucz=klucz) then
     begin
        if(pocz^.pop=nil) then
        begin
           temp:=pocz;
           if pocz^.nast<>nil then
            begin
              pocz:=pocz^.nast;
              pocz^.pop:=nil;
            end
           else pocz:=nil;
           dispose(temp);
           temp:=nil;
           poczatek:=pocz;
           writeln('Usunieto element o podanej wartosci z listy.');
           inc(licznik);
           continue;
        end;
        if(pocz^.pop<>nil) then
        begin
           temp:=pocz;
           if pocz^.nast<>nil then
            begin
              pocz^.pop^.nast:=pocz^.nast;
              pocz^.nast^.pop:=pocz^.pop;
            end
           else
           begin
             kon:=pocz^.pop;
             pocz^.pop^.nast:=nil;
           end;
           dispose(temp);
           temp:=nil;
           pocz:=pocz^.pop^.nast;
           writeln('Usunieto element o podanej wartosci z listy.');
           inc(licznik);
        end;
      end
      else pocz:=pocz^.nast;
  end;
  pocz:=poczatek;
  if licznik=0 then writeln('Brak takiej wartosci w liscie.');
  end;

  if pocz=nil then kon:=nil;
  writeln('Nacisnij ENTER, aby kontynuowac...');
  readln;
end;

procedure wyswietl(pocz,kon:plista_d);
begin
  if pocz=nil then writeln('Lista jest pusta.')
  else
  repeat
    begin
      writeln('Wartosc klucza: ',pocz^.klucz);
      writeln('---------------------');
      pocz:=pocz^.nast;
    end;
    until pocz=nil;
  writeln('Nacisnij ENTER, aby kontynuowac...');
  readln;

  //wypisanie od konca:
  {if kon=nil then writeln('Lista jest pusta.')
  else
  repeat
    begin
      writeln('Wartosc klucza: ',kon^.klucz);
      writeln('---------------------');
      kon:=kon^.pop;
    end;
    until kon=nil;
  writeln('Nacisnij ENTER, aby kontynuowac...');
  readln;  }
end;

function tworzSortujTabDyn(pocz:plista_d):tTabDyn;
var
   tab: tTabDyn;
   tabtemp: tlista_d;
   czyZamienil:boolean;
   i,element:integer;
begin
  if pocz=nil then writeln('Nie mozesz stworzyc i posortowac tablicy, bo lista jest pusta!')
  else
  begin
    element:=0;
    repeat
    begin
      setLength(tab,element+1);
      tab[element].klucz:=pocz^.klucz;
      pocz:=pocz^.nast;
      inc(element);
    end;
    until pocz=nil;

    repeat
    czyZamienil:=false;
        for i:=0 to element-2 do
        begin
           if tab[i].klucz>tab[i+1].klucz then
           begin
              tabtemp:=tab[i];
              tab[i]:=tab[i+1];
              tab[i+1]:=tabtemp;
              czyZamienil:=true;
           end;
        end;
    until czyZamienil=false;

    tworzSortujTabDyn:=tab;
    writeln('Gotowe!');
  end;
  writeln('---------------------');
  writeln('Nacisnij ENTER, aby kontynuowac...');
  readln;
end;

procedure wypiszTabDyn(tab:tTabDyn);
var
  i:integer;
begin
  if tab=nil then writeln('Nie mozesz wyswietlic pustej tablicy!')
  else
  begin
    for i:=0 to length(tab)-1 do
    begin
      writeln('Wartosc: ',tab[i].klucz);
      writeln('---------------------');
    end;
  end;
  writeln('Nacisnij ENTER, aby kontynuowac...');
  readln;
end;

procedure czysc(var pocz,kon:plista_d);
var
  temp:plista_d;
begin
  if pocz<>nil then
  begin
    repeat
    begin
      temp:=pocz;
      pocz:=pocz^.nast;
      dispose(temp);
    end;
    until pocz=nil;
  end;
  kon:=nil;
end;

procedure tworzListe(var pocz,kon:plista_d; tab:tTabDyn);
var
  temp:plista_d;
  i:integer;
begin
  if tab=nil then writeln('Nie mozna stworzyc nowej listy bo tablica jest pusta!')
  else
  begin
    czysc(pocz,kon);
    for i:=0 to length(tab)-1 do
    begin
      new(temp);
      temp^.klucz:=tab[i].klucz;
      temp^.nast:=nil;
      if pocz=nil then
      begin
         pocz:=temp;
         pocz^.pop:=nil;
      end;
      if kon=nil then temp^.pop:=nil
      else
      begin
        temp^.pop:=kon;
        kon^.nast:= temp;
      end;
      kon:=temp;
    end;
    writeln('Gotowe!');
  end;
  writeln('---------------------');
  writeln('Nacisnij ENTER, aby kontynuowac...');
  readln;
end;

begin
  randomize;
  pocz:=nil;
  kon:=nil;
  tabDyn:=nil;
  repeat
    clrscr;
    writeln('[1] Dodaj element do listy dwukierunkowej');
    writeln('[2] Usun z listy pierwszy element o podanej wartosci klucza');
    writeln('[3] Usun z listy wszystkie elementy o podanej wartosci klucza');
    writeln('[4] Wyprowadz zawartosc listy na ekran');
    writeln('[5] Tworz i sortuj tablice dynamiczna na podstawie listy');
    writeln('[6] Tworz nowa liste na podstawie tablicy dynamicznej');
    writeln('[7] Wyswietl utworzona wczesniej tablice dynamiczna');
    writeln;
    writeln('Wybierz co mam zrobic lub wpisz [0] aby wyjsc...');
    readln(numer);
    writeln('---------------------');
    case numer of
    1: dodaj(pocz, kon);
    2: usun(pocz,kon);
    3: usunWszystko(pocz,kon);
    4: wyswietl(pocz,kon);
    5: tabDyn:=tworzSortujTabDyn(pocz);
    6: tworzListe(pocz,kon,tabDyn);
    7: wypiszTabDyn(tabDyn);
    end;
  until (numer=0);
end.




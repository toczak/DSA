program zad1;
uses Crt,SysUtils;

type
  plista_d = ^tosoba;
  tosoba = record
    PESEL: string[11];
    imie: string[20];
    nazwisko: string[40];
    nast,pop: plista_d;
  end;
var
  numer:integer;
  pocz,kon:plista_d;

procedure dodaj(var pocz,kon:plista_d);
var
  temp,pesel:plista_d;
  czyWystapil:boolean;
begin
  new(temp);
  writeln('Podaj imie:');
  readln(temp^.imie);
  writeln('Podaj nazwisko:');
  readln(temp^.nazwisko);
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
         writeln('Taki PESEL juz jest w liscie!');
         czyWystapil:=true;
      end;
      pesel:=pesel^.nast;
      until pesel=nil;
    end
  until czyWystapil=false;

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
  nazwisko:string;
begin
  poczatek:=nil;
  writeln('Podaj nazwisko do usuniecia:');
  readln(nazwisko);
  if pocz<>nil then
  begin
    if(pocz^.nazwisko=nazwisko) then
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
       writeln('Usunieto element o podanym nazwisku z listy.');
    end
    else
    begin
      poczatek:=pocz;
      pocz:=pocz^.nast;
      while pocz<>nil do
      begin
         if(pocz^.nazwisko=nazwisko) then
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
             writeln('Usunieto element o podanym nazwisku z listy.');
             break;
          end
         else pocz:=pocz^.nast;
      end;
      if(pocz=nil) then writeln('Brak takiego nazwiska w liscie.');
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
  nazwisko:string;
  licznik:integer;
begin
  licznik:=0;
  poczatek:=pocz;
  if pocz=nil then writeln('Nie mozesz nic usunac, poniewaz lista jest pusta!')
  else
  begin
  writeln('Podaj nazwisko do usuniecia:');
  readln(nazwisko);
  while pocz<>nil do
  begin
    if(pocz^.nazwisko=nazwisko) then
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
           writeln('Usunieto element o podanym nazwisku z listy.');
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
           pocz:=pocz^.nast;
           writeln('Usunieto element o podanym nazwisku z listy.');
           inc(licznik);
        end;
      end
      else pocz:=pocz^.nast;
  end;
  pocz:=poczatek;
  if licznik=0 then writeln('Brak takiego nazwiska w liscie.');
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
      writeln('Imie: ',pocz^.imie);
      writeln('Nazwisko: ',pocz^.nazwisko);
      writeln('PESEL: ',pocz^.PESEL);
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
      writeln('Imie: ',kon^.imie);
      writeln('Nazwisko: ',kon^.nazwisko);
      writeln('PESEL: ',kon^.PESEL);
      writeln('---------------------');
      kon:=kon^.pop;
    end;
    until kon=nil;
  writeln('Nacisnij ENTER, aby kontynuowac...');
  readln;     }
end;

procedure edytuj(var pocz:plista_d);
var
  peselNumer,peselNowy:string;
  poczatek,pesel:plista_d;
  licznik:integer;
  czyWystapil:boolean;
begin
  licznik:=0;
  if(pocz=nil) then writeln('Nie mozesz edytowac pustej listy!')
  else
  begin
     poczatek:=pocz;
     writeln('Wpisz numer PESEL osoby, ktorej dane chcesz zmienic:');
     readln(peselNumer);
     while(pocz<>nil) do
     begin
        if(pocz^.PESEL=peselNumer) then
        begin
          writeln('Podaj imie:');
          readln(pocz^.imie);
          writeln('Podaj nazwisko:');
          readln(pocz^.nazwisko);
          repeat
            pesel:=poczatek;
            czyWystapil:=false;
            writeln('Podaj PESEL:');
            readln(peselNowy);
            if pocz<>nil then
            begin
              repeat
              if((pesel^.PESEL=peselNowy) and not(pocz^.PESEL=peselNowy)) then
              begin
                 writeln('Taki PESEL juz jest na liscie!');
                 czyWystapil:=true;
              end;
              pesel:=pesel^.nast;
              until pesel=nil;
            end
          until czyWystapil=false;
          pocz^.PESEL:=peselNowy;
          writeln('Pomyslnie edytowano dane.');
          inc(licznik);
          break;
        end
        else pocz:=pocz^.nast;
     end;
     if licznik=0 then writeln('Brak podanego numeru PESEL w liscie.');
  end;
  pocz:=poczatek;
  writeln('---------------------');
  writeln('Nacisnij ENTER, aby kontynuowac...');
  readln;
end;

begin
  randomize;
  pocz:=nil;
  kon:=nil;
  repeat
    clrscr;
    writeln('[1] Dodaj element do listy dwukierunkowej');
    writeln('[2] Usun z listy pierwszy element o podanym nazwisku');
    writeln('[3] Usun z listy wszystkie elementy o podanym nazwisku');
    writeln('[4] Wyprowadz zawartosc listy na ekran');
    writeln('[5] Edytuj wybrany element listy dwukierunkowej');
    writeln;
    writeln('Wybierz co mam zrobic lub wpisz [0] aby wyjsc...');
    readln(numer);
    writeln('---------------------');
    case numer of
    1: dodaj(pocz, kon);
    2: usun(pocz,kon);
    3: usunWszystko(pocz,kon);
    4: wyswietl(pocz,kon);
    5: edytuj(pocz);
    end;
  until (numer=0);
end.




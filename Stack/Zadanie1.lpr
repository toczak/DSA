program Zadanie1;
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

var
  numer:integer;
  pocz:lista;

procedure dodaj(var pocz:lista);
var
  temp:lista;
begin
    writeln('---------------------');
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
      writeln('Podaj PESEL:');
      readln(temp^.PESEL);
      if pocz=nil then
         temp^.wsk:=nil
      else
         temp^.wsk:=pocz;
      pocz:=temp;
      writeln('Dodano nowy element na stos.');
    end;
    writeln('Nacisnij ENTER, aby kontynuowac...');
    readln;
end;

procedure zdejmij(var pocz:lista);
var
  temp:lista;
begin
    if pocz<>nil then
    begin
      temp:=pocz;
      pocz:=temp^.wsk;
      dispose(temp);
      writeln('Usunieto element ze stosu.');
    end
    else writeln('Nie mozesz nic usunac, poniewaz stos jest pusty!');
    writeln('Nacisnij ENTER, aby kontynuowac...');
    readln;
end;

procedure wyswietl(pocz:lista);
var
  temp:lista;
begin
  writeln('---------------------');
  temp:=pocz;
  if temp=nil then writeln('Stos jest pusty.')
  else
     repeat
     begin
        writeln('Imie: ',temp^.imie);
        writeln('Nazwisko: ',temp^.nazwisko);
        writeln('Wiek: ',temp^.wiek);
        writeln('PESEL: ',temp^.PESEL);
        writeln('---------------------');
        temp:=temp^.wsk;
     end;
     until temp=nil;
  writeln('Nacisnij ENTER, aby kontynuowac...');
  readln;
end;

procedure zapiszDoPliku(pocz:lista);
var
  temp:lista;
  txtFile:textfile;
begin
  assignfile(txtFile, 'stos.txt');
  rewrite(txtFile);
  temp:=pocz;
  if temp=nil then writeln('Nie mozesz nic zapisac do pliku, bo stos jest pusty!')
  else
     writeln('Zapisuje...');
     repeat
     begin
        writeln(txtFile,'Imie: ',temp^.imie);
        writeln(txtFile,'Nazwisko: ',temp^.nazwisko);
        writeln(txtFile,'Wiek: ',temp^.wiek);
        writeln(txtFile,'PESEL: ',temp^.PESEL);
        writeln(txtFile,'---------------------');
        temp:=temp^.wsk;
     end;
     until temp=nil;
  writeln('Zapisano!');
  closefile(txtFile);
  writeln('Nacisnij ENTER, aby kontynuowac...');
  readln;
end;

procedure wyswietlWiek(pocz:lista);
var
  tab: array of tlista;
  tabtemp: tlista;
  czyZamienil:boolean;
  element,i:integer;
begin
  if pocz=nil then writeln('Stos jest pusty!')
  else
  begin
   element:=0;
   repeat
   begin
      setLength(tab,element+1);
      tab[element]:=pocz^;
      pocz:=pocz^.wsk;
      inc(element);
   end;
   until pocz=nil;
  end;

  repeat
  czyZamienil:=false;
      for i:=0 to element-2 do
      begin
         if tab[i].wiek>tab[i+1].wiek then
         begin
            tabtemp:=tab[i];
            tab[i]:=tab[i+1];
            tab[i+1]:=tabtemp;
            czyZamienil:=true;
         end;
      end;
  until czyZamienil=false;

  writeln('---------------------');
  for i:=0 to element-1 do
  begin
    writeln('Imie: ',tab[i].imie);
    writeln('Nazwisko: ',tab[i].nazwisko);
    writeln('Wiek: ',tab[i].wiek);
    writeln('PESEL: ',tab[i].PESEL);
    writeln('---------------------');
  end;
  writeln('Nacisnij ENTER, aby kontynuowac...');
  readln;
end;

procedure usunWszystkie(var pocz:lista);
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
end;

function empty(pocz:lista):boolean;
begin
  if (pocz=nil) then
     empty:=true
  else
     empty:=false;
end;
begin
  randomize;
  pocz:=nil;
  repeat
    clrscr;
    writeln('Czy stos jest pusty? ',empty(pocz));
    writeln('[1] Dodaj element na stos');
    writeln('[2] Zdejmij element ze stosu');
    writeln('[3] Wyprowadz zawartosc stosu na ekran');
    writeln('[4] Zapisz elementy stosu do pliku tekstowego');
    writeln('[5] Wyprowadz elementy stosu na ekran, wczesniej sortujac wg wieku');
    writeln;
    writeln('Wybierz co mam zrobic lub wpisz [0] aby wyjsc...');
    readln(numer);
    case numer of
    1: dodaj(pocz);
    2: zdejmij(pocz);
    3: wyswietl(pocz);
    4: zapiszDoPliku(pocz);
    5: wyswietlWiek(pocz);
    end;
  until (numer=0);
  usunWszystkie(pocz);
  writeln('Czy stos jest pusty przed wylaczeniem programu? ',empty(pocz));
  readln;
end.



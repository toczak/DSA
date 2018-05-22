program zad1;
uses Crt,SysUtils;

type
  lista=^tlista;
  tlista = record
    elem:integer;
    rodzic:lista;
    dlewy:lista;
    dprawy:lista;
  end;

var
  numer:integer;
  drzewo:lista;

procedure dodaj(var drzewo:lista);
var
  pom,rodzic,nowy:lista;
begin
  new(nowy);
  if(nowy=nil) then writeln('Brak miejsca w pamieci!')
  else
  begin
    rodzic:=nil;
    pom:=drzewo;
    writeln('Podaj liczbe do wstawienia:');
    readln(nowy^.elem);
    nowy^.dlewy:=nil;
    nowy^.dprawy:=nil;
    while (pom<>nil) do
    begin
      rodzic:=pom;
      if(nowy^.elem<pom^.elem) then
        pom:=pom^.dlewy
      else
        pom:=pom^.dprawy;
    end;
    nowy^.rodzic:=rodzic;
    if(rodzic=nil) then
        drzewo:=nowy
    else
    begin
      if nowy^.elem<rodzic^.elem then
        rodzic^.dlewy:=nowy
      else
        rodzic^.dprawy:=nowy;
    end;
  end;
end;

function nastepnik(drzewo:lista):lista;
var
  pom:lista;
begin
  if(drzewo^.dprawy <> nil) then
  begin
    drzewo:=drzewo^.dprawy;
    while drzewo^.dlewy <> nil do
          drzewo:=drzewo^.dlewy;
    nastepnik:=drzewo;
    exit;
  end;

  pom:=drzewo^.rodzic;
  while (pom<>nil) and (drzewo=pom^.dprawy) do
  begin
    drzewo:=pom;
    pom:=pom^.rodzic;
  end;
  nastepnik:=pom;
end;

function wyszukaj(drzewo:lista; liczba:integer):lista;
begin
  while (drzewo<>nil) and (liczba<>drzewo^.elem) do
        if liczba<drzewo^.elem then
          drzewo:=drzewo^.dlewy
        else
          drzewo:=drzewo^.dprawy;

  wyszukaj:=drzewo;
end;

procedure usun(var drzewo:lista);
var
  doUsuniecia,pom,tym:lista;
  liczba:integer;
begin
  if(drzewo=nil) then writeln('Drzewo jest puste!')
  else
  begin
    writeln('Wpisz liczbe do usuniecia:');
    readln(liczba);
    doUsuniecia:=wyszukaj(drzewo,liczba);
    if(doUsuniecia<>nil) then
    begin
      if(doUsuniecia^.dlewy=nil) or (doUsuniecia^.dprawy=nil) then
          pom:=doUsuniecia
        else
          pom:=nastepnik(doUsuniecia);

      if(pom^.dlewy <> nil) then
          tym := pom^.dlewy
      else
          tym:=pom^.dprawy;

      if(tym<>nil) then tym^.rodzic:=pom^.rodzic;

      if(pom^.rodzic=nil) then
          drzewo:=tym
      else
          if pom=pom^.rodzic^.dlewy then
              pom^.rodzic^.dlewy:= tym
          else
              pom^.rodzic^.dprawy:= tym;

      if pom<>doUsuniecia then
          doUsuniecia^.elem:=pom^.elem;

      dispose(pom);
    end
    else writeln('Brak elementu do usuniecia!');
  end;

end;

procedure postorder(drzewo:lista);
begin
  if(drzewo=nil) then exit
  else
  begin
       postorder(drzewo^.dlewy);
       postorder(drzewo^.dprawy);
       write(drzewo^.elem, ' ');
  end;
end;

procedure preorder(drzewo:lista);
begin
  if(drzewo=nil) then exit
  else
  begin
       write(drzewo^.elem, ' ');
       preorder(drzewo^.dlewy);
       preorder(drzewo^.dprawy);
  end;
end;

procedure inorder(drzewo:lista);
begin
  if(drzewo=nil) then exit
  else
  begin
       inorder(drzewo^.dlewy);
       write(drzewo^.elem, ' ');
       inorder(drzewo^.dprawy);
  end;
end;


begin
  drzewo:=nil;
  repeat
    clrscr;
    writeln('[1] Dodaj element do drzewa');
    writeln('[2] Usun element z drzewa');
    writeln('[3] Przejdz przez drzewo metoda INORDER');
    writeln('[4] Przejdz przez drzewo metoda POSTORDER');
    writeln('[5] Przejdz przez drzewo metoda PREORDER');
    writeln;
    writeln('Wybierz co mam zrobic lub wpisz [0] aby wyjsc...');
    readln(numer);
    case numer of
    1: dodaj(drzewo);
    2: usun(drzewo);
    3: if(drzewo<>nil) then inorder(drzewo) else writeln('Drzewo jest puste!');
    4: if(drzewo<>nil) then postorder(drzewo) else writeln('Drzewo jest puste!');
    5: if(drzewo<>nil) then preorder(drzewo) else writeln('Drzewo jest puste!');
    end;
    writeln;
    writeln('Nacisnij ENTER, aby kontynuowac...');
    readln;
  until (numer=0);
end.



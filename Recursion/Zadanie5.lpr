program Zadanie5;
function nwd(n,m:integer):integer;
begin
  if (n<>m) then
  begin
      if (n>m) then n:=n-m else m:=m-n;
      nwd(n,m);
  end
end;
var
  n,m:integer;
begin
  writeln('Podaj 1 liczbe:');
  readln(n);
  writeln('Podaj 2 liczbe:');
  readln(m);
  writeln('Maksymalny wspolny dzielnik: ', nwd(n,m));
  readln;
end.


program Zadanie1;
function silnia(n:integer):integer;
begin
  if((n>=0) and (n<=10)) then
  begin
    if n=0 then silnia:=1
    else silnia:=n * silnia(n-1);
  end
  else writeln('Podales zla liczbe');
end;
var
  n:integer;
begin
  writeln('Podaj n:');
  readln(n);
  writeln(silnia(n));
  readln;
end.


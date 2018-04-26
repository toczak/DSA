program Zadanie2;
procedure rysuj(n,m:integer);
begin
   if (m=0) and (n>0)  then
   begin
     writeln;
     rysuj(n-1,n-1);
   end
   else
   begin
     if (n>0) then
     begin
     write('*');
     rysuj(n,m-1);
     end;
   end;
end;

var
  n:integer;
begin
  writeln('Podaj n:');
  readln(n);
  rysuj(n,n);
  readln;
end.


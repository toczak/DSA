program Zadanie3;
function fib(n:integer):integer;
begin
  if n<=2 then fib:=1
  else
  begin
       fib:=fib(n-1)+fib(n-2);
  end;
end;

var
  n:integer;
begin
  writeln('Podaj n:');
  readln(n);
  writeln('Ciag fibonacciego wynosi: ', fib(n));
  readln;
end.


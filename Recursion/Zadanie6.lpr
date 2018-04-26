program Zadanie6;

procedure hanoi(n:integer; a,b,c:char);
begin
   if(n>0) then
   begin
     writeln('Przed ', n,' a: ',a,' b: ',b,' c: ',c);
     hanoi(n-1,a,c,b);
     writeln(a, ' -> ',c);
     writeln('Srodek ', n,' a: ',a,' b: ',b,' c: ',c);
     hanoi(n-1,b,a,c);
     writeln('Po ', n,' a: ',a,' b: ',b,' c: ',c);
   end;
end;

var
  n:integer;
begin
  writeln('Podaj n:');
  readln(n);
  hanoi(n,'A','C','B');
  readln;
end.


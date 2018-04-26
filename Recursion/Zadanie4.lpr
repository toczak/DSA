program Zadanie4;
type tabType = array[1..50] of integer;

function szukaj(tab:tabType; i,max:integer):integer;
var
  dlugosc: integer;
begin
   dlugosc:=Length(tab);
   if(i<=dlugosc) then
   begin
      if(max<tab[i]) then max:=tab[i];
     szukaj:=szukaj(tab,i+1,max);
   end
   else result:=max;

end;

var
  tab: tabType;
  i:integer;
begin
  randomize;
  for i:=1 to 50 do
      tab[i]:=random(101);
  writeln('Max: ', szukaj(tab, 1, 0));
  readln;
end.


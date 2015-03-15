program Otchet;


{$APPTYPE CONSOLE}

  uses
  SysUtils;

type mas= array of longint;
  type mflag = array of boolean;

   procedure SortInsert (n:integer;var a:mas);
  var
  i,j,x:integer;
  begin
  for I := 0 to n-1 do
    begin
      x:=a[i];
      for j:=i-1 downto 0 do begin
      if a[j]>x then
        begin
        a[j+1]:=a[j];
        a[j]:=x;
        end;
      end;
    end;
  end;


var
TP: TdateTime;
myHour, myMin, mySec, mymilli:word ;
nazv:string;
a,b:mas;
fl:mflag;
i,j,n,l,k1,k2,per:longint;
max,min:longint;
pr:longint;
f:boolean;

begin

readln(nazv);
assignfile(input,nazv);
reset(input);
nazv:='Vyvod.txt';
assignfile (output,nazv);
rewrite(output);

readln(input,n);
setlength (a,n);
setlength (b,n);
setlength (fl,n);

for I := 0 to n-1 do
fl[i]:=false;

for I := 0 to n-1 do
read (input,a[i]);

  min:=0;
  max:=0;

for i:=0 to n-1 do begin
if a[i]<a[min] then
min:=i;
if a[i]>a[max] then
max:=i;
end;

per:=a[0];
a[0]:=a[min];
a[min]:=per;

per:=a[n-1];
a[n-1]:=a[max];
a[max]:=per;

b[0]:=a[0];
fl[0]:=true;
b[n-1]:=a[n-1];
fl[n-1]:=true;



    for i:=1 to n-2 do
        begin
          k1:=0;
          k2:=0;
          pr:=round(((a[i]-a[0])*(n-1))/(a[n-1]-a[0]));
          if (fl[pr]=false) then
              begin
              b[pr]:=a[i];
              fl[pr]:=true
              end
           else
           begin
           if (pr<>0) then
           while (fl[pr-k1]=true) and (pr-k1>0) do
              k1:=k1+1;
           if (pr<>n-1) then
           while (fl[pr+k2]=true) and (pr+k2<n-1) do
              k2:=k2+1;

           if (pr+k2<>n-1) and (pr-k1<>0)then
           begin
           if k2<k1 then
              begin
              b[pr+k2]:=a[i];
              fl[pr+k2]:=true;
              end
           else
              begin
              b[pr-k1]:=a[i];
              fl[pr-k1]:=true;
              end;
           end;

           if (pr+k2=n-1) then
              begin
              b[pr-k1]:=a[i];
              fl[pr-k1]:=true;
              end;

           if (pr-k1=0) then
              begin
              b[pr+k2]:=a[i];
              fl[pr+k2]:=true;
              end;
           end;
      end;

  Tp:=Now;
SortInsert(n,b);
  Tp:=Now-Tp;
DecodeTime(Tp, myHour, myMin, mySec, myMilli);
for i:=0 to n-1 do
  write (output,b[i],' ');
  writeln(output);
writeln(output,myMin*60+mySec+mymilli/1000:0:3,'sec');
closefile (input);
closefile (output);
readln;
  end.


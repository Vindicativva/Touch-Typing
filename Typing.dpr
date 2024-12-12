program Typing;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Math;

var a:integer;

function makeWord(length :integer) :string;
var
  word :string;
begin
  case length of
    1: word:='a';
    2: word:='no';
    3: word:='a i';
    4: word:='ho d';
    5: word:='alo e';
    6: word:='aff ct';
    7: word:='aba tor';
    8: word:='add ti e';
    9: word:='aba do ed';
    10: word:='ad enal ne';
    11: word:='ai le s ess';
    12: word:='a al ena ion';
    13: word:='abdo inos opy';
    14: word:='abov ment oned';
    15: word:='abst acti en ss';
    16: word:='abse tm nd dn ss';
    17: word:='acet l ran fer se';
    18: word:='acan hoce hal asis';
    19: word:='dein u tr ali ation';
    20: word:='hete opol sa cha ide';
  end;
  result:=word;
end;

function f22(s:string; koef:integer;var  flag:boolean {slovar:slovar_type }):string;
var
  s0,word:string;
  i,j:integer;
begin
  readln(s0);
  Result:='';
  if (s0<>s) then
  begin
    if (pos('13',s0)=0) then
    begin
      i:=1;
      while (length(s)<>0) do
      begin
        if (s[1]=' ') then
        begin
          if (s0[1]<>' ') then
          begin
            for var k := 1 to koef do
            begin
              Result:=Result+s[1];
            end;
            delete(s,1,1);
            delete(s0,1,1);
          end
          else
          begin
            Result:=Result+s[1];
            delete(s,1,1);
            delete(s0,1,1);
          end;
        end
        else
        begin
          if (pos(' ',s)<>0) then word:=copy(s,1,pos(' ',s)-1)
          else word:=s;
          if (pos(word,s0)=1) then
          begin
            delete(s,1,length(word));
            delete(s0,1,length(word));
            var t:string;
            t:=MakeWord(length(word){slovar:slovar_type});
            while (t=word) and (length(t)<>1) do
            begin
              MakeWord(length(word){slovar:slovar_type});
            end;
            Result:=Result+t;
            //Result:=Result+MakeWord(length(word){slovar:slovar_type});
          end
          else
          begin
            j:=1;
            while (length(word)<>0) do
            begin
              if (s[1]=s0[1]) then
              begin
                Result:=Result+s[1];
                delete(s,1,1);
                delete(s0,1,1);
                delete(word,1,1);
              end
              else
              begin
                for var k := 1 to koef do
                begin
                  Result:=Result+s[1];
                end;
                delete(s,1,1);
                delete(s0,1,1);
                delete(word,1,1);
              end;
            end;
          end;
        end;
      end;
    end
    else flag:=false;
  end;

end;

begin
  var s,k :string;
  var flag:boolean;
  flag:=true;
  readln(s);
  k:=f22(s,2,flag);
  if flag then
  begin
    writeln (k);
  end
  else writeln('Exit');
  readln;
end.


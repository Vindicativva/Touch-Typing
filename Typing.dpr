program Typing;

uses
  {$IFDEF MSWINDOWS}
  Windows,System.SysUtils,
  Math;
  {$ENDIF}

var a:integer;

Type
  Dc = Array Of Array of String;
const
  Dicti: Dc =
  [['a','i'],
   ['at', 'to', 'in', 'on', 'by', 'he', 'we', 'it', 'an', 'be', 'do', 'up', 'no', 'so', 'go', 'is', 'me', 'my', 'if', 'of'],
   ['cat', 'dog', 'hat', 'sun', 'run', 'red', 'bed', 'bag', 'map', 'key', 'box', 'top', 'fan', 'pen', 'cup', 'car', 'leg', 'sit', 'win', 'kit'],
   ['book', 'cake', 'door', 'fish', 'game', 'hand', 'idea', 'jump', 'king', 'lamp', 'moon', 'nest', 'page', 'rain', 'star', 'tree', 'wave', 'wind', 'word', 'year'],
   ['apple', 'bread', 'chair', 'dance', 'eagle', 'flame', 'great', 'house', 'input', 'juice', 'enjoy', 'lemon', 'magic', 'night', 'ocean', 'paint', 'quiet', 'river', 'sugar', 'train'],
   ['animal', 'beauty', 'circle', 'desire', 'escape', 'friend', 'garden', 'helmet', 'island', 'jungle', 'kindly', 'little', 'moment', 'nature', 'online', 'person', 'rocket', 'single', 'travel', 'window'],
   ['already', 'balance', 'capital', 'feature', 'grammar', 'freedom', 'general', 'history', 'imagine', 'journey', 'kitchen', 'library', 'measure', 'natural', 'opinion', 'prepare', 'quality', 'respect', 'support', 'trouble'],
   ['accurate', 'behavior', 'birthday', 'category', 'decision', 'elephant', 'feedback', 'hospital', 'internet', 'location', 'material', 'notebook', 'opposite', 'possible', 'question', 'recovery', 'tomorrow', 'universe', 'vertical', 'wildlife'],
   ['attention', 'brilliant', 'confusion', 'education', 'expansion', 'generator', 'happiness', 'languages', 'marketing', 'notorious', 'operation', 'potential', 'reception', 'selection', 'technical', 'universal', 'workforce', 'telephone', 'universal'],
   ['accomplish', 'deliberate', 'endangered', 'foundation', 'generation', 'helicopter', 'impossible', 'journalism', 'literature', 'motivation', 'playground', 'revolution', 'surprising', 'blackberry', 'developing', 'expedition', 'television', 'uplifting', 'prosperous', 'management']];


const otstup='     ';

procedure ClearConsole;
var
  Handle: THandle;
  ConsoleInfo: CONSOLE_SCREEN_BUFFER_INFO;
  ConsoleSize, CharsWritten: DWORD;
  TopLeft: TCoord;
begin
  {$IFDEF MSWINDOWS}
  Handle := GetStdHandle(STD_OUTPUT_HANDLE);
  if Handle <> INVALID_HANDLE_VALUE then
  begin
    // Get console screen buffer info
    if GetConsoleScreenBufferInfo(Handle, ConsoleInfo) then
    begin
      ConsoleSize := ConsoleInfo.dwSize.X * ConsoleInfo.dwSize.Y;
      TopLeft.X := 0;
      TopLeft.Y := 0;

      // Fill the console with spaces
      FillConsoleOutputCharacter(Handle, ' ', ConsoleSize, TopLeft, CharsWritten);

      // Reset the console's attributes
      FillConsoleOutputAttribute(Handle, ConsoleInfo.wAttributes, ConsoleSize, TopLeft, CharsWritten);

      // Move the cursor to the top left
      SetConsoleCursorPosition(Handle, TopLeft);
    end;


  end;


  {$ENDIF}
end;


procedure new_round(var round_num :integer);
begin
  inc(round_num);
  ClearConsole;
  writeln(otstup,'Раунд ', round_num);
  writeln;
end;

procedure f1(const Dic: Dc; var str: string; k: integer);
var
  l: integer;
  word: string;
begin
  Randomize;
  while length(Str) < k do
  begin
    if k >= 9 then
      l := Random(9)
    else
      l := Random(k);
    word:= Dic[l][Random(length(Dic[l]))];
    if Random(5)  = 0 then
      Word[1] := chr(Ord(Word[1]) - 32);

    if ((k - length(Str) - l) <= 6) and ((k - length(Str) - (l + 1)) >= 2) then
    begin
       Str:= Str + word + ' ';
       Str:= Str + Dic[k - length(Str)-1][Random(length(Dic[k - length(Str)-1]))];
    end
    else if (k - length(str) - (l + 1)) = 0 then
      str := str + word
    else if (k - length(Str) - (l + 1)) > 6 then
       Str:= Str + word + ' ';
  end;
end;

function zamena(const dic:dc; l:integer):string;
begin
  Randomize;
  var i:=Random(length(dic[l-1]));
  Result:=dic[l-1][i];
end;

function inputt(l:integer):string;
var s:string;
begin
  readln(s);
  Result:=s;
  if (Result<>'13') then
  if (length(s)<l) then
  begin
    for var i := length(s)+1 to l do
      Result:=Result+'0';
  end
  else
  begin
    delete(Result,l+1,length(s)-l);
  end;
end;


function spaces(s:string; s0:string; var sovp_spaces:integer; var nesovp_spaces:integer; var chisl:integer; koef:integer):string;
begin
  result:='';
  for var i := 1 to length(s) do
  begin
    if (s[i]=s0[i]) then
    begin
      inc(sovp_spaces);
    end
    else
    begin
      inc(nesovp_spaces);
      for var j := 1 to koef do
        Result:=Result+' ';
    end;
  end;
  if (sovp_spaces<>0) then Result:=Result+' ';
  chisl:=chisl+max(0,length(s)-length(result));
end;

procedure deleting_spaces(var s:string; var s0:string; var sovp_spaces:integer; var nesovp_spaces:integer; var chisl:integer; koef:integer);
begin
  var i,sovp_spaces1,nesovp_spaces1:integer;
  i:=1;

  while i<length(s) do
  begin
    sovp_spaces1:=0; nesovp_spaces1:=0;
    if (s[i]=' ') then
    begin
      var j:integer;
      j:=i+1;
      while (s[j]=' ') do
        inc(j);
      var s1,s2,s3:string;
      s1:=copy(s,i,j-i);
      s2:=copy(s0,i,j-i);
      s3:=spaces(s1,s2,sovp_spaces1,nesovp_spaces1,chisl,koef);
      inc(sovp_spaces,sovp_spaces1);
      inc(nesovp_spaces,nesovp_spaces1);
      delete(s,i,j-i);
      delete(s0,i,j-i);
      insert(s3,s,i);
      insert(s3,s0,i);
      inc(i,length(s3)-1);
    end;
    inc(i);
  end;
end;

function f22(s:string; koef:integer;var  flag:boolean; dicti : dc; var l : integer):string;
var
  s0,word:string;
  i,j,p:integer;
begin
  //readln(s0);
  var sovp_spaces:integer;
  var nesovp_spaces:integer;
  sovp_spaces:=0;
  nesovp_spaces:=0;
  s0:=inputt(length(s));
  p:=length(s);
  Result:='';
  if (s0<>s) then
  begin
    if (s0<>'13') then
    begin
      i:=1;
      var chisl:integer;
      chisl:=0;
      deleting_spaces(s, s0, sovp_spaces,nesovp_spaces,chisl, koef);
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
            if (length(word)>10) then
            begin
              f1(dicti,t,length(word));
              while (t=word) do
              begin
                f1(dicti,t,length(word));
              end;
            end
            else
            begin
              t:=zamena(dicti,length(word));
              while (t=word) do
              begin
                t:=zamena(dicti,length(word));
              end;
              if (Random(5)=0) then
                Word[1] := chr(Ord(Word[1]) - 32);
            end;
            Result:=Result+t;
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
    l:=max(p,length(Result));
  end;
end;


begin
  var s,k :string;
  var flag:boolean;
  var koef,num_round,l:integer;
  l:=20;
  write(otstup,'Вас приветсвует тренажер слепой печати. Нажмите любую кнопку для продолжения');
  readln;
  num_round:=0;
  new_round(num_round);
  koef:=num_round*2;
  flag:=true;
  f1(dicti,s,l);
  writeln(otstup,s);
  while flag do
  begin
    write(otstup);
    s:=f22(s,num_round*2,flag,dicti,l);
    writeln;
    if flag then
    if (s='') then
    begin
      dec(l,2);
      l:=max(0,l);
      if l=0 then
      begin
        new_round(num_round);
        l:=20;
      end;
      f1(dicti,s,l);
      writeln (otstup,s);
    end
    else
    begin
      if (length(s)<156) then
      begin
       writeln(otstup,S);
      end
      else
      begin
        dec(num_round);
        write(otstup,'Попробуйте заново. Нажмите любую кнопку для продолжения');
        readln;
        new_round(num_round);
        l:=20;
        s:='';
        f1(dicti,s,l);
        writeln(otstup,s);
      end;
    end;
  end;
  writeln(otstup,'Игра закончена');
  var sovp_spaces:integer; var nesovp_spaces:integer;
  {readln(s);
  readln(k);
  var chisl:integer;
  chisl:=0;
  deleting_spaces(s,k,koef,num_round,chisl,2);
  writeln(s);
  writeln(chisl);}
  //writeln('+',spaces(s,k,sovp_spaces,nesovp_spaces,2),'+ ',' ',sovp_spaces,' ',nesovp_spaces,' ',length(spaces(s,k,sovp_spaces,nesovp_spaces,2)));
  readln;
end.
//длина строки консоли - 156
{ghgh       ghgj   jf g g
ghgh d d d ghgj d jf gdg}


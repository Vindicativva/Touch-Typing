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
  [['a'],
   ['at', 'to', 'in', 'on', 'by', 'he', 'we', 'it', 'an', 'be', 'do', 'up', 'no', 'so', 'go', 'is', 'me', 'my', 'if', 'of'],
   ['cat', 'dog', 'hat', 'sun', 'run', 'red', 'bed', 'bag', 'map', 'key', 'box', 'top', 'fan', 'pen', 'cup', 'car', 'leg', 'sit', 'win', 'kit'],
   ['book', 'cake', 'door', 'fish', 'game', 'hand', 'idea', 'jump', 'king', 'lamp', 'moon', 'nest', 'page', 'rain', 'star', 'tree', 'wave', 'wind', 'word', 'year'],
   ['apple', 'bread', 'chair', 'dance', 'eagle', 'flame', 'great', 'house', 'input', 'juice', 'enjoy', 'lemon', 'magic', 'night', 'ocean', 'paint', 'quiet', 'river', 'sugar', 'train'],
   ['animal', 'beauty', 'circle', 'desire', 'escape', 'friend', 'garden', 'helmet', 'island', 'jungle', 'kindly', 'little', 'moment', 'nature', 'online', 'person', 'rocket', 'single', 'travel', 'window'],
   ['already', 'balance', 'capital', 'feature', 'grammar', 'freedom', 'general', 'history', 'imagine', 'journey', 'kitchen', 'library', 'measure', 'natural', 'opinion', 'prepare', 'quality', 'respect', 'support', 'trouble'],
   ['accurate', 'behavior', 'birthday', 'category', 'decision', 'elephant', 'feedback', 'hospital', 'internet', 'location', 'material', 'notebook', 'opposite', 'possible', 'question', 'recovery', 'tomorrow', 'universe', 'vertical', 'wildlife'],
   ['attention', 'brilliant', 'confusion', 'education', 'expansion', 'generator', 'happiness', 'languages', 'marketing', 'notorious', 'operation', 'potential', 'reception', 'selection', 'technical', 'universal', 'workforce', 'telephone', 'universal'],
   ['accomplish', 'deliberate', 'endangered', 'foundation', 'generation', 'helicopter', 'impossible', 'journalism', 'literature', 'motivation', 'playground', 'revolution', 'surprising', 'blackberry', 'developing', 'expedition', 'television', 'uplifting', 'prosperous', 'management']];


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
  writeln('Раунд ', round_num);
end;

procedure f1(const Dic: Dc; var str: string; k: integer);
var
  l: integer;
  word: string;
begin
  Str:= '';
  Randomize;
  while length(Str) < k do
  begin
    if k >= 9 then
      l := Random(10)
    else
      l := Random(k);
    word:= Dic[l][Random(length(Dic[l]))];
    if ((k - length(Str) - (l + 1)) <= 6) and ((k - length(Str) - (l + 1)) >= 2) then
    begin
       Str:= Str + word + ' ';
       Str:= Str + Dic[k - length(Str)-1][Random(length(Dic[k - length(Str)-1]))];
    end
    else if (k - length(Str) - (l + 1)) = 0 then
      Str:= Str + word
    else if (k - length(Str) - (l + 1)) > 6 then
       Str:= Str + word + ' ';
  end;
end;

function zamena(const dic:dc; l:integer):string;
begin
  Randomize;
  var i:=Random(length(dic[l-1])-1);
  Result:=dic[l-1][i];
end;

function inputt(l:integer):string;
var s:string;
begin
  readln(s);
  Result:=s;
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



function f22(s:string; koef:integer;var  flag:boolean; dicti : dc; var l : integer):string;
var
  s0,word:string;
  i,j:integer;
begin
  //readln(s0);
  s0:=inputt(length(s));
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
            if (length(word)>10) then
            begin
              f1(dicti,t,length(word));
              while (t=word) and (length(t)<>1) do
              begin
                f1(dicti,t,length(word));
              end;
            end
            else
            begin
              t:=zamena(dicti,length(word));
              while (t=word) and (length(t)<>1) do
              begin
                t:=zamena(dicti,length(word));
              end;
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
    l:=length(Result);
  end;

end;

begin
  var s,k :string;
  var flag:boolean;
  var koef,num_round,l:integer;
  l:=20;
  num_round:=0;
  new_round(num_round);
  koef:=num_round*2;
  flag:=true;
  f1(dicti,s,l);
  writeln(s);
  while flag do
  begin
    s:=f22(s,num_round*2,flag,dicti,l);
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
      writeln (s);
    end
    else writeln(s);
  end;
  writeln('Игра закончена');
  readln;
end.

program Typing;

uses
  {$IFDEF MSWINDOWS}
  Windows,
  System.SysUtils,
  Math;

{$ENDIF}

(*
FunctionFunction - Функция
variable_variable - Переменная

Variables
paragraph - Отступ с левой стороны консоли
number_of_round - Номер раунда

Functions
GetWordFromFile - Функция, которая возвращает слово, требуемой длины
ReplaceWord - Функция замены слова на другое слово такой жк длины
  length_of_word - Длина заменяемого слова


Main - Обработка главных функций программы

Procedures


f1 -


*)

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

const Paragraph = '     '; //отступ перед выводом на экран

// процедура ClearConsole - Очистка консоли
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

// процедура NewRound - Обновление раунда
// number_of_round - Номер текущего раунда
procedure NewRound(var number_of_round: integer);
begin
  inc(number_of_round);
  ClearConsole;
  writeln(Paragraph,'Раунд ', number_of_round);
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

function ReplaceWord(const dic:dc; length_of_word:integer):string;
var i: integer;
begin
  Randomize;
  i := Random(length(dic[length_of_word-1]));
  Result := dic[length_of_word-1][i];
end;

// функция UpdateInput - Функция возвращающая введённую строку измененную под нужную длину
//  length_of_string - Длина исходной строки
function UpdateInput (length_of_string: integer): string;
var user_string: string; //  user_string - Строка пользователя
begin
  readln(user_string);
  Result := user_string;
  if (Result <> '13') then
  if (length(user_string) < length_of_string) then
  begin
    for var i := length(user_string) + 1 to length_of_string do
      Result := Result + '0';
  end
  else
  begin
    delete(Result,length_of_string+1,length(user_string)-length_of_string);
  end;
end;

//ControlSpaces - Функция, которая возвращает измененный пробельный кусок в соответствии с вводом пользователя
//  part_of_s - пробельный кусок строки которую надо ввести
//  part_of_user_string - кусок который ввел пользователь как соответствующий пробельный кусок
//  coef - Коеффициент
function ControlSpaces(part_of_s:string; part_of_user_string:string; coef:integer):string;
var  
  i, j:integer; 
  matching_spaces: boolean; //станет истиной если хотя бы один пробел совпадает 
begin
  matching_spaces := false;
  Result := '';
  for i := 1 to length(part_of_s) do
  begin
    if (part_of_s[i]=part_of_user_string[i]) then
    begin
      matching_spaces := true;
    end
    else
    begin
      for j := 1 to coef do
        Result := Result + ' ';
    end;
  end;
  if (matching_spaces) then Result:=Result+' ';
end;

// процедура DeleteSpaces - Обработать всю строку на пробелы
//  s - Строка, которую надо ввести пользователю
//  user_string - Строка, которую ввёл пользователь
procedure DeleteSpaces(var s:string; var user_string:string; coef:integer);
var 
  i, j: integer;
  modified_spaces:string; //измененные в строках пробелы
begin
  i := 1;
  while i < length(s) do
  begin
    if (s[i] = ' ') then
    begin
      j := i+1;
      while (s[j] = ' ') do
        inc(j);
      modified_spaces := ControlSpaces(copy(s,i,j-i), copy(user_string,i,j-i), coef);
      delete(s,i,j-i);
      delete(user_string,i,j-i);
      insert(modified_spaces,s,i);
      insert(modified_spaces,user_string,i);
      inc(i,length(modified_spaces)-1);
    end;
    inc(i);
  end;
end;

function Main(s:string; coef:integer;var  flag:boolean; dicti : dc; var l : integer):string;
var
  s0,word:string;
  i,j,p:integer;
begin
  //readln(s0);
  s0:=UpdateInput(length(s));
  p:=length(s);
  Result:='';
  if (s0<>s) then
  begin
    if (s0<>'13') then
    begin
      i:=1;
      DeleteSpaces(s, s0, coef);
      while (length(s)<>0) do
      begin
        if (s[1]=' ') then
        begin
          if (s0[1]<>' ') then
          begin
            for var k := 1 to coef do
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
              t:=ReplaceWord(dicti,length(word));
              while (t=word) do
              begin
                t:=ReplaceWord(dicti,length(word));
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
                for var k := 1 to coef do
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
  var coef,number_of_round,l:integer;
  l:=20;
  write(Paragraph,'Вас приветсвует тренажер слепой печати. Нажмите любую кнопку для продолжения');
  readln;
  number_of_round:=0;
  NewRound(number_of_round);
  coef:=number_of_round*2;
  flag:=true;
  f1(dicti,s,l);
  writeln(Paragraph,s);
  while flag do
  begin
    write(Paragraph);
    s:=Main(s,number_of_round*2,flag,dicti,l);
    writeln;
    if flag then
    if (s='') then
    begin
      dec(l,2);
      l:=max(0,l);
      if l=0 then
      begin
        NewRound(number_of_round);
        l:=20;
      end;
      f1(dicti,s,l);
      writeln (Paragraph,s);
    end
    else
    begin
      if (length(s)<156) then
      begin
       writeln(Paragraph,S);
      end
      else
      begin
        dec(number_of_round);
        write(Paragraph,'Попробуйте заново. Нажмите любую кнопку для продолжения');
        readln;
        NewRound(number_of_round);
        l:=20;
        s:='';
        f1(dicti,s,l);
        writeln(Paragraph,s);
      end;
    end;
  end;
  writeln(Paragraph,'Игра закончена');
  readln;
end.
//длина строки консоли - 156
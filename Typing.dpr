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

var
  n, a: integer;
  lang: string;

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


function GetWordFromFile(FileName: string; Number: integer): String;
  var
    WordFile: TextFile;
    s: String;
    arr: TArray<String>;
  begin
    AssignFile(WordFile, FileName);
    Reset(WordFile);
    ReadLn(WordFile, s);
    Randomize;
    arr := s.Split([' ']);
    CloseFile(WordFile);
    Result := arr[random(Length(arr))];
  end;

procedure f1(var str: string; k: integer);
var
  l, f: integer;
  word, lang: string;
begin
  Str:= '';
  Randomize;
  lang := 'Rus';
  f := Random(2);
  while length(str) < k do
  begin
    if k >= 9 then
      l := Random(10) + 1
    else
      l := Random(k) + 1;
    word := GetWordFromFile('..\..\' + lang + '\' + lang + IntToStr(l) +'.txt', n);{Dic[f][l][Random(length(Dic[f][l]))]}
    if Random(5) = 0 then
      word[1] := chr(Ord(word[1]) - 32);

    if ((k - length(str) - (l + 1)) <= 6) and ((k - length(str) - (l + 1)) >= 2) then
    begin
      str := str + word + ' ';
      str := str + GetWordFromFile('..\..\' + lang + '\' + lang + IntToStr(k - length(str)) +'.txt', n){Dic[f][k - length(str) - 1][Random(length(Dic[f][k - length(str) - 1]))]};
    end
    else if (k - length(str) - l) = 0 then
      str := str + word
    else if (k - length(str) - (l + 1)) > 6 then
      str := str + word + ' ';
  end;
end;

{function zamena(l:integer):string;
begin
  Randomize;
  var i:=Random(length(dic[l-1]));
  Result:=dic[l-1][i];
end;}

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

//основная функция Main - вернет новую строку для ввода или пустую в случае полностью корректного ввода
// s - строка, которую надо ввести пользователю
// coef - коэффициент
// flag - становится ложью, когда пользователь предпочет завершить игру
// l - длина строки для генерации в случае полностью корректного ввода
function Main(s:string; coef: integer; var  flag: boolean; var l: integer): string;
var
  s0,word, lang:string;
  i,j,p:integer;
begin
  //readln(s0);
  lang:= 'Rus';
  s0:=UpdateInput(length(s));
  p:=length(s);
  Result:='';
  if (s0<>s) then
  begin
    if (s0<>'13') then
    begin
      i:=1;
      var chisl:integer;
      chisl:=0;
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
              f1(t,length(word));
              while (t=word) do
              begin
                f1(t,length(word));
              end;
            end
            else
            begin
              t:=GetWordFromFile('..\..\' + lang + '\' + lang + IntToStr(length(word)) +'.txt', n){zamena(dicti,length(word))};
              while (t=word) do
              begin
                t:=GetWordFromFile('..\..\' + lang + '\' + lang + IntToStr(length(word)) +'.txt', n){zamena(length(word))};
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
  setconsolecp(1251);
  SetConsoleOutputCP(1251);
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
  f1(s,l);
  writeln(Paragraph,s);
  while flag do
  begin
    write(Paragraph);
    s:=Main(s,number_of_round*2,flag,l);
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
      f1(s,l);
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
        f1(s,l);
        writeln(Paragraph,s);
      end;
    end;
  end;
  writeln(Paragraph,'Игра закончена');
  var sovp_spaces:integer; var nesovp_spaces:integer;
  {readln(s);
  readln(k);
  var chisl:integer;
  chisl:=0;
  deleting_spaces(s,k,coef,number_of_round,chisl,2);
  writeln(s);
  writeln(chisl);}
  //writeln('+',spaces(s,k,sovp_spaces,nesovp_spaces,2),'+ ',' ',sovp_spaces,' ',nesovp_spaces,' ',length(spaces(s,k,sovp_spaces,nesovp_spaces,2)));
  readln;
end.
//длина строки консоли - 156
{ghgh       ghgj   jf g g
ghgh d d d ghgj d jf gdg}

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

const Paragraph = '     '; //отступ перед выводом на экран

Main - Обработка главных функций программы

Procedures


f1 -


*)
const Eng = 'Eng';
const Rus = 'Rus';
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

procedure OutputPamPamPam(const paragraph: string; s: string; d: integer; d1: integer; d2: integer; k: integer);
var
  i:integer;
begin
  write(Paragraph);
  for i := 1 to length(s) do
  begin
    case s[i] of
      '!','.','?':
      begin
        write(s[i]);
        sleep(d1);
      end;
      ',':
      begin
        write(s[i]);
        sleep(d2);
      end
      else
      begin
        write(s[i]);
        sleep(d);
      end;
    end;
    if (i mod k = 0) and (i <> length(s)) then
    begin
      writeln;
      write(Paragraph);
    end;
  end;
end;

function Rules(const Paragraph: string): byte;
var a:byte;
begin
  try
    readln(a);
    if (a<>0) and (a<>1) then a := a div (a-a);
  except
    writeln;
    OutputPamPamPam(paragraph,'Некорректный ввод. Повторите попытку ввода: ', 50, 50, 50, 100);
    a := Rules(Paragraph);
  end;
  Result:=a;
end;

procedure Begining(const Paragraph: string; var lang: string);
var
  cursor: TCoord;
  r: cardinal;
const d = 100;
const d1 = 500;
const d2 = 200;
const k = 100;
begin
  cursor.x:=0;
  cursor.y:=3;
  SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
  OutputPamPamPam(Paragraph, 'Просим перед началом включить полноэкранный режим', 30, 500, 200, 100);
  sleep(100);
  cursor.y:=5;
  SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
  sleep(100);
  OutputPamPamPam(Paragraph, 'Загрузка', 0, 500, 200, 100);
  sleep(30);
  OutputPamPamPam('', '...', 30, 500, 200, 100);
  cursor.x:=13;
  cursor.y:=5;
  FillConsoleOutputCharacter(GetStdHandle(STD_OUTPUT_HANDLE), ' ', 3, cursor, r);
  SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
  sleep(30);
  OutputPamPamPam('', '...', 30, 500, 200, 100);
  FillConsoleOutputCharacter(GetStdHandle(STD_OUTPUT_HANDLE), ' ', 3, cursor, r);
  SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
  sleep(30);
  OutputPamPamPam('', '...', 30, 500, 200, 100);
  ClearConsole;
  cursor.x:=0;
  cursor.y:=4;
  SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
  OutputPamPamPam(Paragraph+'   ','Вас приветсвует тренажер слепой печати "Придумать название".', d, 500, 300, 100);
  inc(cursor.y,2);
  SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
  OutputPamPamPam(Paragraph, 'Введите 1, если хотите ознакомится с правилами. Введите 0, в противном случае: ', d, 500, 200, 100);
  if (Rules(Paragraph) = 1) then
  begin
    ClearConsole;
    cursor.x:=0;
    cursor.y:=1;
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
    OutputPamPamPam(Paragraph, 'Правила тренажера:', 70, 200, 150, 130);
    inc(cursor.y,2);
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
    OutputPamPamPam(Paragraph, '1.', 100, 500, 200, 100);
    writeln;
    OutputPamPamPam(Paragraph + '  ', 'Если правильно ввести строку, то новая строка уменьшиться на 2', 70, 500, 150, 130);
    inc(cursor.y,2);
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
    OutputPamPamPam(Paragraph, '2.', 100, 500, 200, 100);
    writeln;
    OutputPamPamPam(Paragraph + '  ', 'Уровень заканчивается, когда новая строка становится нулевой', 70, 500, 150, 130);
    inc(cursor.y,2);
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
    OutputPamPamPam(Paragraph, '3.', 100, 500, 200, 100);
    writeln;
    OutputPamPamPam(Paragraph + '  ', 'Каждый уровень сложнее предыдущего. Каждый неправильно введенный символ увеличивается в 2*(номер раунда) раз', 70, 150, 150, 130);
    inc(cursor.y,2);
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
    OutputPamPamPam(Paragraph, '4.', 100, 500, 200, 100);
    writeln;
    OutputPamPamPam(Paragraph + '  ', 'В случае частично верного написания строки каждое правильно введенное слово заменяется', 70, 150, 150, 130);
    inc(cursor.y,2);
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
    OutputPamPamPam(Paragraph, '5.', 100, 500, 200, 100);
    writeln;
    OutputPamPamPam(Paragraph + '  ', 'Если из-за ошибок строка станет слишком длинной, то уровень придется начать с начала', 70, 150, 150, 130);
    inc(cursor.y,2);
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
    OutputPamPamPam(Paragraph, '6.', 100, 500, 200, 100);
    writeln;
    OutputPamPamPam(Paragraph + '  ', 'Введите ''13'', чтобы закончить тренировку', 70, 150, 150, 130);
    inc(cursor.y,2);
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
    writeln;
    OutputPamPamPam(Paragraph, 'Нажмите enter, чтобы продолжить', 50, 500, 100, 100);
    readln;
  end;
  ClearConsole;
  cursor.y:=3;
  SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
  OutputPamPamPam(Paragraph, 'Вам нужно выбрать язык для тренировки.', 50, 500, 100, 100);
  inc(cursor.y,2);
  SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
  OutputPamPamPam(Paragraph, 'Введите 1, если хотите начать тренировку на английском. Введите 0, если на русском: ', 80, 250, 100, 130);
  if (Rules(Paragraph) = 1) then lang:='Eng'
  else lang:='Rus';
end;

var
  n, a: integer;
  lang: string;
  language:string;





// процедура NewRound - Обновление раунда
// number_of_round - Номер текущего раунда
procedure NewRound(var number_of_round: integer);
begin
  inc(number_of_round);
  ClearConsole;
  writeln;
  OutputPamPamPam(Paragraph,'Раунд ', 100, 0, 0, 100);
  write(number_of_round);
  writeln;
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

procedure f1(var str: string; k: integer; lang: string);
var
  l, f: integer;
  word: string;
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
function Main(s:string; coef: integer; var  flag: boolean; var l: integer; lang: string): string;
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
              f1(t,length(word), lang);
              while (t=word) do
              begin
                f1(t,length(word), lang);
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
  Begining(Paragraph, lang);
  //lang:='Rus';
  number_of_round:=0;
  NewRound(number_of_round);
  coef:=number_of_round*2;
  flag:=true;
  f1(s,l, lang);
  OutputPamPamPam(Paragraph,s,10, 0, 0, 1000);
  writeln;
  while flag do
  begin
    write(Paragraph);
    s:=Main(s,number_of_round*2,flag,l, lang);
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
      f1(s,l, lang);
      OutputPamPamPam(Paragraph,s,10, 0, 0, 1000);
      writeln;
    end
    else
    begin
      if (length(s)<156) then
      begin
        OutputPamPamPam(Paragraph,s,10, 0, 0, 1000);
        writeln;
      end
      else
      begin
        dec(number_of_round);
        OutputPamPamPam(Paragraph,'Вы допустили слишком много ошибок. Нажмите enter для продолжения',50, 100, 0, 1000);
        readln;
        NewRound(number_of_round);
        l:=20;
        s:='';
        f1(s,l, lang);
        OutputPamPamPam(Paragraph,s,10, 0, 0, 1000);
        writeln;
      end;
    end;
  end;
  OutputPamPamPam(Paragraph,'Тренировка закончена',70,0,0,100);
  readln;
end.
//длина строки консоли - 156
{ghgh       ghgj   jf g g
ghgh d d d ghgj d jf gdg}

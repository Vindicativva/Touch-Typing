﻿program Typing;

{$APPTYPE CONSOLE}


uses
  {$IFDEF MSWINDOWS}
  Windows,
  System.SysUtils,
  Classes,
  Math;

{$ENDIF}

const Paragraph = '     '; //отступ перед выводом на экран

procedure DisableResize;
var
  ConsoleWindow: HWND;
  Style: LongInt;
  screenWidth, screenHeight: Integer;
begin
  ConsoleWindow := GetConsoleWindow;
  Style := GetWindowLong(ConsoleWindow, GWL_STYLE);
  Style := Style and not WS_THICKFRAME;
  SetWindowLong(ConsoleWindow, GWL_STYLE, Style);
  if ConsoleWindow = 0 then
    Exit;
  // Получаем размеры экрана
  screenWidth := GetSystemMetrics(SM_CXSCREEN);
  screenHeight := GetSystemMetrics(SM_CYSCREEN);
  // Устанавливаем размеры окна консоли так, чтобы оно занимало весь экран
  SetWindowPos(ConsoleWindow, HWND_TOP, 0, 0, screenWidth, screenHeight, SWP_NOZORDER or SWP_FRAMECHANGED);
  // Обновляем стиль окна, чтобы сохранить кнопки управления (закрыть, свернуть, развернуть)
  SetWindowLong(ConsoleWindow, GWL_STYLE, GetWindowLong(ConsoleWindow, GWL_STYLE) or WS_OVERLAPPEDWINDOW);
  ShowWindow(ConsoleWindow, SW_SHOWMAXIMIZED);
end;


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

// процедура OutputPamPamPam - позволяет выводить строку с задержкой
// string_to_output - строка для вывода
// delay_after_usual_letter - задержка после обычного сивола
// delay_after_special_symbol - задержка после символа конца предложения
// delay_after_comma - задержка после запятой
// max_length_of_string - количество после которого вывод начнется с новой строки
procedure OutputPamPamPam(const paragraph: string; string_to_output: string; delay_after_usual_letter: integer;
delay_after_special_symbol: integer; delay_after_comma: integer; max_length_of_string: integer);
var
  i:integer;
begin
  write(Paragraph);
  for i := 1 to length(string_to_output) do
  begin
    case string_to_output[i] of
      '!','.','?':
      begin
        write(string_to_output[i]);
        sleep(delay_after_special_symbol);
      end;
      ',':
      begin
        write(string_to_output[i]);
        sleep(delay_after_comma);
      end
      else
      begin
        write(string_to_output[i]);
        sleep(delay_after_usual_letter);
      end;
    end;
    if (i mod max_length_of_string = 0) and (i <> length(string_to_output)) then
    begin
      writeln;
      write(Paragraph);
    end;
  end;
end;

// функция Rules - предназначена для двоичного выбора, позволяет ввести только 1 и 0, возвращает соответвенно
function Rules(const Paragraph: string): byte;
var decision_of_user: byte; // переменная решения пользователя
begin
  try
    readln(decision_of_user);
    if (decision_of_user <> 0) and (decision_of_user <> 1) then decision_of_user := decision_of_user div (decision_of_user-decision_of_user);
  except
    writeln;
    OutputPamPamPam(paragraph,'Некорректный ввод. Повторите попытку ввода: ', 50, 50, 50, 100);
    decision_of_user := Rules(Paragraph);
  end;
  Result := decision_of_user;
end;

// процедура Begining - процедура выводящая начальный текст
// language - переменная в которой хранится язык тренировки
procedure Begining(const Paragraph: string; var language: string);
var
  cursor: TCoord;
  r: cardinal;
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
  OutputPamPamPam(Paragraph+'   ','ОПИ - СОСАТЬ !', 150, 500, 500, 100);
  {inc(cursor.y,2);
  SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
  OutputPamPamPam(Paragraph, 'Введите 1, если хотите ознакомится с правилами. Введите 0, в противном случае: ', 40, 500, 200, 100);
  if (Rules(Paragraph) = 1) then
  begin
    ClearConsole;
    cursor.x:=0;
    cursor.y:=1;
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
    OutputPamPamPam(Paragraph, 'Правила тренажера:', 50, 200, 150, 130);
    inc(cursor.y,2);
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
    OutputPamPamPam(Paragraph, '1.', 100, 500, 200, 100);
    writeln;
    OutputPamPamPam(Paragraph + '  ', 'Если правильно ввести строку, то новая строка уменьшиться на 2', 40, 500, 150, 130);
    inc(cursor.y,2);
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
    OutputPamPamPam(Paragraph, '2.', 100, 500, 200, 100);
    writeln;
    OutputPamPamPam(Paragraph + '  ', 'Уровень заканчивается, когда новая строка становится нулевой', 40, 500, 150, 130);
    inc(cursor.y,2);
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
    OutputPamPamPam(Paragraph, '3.', 100, 500, 200, 100);
    writeln;
    OutputPamPamPam(Paragraph + '  ', 'Каждый уровень сложнее предыдущего. Каждый неправильно введенный символ увеличивается в 2*(номер раунда) раз', 40, 150, 150, 130);
    inc(cursor.y,2);
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
    OutputPamPamPam(Paragraph, '4.', 100, 500, 200, 100);
    writeln;
    OutputPamPamPam(Paragraph + '  ', 'В случае частично верного написания строки каждое правильно введенное слово заменяется', 40, 150, 150, 130);
    inc(cursor.y,2);
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
    OutputPamPamPam(Paragraph, '5.', 100, 500, 200, 100);
    writeln;
    OutputPamPamPam(Paragraph + '  ', 'Если из-за ошибок строка станет слишком длинной, то уровень придется начать с начала', 50, 150, 150, 130);
    inc(cursor.y,2);
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),cursor);
    OutputPamPamPam(Paragraph, '6.', 100, 500, 200, 100);
    writeln;
    OutputPamPamPam(Paragraph + '  ', 'Введите ''13'', чтобы закончить тренировку', 50, 150, 150, 130);
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
  OutputPamPamPam(Paragraph, 'Введите 1, если хотите начать тренировку на английском. Введите 0, если на русском: ', 40, 100, 100, 130);
  if (Rules(Paragraph) = 1) then language:='Eng'
  else language:='Rus';           }
end;

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

// функция GetWordFromFile - возвращает случайно выбранное слово заданной длины
// FileName - имя файла, из которого будет браться слово
// Number - длина слова, которое нужно извлечь
{function GetWordFromFile(const Language: string; Number: integer): String;
  var
    WordFile: TextFile;
    n: integer;
    s1, Text: String;
    ResStream: TResourceStream;
    StringStream: TStringStream;
  begin
    ResStream := TResourceStream.Create(HInstance, Language + IntToStr(Number), RT_RCDATA);
    StringStream := TStringStream.Create;
    StringStream.CopyFrom(ResStream, ResStream.Size);
    Text := StringStream.DataString;
    {AssignFile(WordFile, FileName);
    Reset(WordFile);
    ReadLn(WordFile, s);
    Randomize;
    n := random((Length(Text)+1) div (Number+1));
    {for i := 1 to Number do
      s1 := s1 + s[n*(Number+1)+i];
    CloseFile(WordFile);
    s1 := Copy(Text, (n*(Number+1)+1), Number);
    Result := s1;
  end;}


// функция CreatingRandomString - создает случайно сгенерированную строку заданной длины
// StringToGenerate - строка, которую надо сгенерировать
// StrLength - длина строки для генерации
// Language - строка, указывающая на словарь из которого нужно брать слова
{procedure CreatingRandomString(var StringToGenerate: string; StrLength: integer; const Language: string);
var
  WordLength: integer; // Случайная длина слова
  word: string; // Слово случайной длины
begin
  StringToGenerate:= '';
  Randomize;
  while length(StringToGenerate) < StrLength do
  begin
    if StrLength - length(StringToGenerate) >= 10 then WordLength := Random(10) + 1 // Подбор длины слова в зависимости от незаполненной длины
    else WordLength := Random(StrLength - length(StringToGenerate)) + 1;
    word := GetWordFromFile(Language, WordLength);
    if Random(5) = 0 then word[1] := chr(Ord(word[1]) - 32);  // В 20% случаев слово будет начинаться с заглавной буквы
    if ((StrLength - length(StringToGenerate) - (WordLength + 1)) <= 6) and ((StrLength - length(StringToGenerate) - (WordLength + 1)) >= 2) then
    begin
      StringToGenerate := StringToGenerate + word + ' ';
      StringToGenerate := StringToGenerate + GetWordFromFile(Language, StrLength - length(StringToGenerate));
    end
    else if (StrLength - length(StringToGenerate) - WordLength) = 0 then StringToGenerate := StringToGenerate + word
         else if (StrLength - length(StringToGenerate) - (WordLength + 1)) > 6 then StringToGenerate := StringToGenerate + word + ' ';
  end;
end;}


// функция UpdateInput - Функция возвращающая введённую строку измененную под нужную длину
//  length_of_string - Длина исходной строки
function UpdateInput (length_of_string: integer): string;
var
  user_string: string; //  user_string - Строка пользователя
  i: integer;
begin
  readln(user_string);
  Result := user_string;
  if (Result <> '13') then
    if (length(user_string) < length_of_string) then for i := length(user_string) + 1 to length_of_string do Result := Result + '0'
    else delete(Result,length_of_string+1,length(user_string)-length_of_string);
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
    if (part_of_s[i]=part_of_user_string[i]) then matching_spaces := true
    else for j := 1 to coef do Result := Result + ' ';
  if (matching_spaces) then Result:=Result+' ';
end;

//основная функция Main - вернет новую строку для ввода или пустую в случае полностью корректного ввода
// s - строка, которую надо ввести пользователю
// coef - коэффициент
// flag - становится ложью, когда пользователь предпочет завершить игру
// length_of_generate - длина строки для генерации (равна 0 в случае полностью корректного ввода)
// language - язык тренировки
{function Main(s:string; coef: integer; var  flag: boolean; var length_of_generate: integer; language: string): string;
var user_string: string; // строка, которую вводит пользователь
begin
  user_string := UpdateInput(length(s));
  Result := '';
  if (user_string <> s) then
  begin
    if (user_string <> '13') then
    begin
      while (length(s)<>0) do
      begin
        if (s[1]=' ') then
        begin
          var j: integer;
          j := 2;
          while (s[j] = ' ') do inc(j);
          var modified_spaces: string; // строка содержащая измененные пробелы
          modified_spaces := ControlSpaces(copy(s, 1, j - 1), copy(user_string, 1, j - 1), coef);
          Result := Result + modified_spaces;
          delete(s, 1, j-1);
          delete(user_string, 1, j-1);
        end
        else
        begin
          var word: string; // слово для сравнения
          if (pos(' ', s) <> 0) then word := copy(s, 1, pos(' ', s) - 1)
          else word := s;
          if (pos(word, user_string) = 1) then
          begin
            delete(s, 1, length(word));
            delete(user_string, 1, length(word));
            var word_to_replace: string; // слово, которое заменится на другое
            if (length(word) > 10) then
            begin
              CreatingRandomString(word_to_replace, length(word), language);
              while (word_to_replace = word) do CreatingRandomString(word_to_replace, length(word), language);
            end
            else
            begin
              word_to_replace := GetWordFromFile(language, length(word));
              while (word_to_replace = word) do word_to_replace := GetWordFromFile(language, length(word));
              if (Random(5) = 0) then Word[1] := chr(Ord(Word[1]) - 32);
            end;
            Result := Result + word_to_replace;
          end
          else
          begin
            while (length(word) <> 0) do
            begin
              if (s[1] = user_string[1]) then
              begin
                Result := Result + s[1];
                delete(s, 1, 1);
                delete(user_string, 1, 1);
                delete(word, 1, 1);
              end
              else
              begin
                for var k := 1 to coef do Result := Result + s[1];
                delete(s, 1, 1);
                delete(user_string, 1, 1);
                delete(word, 1, 1);
              end;
            end;
          end;
        end;
      end;
    end
    else flag := false;
    length_of_generate := length(Result);
  end;
end;}


begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  DisableResize;
  var s :string; // строка предлагаемая пользователю для ввода
  var flag: boolean; // переменная состояния, ложно когда надо закончить тренировку
  var number_of_round: integer; // номер раунда
  var length_of_generate:integer; // длина строки для генерации
  var language: string; // язык тренировки
  length_of_generate:=20;
   Begining(Paragraph, language); // Если хотите все начало скипнуть то коментить эту строку и раскоментить один из языков
 { //language := 'Rus';
  //language := 'Eng';
  number_of_round:=0;
  NewRound(number_of_round);
  flag:=true;
  CreatingRandomString(s, length_of_generate, language);
  OutputPamPamPam(Paragraph,s,10, 0, 0, 1000);
  writeln;
  while flag do
  begin
    write(Paragraph);
    s:=Main(s,number_of_round*2,flag,length_of_generate, language);
    writeln;
    if flag then
      if ( s= '') then
      begin
        dec(length_of_generate, 2);
        length_of_generate := max(0, length_of_generate);
        if length_of_generate = 0 then
        begin
          NewRound(number_of_round);
          length_of_generate := 20;
        end;
        CreatingRandomString(s, length_of_generate, language);
        OutputPamPamPam(Paragraph, s, 10, 0, 0, 1000);
        writeln;
      end
      else
      begin
        if (length(s) < 156) then
        begin
          OutputPamPamPam(Paragraph, s, 10, 0, 0, 1000);
          writeln;
        end
        else
        begin
          dec(number_of_round);
          OutputPamPamPam(Paragraph, 'Вы допустили слишком много ошибок. Нажмите enter для продолжения', 50, 100, 0, 1000);
          readln;
          NewRound(number_of_round);
          length_of_generate := 20;
          s := '';
          CreatingRandomString(s, length_of_generate, language);
          OutputPamPamPam(Paragraph, s, 10, 0, 0, 1000);
          writeln;
        end;
      end;
  end;
  OutputPamPamPam(Paragraph, 'Тренировка закончена', 70, 0, 0, 100); }
  readln;
end.

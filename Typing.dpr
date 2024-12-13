program Typing;

uses
  Windows,
  SysUtils;

var
  n: integer;
  lang: string;

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

begin
  lang := 'Rus';
  n := 10;
  Writeln(GetWordFromFile('..\..\' + lang + '\' + lang + IntToStr(n) +'.txt', n));

  Writeln;
  Writeln('Введите Enter для выхода...');
  Readln;
end.

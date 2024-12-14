program Typing;

uses
  Windows,
  SysUtils;

var
  n: integer;
  lang, s: string;

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

    if ((k - length(str) - l) <= 6) and ((k - length(str) - (l + 1)) >= 2) then
    begin
      str := str + word + ' ';
      str := str + GetWordFromFile('..\..\' + lang + '\' + lang + IntToStr(k - length(str)) +'.txt', n){Dic[f][k - length(str) - 1][Random(length(Dic[f][k - length(str) - 1]))]};
    end
    else if (k - length(str) - (l)) = 0 then
      str := str + word
    else if (k - length(str) - (l + 1)) > 6 then
      str := str + word + ' ';
  end;
end;

begin
  lang := 'Rus';
  readln(n);
  //Writeln(GetWordFromFile('..\..\' + lang + '\' + lang + IntToStr(n) +'.txt', n));
  f1(s, n);
  Writeln;
  Writeln(s);
  Writeln;
  Writeln('Введите Enter для выхода...');
  Readln;
end.

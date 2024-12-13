program Typing;

uses
  System.SysUtils;

Type
  Dc = Array Of Array Of Array of String;

const
  Dicti: Dc = [[['a', 'i'], ['at', 'to', 'in', 'on', 'by', 'he', 'we', 'it',
    'an', 'be', 'do', 'up', 'no', 'so', 'go', 'is', 'me', 'my', 'if', 'of'],
    ['cat', 'dog', 'hat', 'sun', 'run', 'red', 'bed', 'bag', 'map', 'key',
    'box', 'top', 'fan', 'pen', 'cup', 'car', 'leg', 'sit', 'win', 'kit'],
    ['book', 'cake', 'door', 'fish', 'game', 'hand', 'idea', 'jump', 'king',
    'lamp', 'moon', 'nest', 'page', 'rain', 'star', 'tree', 'wave', 'wind',
    'word', 'year'], ['apple', 'bread', 'chair', 'dance', 'eagle', 'flame',
    'great', 'house', 'input', 'juice', 'enjoy', 'lemon', 'magic', 'night',
    'ocean', 'paint', 'quiet', 'river', 'sugar', 'train'], ['animal', 'beauty',
    'circle', 'desire', 'escape', 'friend', 'garden', 'helmet', 'island',
    'jungle', 'kindly', 'little', 'moment', 'nature', 'online', 'person',
    'rocket', 'single', 'travel', 'window'], ['already', 'balance', 'capital',
    'feature', 'grammar', 'freedom', 'general', 'history', 'imagine', 'journey',
    'kitchen', 'library', 'measure', 'natural', 'opinion', 'prepare', 'quality',
    'respect', 'support', 'trouble'], ['accurate', 'behavior', 'birthday',
    'category', 'decision', 'elephant', 'feedback', 'hospital', 'internet',
    'location', 'material', 'notebook', 'opposite', 'possible', 'question',
    'recovery', 'tomorrow', 'universe', 'vertical', 'wildlife'],
    ['attention', 'brilliant', 'confusion', 'education', 'expansion',
    'generator', 'happiness', 'languages', 'marketing', 'notorious',
    'operation', 'potential', 'reception', 'selection', 'technical',
    'universal', 'workforce', 'telephone', 'universal'],
    ['accomplish', 'deliberate', 'endangered', 'foundation', 'generation',
    'helicopter', 'impossible', 'journalism', 'literature', 'motivation',
    'playground', 'revolution', 'surprising', 'blackberry', 'developing',
    'expedition', 'television', 'uplifting', 'prosperous', 'management']],
    [['я', 'и', 'с'], ['да', 'по', 'не'], ['дом', 'лес', 'сад'],
    ['лето', 'вода', 'тень'], ['огонь', 'вагон', 'осень'], ['листья', 'облако',
    'костёр'], ['природа', 'прудики', 'зеркало'], ['ожерелья', 'ледников',
    'тропинка'], ['гроиадный', 'зачарован', 'мировозар'],
    ['абсолютизм', 'абстракция', 'авиасервис']]];

var
  s: String;
  l: integer;

procedure f1(const Dic: Dc; var str: string; k: integer);
var
  l, f: integer;
  word: string;
begin
  Randomize;
  f := Random(2);
  while length(str) < k do
  begin
    if k >= 9 then
      l := Random(9)
    else
      l := Random(k);
    word := Dic[f][l][Random(length(Dic[f][l]))];
    if Random(5) = 0 then
      word[1] := chr(Ord(word[1]) - 32);

    if ((k - length(str) - l) <= 6) and ((k - length(str) - (l + 1)) >= 2) then
    begin
      str := str + word + ' ';
      str := str + Dic[f][k - length(str) - 1]
        [Random(length(Dic[f][k - length(str) - 1]))];
    end
    else if (k - length(str) - (l + 1)) = 0 then
      str := str + word
    else if (k - length(str) - (l + 1)) > 6 then
      str := str + word + ' ';
  end;
end;

begin
  l := 2;
  f1(Dicti, s, l);
  writeln(s);
  readln;

end.

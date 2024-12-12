program Typing;

uses
  System.SysUtils;

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

var
  Str: string;
  k: integer;

procedure f1(const Dic: Dc; var str: string; k: integer);
var
  l: integer;
  word: string;
begin
  Randomize;
  while length(Str) < k do
  begin
    l := Random(10);
    word:= Dic[l-1][Random(length(Dic[l-1]))];
    if ((k - length(Str) - l) <= 6) and ((k - length(Str) - (l + 1)) >= 2) then
    begin
       Str:= Str + word + ' ';
       Str:= Str + Dic[k - length(Str)-1][Random(length(Dic[k - length(Str)-1]))];
    end
    else if (k - length(Str) - (l + 1)) > 6 then
       Str:= Str + word + ' ';
  end;
  writeln(str);

end;


begin
K := 20;
f1(Dicti, Str, k);

readln;



end.

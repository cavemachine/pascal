program project1;

{
var
  i: integer;

begin

  i := 1600;

  while (i < 2100) do
  begin
    if (i mod 4 = 0) then
    begin
      if (i mod 400 = 0) and (i mod 100 = 0) then
        writeln('bis centenario: ', i)
      else
        writeln('bisx..', i);
    end;

    i := i + 1;
  end;

end.

// Mostra anos bis.
}
{
var
  msg: string;
  j: integer;

begin

  j := 1;
  readln(msg);
  writeln('frase: ', msg);
  WriteLn('prim letra:', msg[1]);
  Writeln('tamanho: ', Length(msg));
  {while j <= Length(msg) do
  begin
    writeln('.. ', msg[j]);
    j := j + 1;
  end;
  }
  for j := Length(msg) downto 1 do
  begin
    write(msg[j]);
  end;
end.

}
{
var
  num: integer;
  msg: string;

begin
  msg := '';
  readln(num);
  if (num mod 3 = 0) then
    msg := Concat('..pling', msg);
  if (num mod 5 = 0) then
    msg := Concat('..plang', msg);
  if (num mod 7 = 0) then
    msg := Concat('..plung', msg);

  if (msg = '') then
    writeln('vazio')
  else
    writeln(msg);

end.
}
{
var
  msg: string;
  c: char;
  pangram: boolean;

begin
  pangram := True;
  readln(msg);

  for c := 'a' to 'z' do
  begin
    if (Pos(c, msg) = 0) and (Pos(UpCase(c), msg) = 0) then
      pangram := False;
  end;

  writeln(pangram);

end.
// checa se é um pangram (contem todas as letras na frase);
}
type
  DNA_Nucleos = record
    c: integer;
    a: integer;
    g: integer;
    t: integer;
  end;

var
  dna_total: DNA_Nucleos;
  dna_len, i, j, dif: integer;
  dna1, dna2, hamm: string;

begin
  Randomize;

  Initialize(dna1);
  Initialize(dna2);
  Initialize(hamm);
  Initialize(dna_total);

  dif := 0;

  readln(dna_len);
  for i := 1 to dna_len do
  begin
    j := random(4);
    Write(j);
    case j of
      0: dna1 := concat(dna1, 'C');
      1: dna1 := Concat(dna1, 'A');
      2: dna1 := Concat(dna1, 'G');
      3: dna1 := Concat(dna1, 'T');
    end;
  end;
  for i := 1 to dna_len do
  begin
    j := random(4);
    Write(j);
    case j of
      0: dna2 := concat(dna2, 'C');
      1: dna2 := Concat(dna2, 'A');
      2: dna2 := Concat(dna2, 'G');
      3: dna2 := Concat(dna2, 'T');
    end;
  end;

  for i := 1 to dna_len do
  begin
    if (dna1[i] = dna2[i]) then
      hamm := concat(hamm, ' ')
    else
    begin
      hamm := concat(hamm, '^');
      dif := dif + 1;
    end;
  end;

  writeln;
  writeln(dna1);
  writeln(dna2);
  writeln(hamm);
  writeln('diferencas: ', dif);

  for i := 1 to dna_len do
    case dna1[i] of
      'C': dna_total.c := dna_total.c + 1;
      'A': dna_total.a := dna_total.a + 1;
      'G': dna_total.g := dna_total.g + 1;
      'T': dna_total.t := dna_total.t + 1;
    end;
  writeln('a: ', dna_total.a);
  writeln('c: ', dna_total.c);
  writeln('g: ', dna_total.g);
  writeln('t: ', dna_total.t);

end.

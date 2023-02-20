unit teste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, system.Math, Vcl.Grids, Vcl.ComCtrls, Vcl.ExtCtrls;

type

  TMatriz = array of array of Integer;
  TVisited = array of array of Boolean;

  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Button1: TButton;
    Button4: TButton;
    StringGrid2: TStringGrid;
    StringGrid1: TStringGrid;
    Button2: TButton;
    Memo1: TMemo;
    Button3: TButton;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    procedure sumNotConnected;
    function findGratestSum(const numeros: array of Integer): Integer;

    procedure getMatrizExemplo(Matriz: TMatriz; iMatriz: integer);
    procedure LimparStringGrid(StringGrid: TStringGrid);
    procedure limparMatrizVisitada(Matriz: TVisited);
    procedure gerarMatriz;
    procedure LimparGrids;
    procedure pintarDiferencas;
    procedure restaurarCoresDefault;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.SysUtils;

{$R *.dfm}

{ TForm1 }


function TForm1.findGratestSum(const numeros: array of Integer): Integer;
var
  previuosSum, actualSum, previous, actual, i: Integer;
begin
  previuosSum := 0;
  actualSum := 0;

  for i := Low(numeros) to High(numeros) do
  begin
    previous := actualSum;
    actual := Max(actualSum, previuosSum + numeros[i]);
    previuosSum := previous;
    actualSum := actual;
  end;

  Result := actualSum;
end;

procedure TForm1.LimparGrids;
begin
  LimparStringGrid(StringGrid1);
  LimparStringGrid(StringGrid2);
  restaurarCoresDefault;
end;

procedure TForm1.limparMatrizVisitada(Matriz: TVisited);
var
  i: Integer;
  j: Integer;
begin
  for i := 0 to Length(Matriz)-1 do
    for j := 0 to Length(Matriz)-1 do
      Matriz[i][j] := False;
end;

procedure TForm1.gerarMatriz;
var
  inputMatriz, outputMatriz: Tmatriz;
  matrizVisitada: TVisited;

  numRows, numCols: Integer;
  n: Integer;

  function isConnectedToBorder(l,c: integer): boolean;
  begin
    Result := False;
    if (l < 1) or (c < 1) or (l >= Length(outputMatriz)-1) or (c >= Length(outputMatriz[0])-1) then
      exit(True);
  end;

  function isBorder(l,c: integer): boolean;
  begin
    Result := False;
    if (l=0) or (l=Length(outputMatriz)-1) or
       (c=0) or (c=Length(outputMatriz[0])-1) then
      Exit(True);
  end;

  function hasConnectionAdjacent(l, c: integer): boolean;
  begin
   if (matrizVisitada[l][c]) then
      Exit(False);

    matrizVisitada[l][c] := True;


    if (outputMatriz[l][c-1] = 1) then
      if isBorder(l,c-1) or hasConnectionAdjacent(l,c-1) then
        Exit(True);

    if (outputMatriz[l][c+1] = 1) then
      if isBorder(l,c+1) or hasConnectionAdjacent(l,c+1) then
        Exit(True);

    if (outputMatriz[l-1][c] = 1) then
      if isBorder(l-1,c) or hasConnectionAdjacent(l-1,c) then
        Exit(True);

    if (outputMatriz[l+1][c] = 1) then
      if isBorder(l+1,c) or hasConnectionAdjacent(l+1,c) then
        Exit(True);

    Result := False;
  end;

  function canChange(l, c: integer): Boolean;
  begin
    Result := True;

    limparMatrizVisitada(matrizVisitada);

    if hasConnectionAdjacent(l,c) then
      Exit(False);
  end;

  procedure atualizarMatriz(outputMatriz: TMatriz);
  var
    l, c: integer;
  begin
    //o for percorre a matriz ignorando a primeira e ultima linha e primeira e ultima coluna pois sao as bordas
    for l := 1 to numRows-2 do
    begin
      for c := 1 to numCols-2 do
      begin
        if (outputMatriz[l][c] = 1) then
        begin
          if (canChange(l,c)) then
            outputMatriz[l][c] := 0;
        end;
      end;
    end;
  end;

  procedure MostrarMatriz(Matriz: TMatriz; Grid: TStringGrid);
  var
    i,j: Integer;
  begin
    //mostra a matriz de resultado no segundo grid
    for i := 0 to numRows - 1 do
    begin
      for j := 0 to numCols - 1 do
        Grid.Cells[j, i] := IntToStr(Matriz[i][j]);
    end;
  end;

begin
  LimparGrids;
  n := 6; // tamanho da matriz
  numRows := 6;
  numCols := 6;
  SetLength(inputMatriz, n, n);
  SetLength(outputMatriz, n, n);
  SetLength(matrizVisitada, n, n);

  // preenchendo a matriz de exemplo
  getMatrizExemplo(inputMatriz, RadioGroup1.ItemIndex);
  //monta a matriz de resultado igual a origem pra poder modificar depois
  getMatrizExemplo(outputMatriz, RadioGroup1.ItemIndex);
  MostrarMatriz(inputMatriz, StringGrid1);

  atualizarMatriz(outputMatriz);
  MostrarMatriz(outputMatriz, StringGrid2);
  pintarDiferencas;
end;

procedure TForm1.getMatrizExemplo(Matriz: TMatriz; iMatriz: integer);
begin
  case iMatriz of
    0:
    begin
      Matriz[0] := [1, 0, 0, 0, 0, 0];
      Matriz[1] := [0, 1, 0, 1, 1, 1];
      Matriz[2] := [0, 0, 1, 0, 1, 0];
      Matriz[3] := [1, 1, 0, 0, 1, 0];
      Matriz[4] := [1, 0, 1, 1, 0, 0];
      Matriz[5] := [1, 0, 0, 0, 0, 1];
    end;
    1:
    begin
      Matriz[0] := [0, 1, 1, 1, 1, 0];
      Matriz[1] := [0, 1, 0, 1, 0, 1];
      Matriz[2] := [1, 0, 1, 0, 1, 0];
      Matriz[3] := [0, 1, 0, 0, 1, 0];
      Matriz[4] := [0, 0, 1, 1, 0, 0];
      Matriz[5] := [1, 1, 1, 0, 0, 0];
    end;
    2:
    begin
      Matriz[0] := [0, 0, 0, 0, 0, 0];
      Matriz[1] := [0, 0, 1, 0, 0, 0];
      Matriz[2] := [0, 0, 1, 0, 1, 1];
      Matriz[3] := [1, 1, 0, 1, 0, 0];
      Matriz[4] := [0, 0, 0, 1, 1, 0];
      Matriz[5] := [0, 0, 0, 1, 0, 0];
    end;
  end;
end;

procedure TForm1.LimparStringGrid(StringGrid: TStringGrid);
var
  i: Integer;
  j: Integer;
begin
  for i := 0 to StringGrid.ColCount - 1 do
  begin
    for j := 0 to StringGrid.RowCount -1 do
      StringGrid.Cells[i,j] := '';
  end;
end;

procedure TForm1.pintarDiferencas;
var
  i, j: Integer;
begin
  for i := 0 to 5 do
  begin
    for j := 0 to 5 do
    begin
      if StringGrid1.Cells[j, i] <> StringGrid2.Cells[j, i] then
      begin
        StringGrid2.Canvas.Brush.Color := clRed;
        StringGrid2.Canvas.Font.Color := clBlack;
        StringGrid2.Canvas.FillRect(StringGrid2.CellRect(j, i));
        StringGrid2.Canvas.TextOut(StringGrid2.CellRect(j, i).Left + 2, StringGrid2.CellRect(j, i).Top + 2,
                                    StringGrid2.Cells[j, i]);
      end
      else
      begin
        StringGrid2.Canvas.Brush.Color := clWhite;
        StringGrid2.CAnvas.Font.Color := clBlack;
        StringGrid2.Canvas.FillRect(StringGrid2.CellRect(j, i));
        StringGrid2.Canvas.TextOut(StringGrid2.CellRect(j, i).Left + 2, StringGrid2.CellRect(j, i).Top + 2,
                                    StringGrid2.Cells[j, i]);
      end;
    end;
  end;
end;

procedure TForm1.restaurarCoresDefault;
var
  i: Integer;
  j: Integer;
begin
  for i := 0 to 5 do
  begin
    for j := 0 to 5 do
    begin
      StringGrid2.Canvas.Brush.Color := clWhite;
      StringGrid2.CAnvas.Font.Color := clBlack;
      StringGrid2.Canvas.FillRect(StringGrid2.CellRect(j, i));
      StringGrid2.Canvas.TextOut(StringGrid2.CellRect(j, i).Left + 2, StringGrid2.CellRect(j, i).Top + 2,
                                  StringGrid2.Cells[j, i]);
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  gerarMatriz;
end;


procedure TForm1.Button2Click(Sender: TObject);
begin
  sumNotConnected;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  LimparGrids;
end;

procedure TForm1.sumNotConnected;
var
  numbers: array of Integer;
  result: Integer;
  i, n: Integer;
begin
  n := 0;
  //garante que vai criar um array de no minimo 3 posições,
  //deixei um ramdom de 10 pra ficar mais facil de avaliar o resultado
  while n < 3 do
    n := Random(10);

  // inicializa o array de números
  SetLength(numbers, n);

  //adiciona no array numeros aleatorios positivos entre 0 e 50
  for i := 0 to n-1 do
    numbers[i] := Random(50);

  //adiciona ao memo o array inicial
  Memo1.Lines.Add('Array inicial:');
  for i := 0 to n-1 do
    Memo1.Lines.Add(IntToStr(numbers[i]));
  Memo1.Lines.Add('');

  // chama a função para encontrar a maior soma possível de números que não se encontram
  result := findGratestSum(numbers);

  // exibe o resultado em no final do memo
  Memo1.Lines.Add('Maior soma entre valores não conectados: ' + IntToStr(result));
end;


end.

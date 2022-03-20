Program cube1p;

{---- cube using vanishing point calculation ----}
{--- line to make new test commit ---}

uses Graph, Crt;
const
     SCREEN_WIDTH = 640;
     SCREEN_HEIGHT = 480;
type
    tPoint = record
    x, y : Integer;
    end;

    tCube = record
    fUpLeft, fUpRight, fDownLeft, fDownRight,
    bUpLeft, bUpRight, bDownLeft, bDownRight : tPoint;
    CubeWidth, CubeHeight, CubeDepth: Integer;
    end;

    tRetaEQ = record
    a, b : Real;
    end;
var
   Gm, Gd, xHoz, yHoz, xVan, yVan : Integer;
   CubeAtLeft : Boolean;
   Cube : tCube;
   RetaUpLeft, RetaUpRight, RetaDownLeft, RetaDownRight : tRetaEQ;
   S : String;

Procedure setCube(fUpLeftX, fUpLeftY, cubeWidth, cubeHeight: Integer; var Cube_ : tCube);
begin
     Cube_.fUpLeft.x := fUpLeftX;
     Cube_.fUpLeft.y := fUpLeftY;
     Cube_.fUpRight.x :=  Cube_.fUpLeft.x + cubeWidth;
     Cube_.fUpRight.y :=  Cube_.fUpLeft.y;
     Cube_.fDownLeft.x := Cube_.fUpLeft.x;
     Cube_.fDownLeft.y := Cube_.fUpLeft.y + cubeHeight;
     Cube_.fDownRight.x := Cube_.fUpRight.x;
     Cube_.fDownRight.y := Cube_.fUpRight.y + cubeHeight;
end;

Procedure setEQ(x1, y1, x2, y2 : Integer; var reta: tRetaEQ);
var
   a, b: Real;
begin
     a := (y2 - y1) / (x2 - x1);
     b := y1 - a*x1;
     reta.a := a;
     reta.b := b;
end;

function getXfromReta(y : Real; reta_ : tRetaEQ) : Integer;
var
   x: Real;
begin
     x := (y - reta_.b) / reta_.a;
     getXfromReta := Round(x);
end;

function getYfromReta(x : Real; reta_ : tRetaEQ) : Integer;
var
   y: Real;
begin
     y := (reta_.a*x) + reta_.b;
     getYfromReta := Round(y);
end;

procedure setCubeBack;
begin
     if (Cube.fUpLeft.x < xVan) then
        CubeAtLeft := True
        else
        CubeAtLeft := False;

     if (xVan - (Cube.fUpLeft.x + Cube.CubeDepth)) < Cube.CubeDepth then
     Cube.CubeDepth := (xVan - (Cube.fUpLeft.x + Cube.CubeDepth)) div 2;

     if CubeAtLeft = True then
     begin
          Cube.bUpLeft.x := Cube.fUpLeft.x + Cube.CubeDepth;
          Cube.bUpLeft.y := getYfromReta(Cube.bUpLeft.x, RetaUpLeft);
     end
     else
     begin
          Cube.bUpLeft.x := Cube.fUpLeft.x - Cube.CubeDepth;
          Cube.bUpLeft.y := getYfromReta(Cube.bUpLeft.x, RetaUpLeft);
     end;

     Cube.bUpRight.y := Cube.bUpLeft.y;
     Cube.bUpRight.x := getXfromReta(Cube.bUpRight.y, RetaUpRight);

     Cube.bDownRight.x := Cube.bUpRight.x;
     Cube.bDownRight.y := getYfromReta(Cube.bDownRight.x, RetaDownRight);

     Cube.bDownLeft.y := Cube.bDownRight.y;
     Cube.bDownLeft.x := getXfromReta(Cube.bDownLeft.y, RetaDownLeft);

     PutPixel(Round(Cube.bUpLeft.x), round(Cube.bUpLeft.y), 2);
     PutPixel(Round(Cube.bUpRight.x), round(Cube.bUpRight.y), 2);
     PutPixel(Round(Cube.bDownRight.x), round(Cube.bDownRight.y), 2);
     PutPixel(Round(Cube.bDownLeft.x), round(Cube.bDownLeft.y), 2);

     Line(Cube.bUpLeft.x, Cube.bUpLeft.y, Cube.bUpRight.x, Cube.bUpRight.y);
     Line(Cube.bUpRight.x, Cube.bUpRight.y, Cube.bDownRight.x, Cube.bDownRight.y);
     Line(Cube.bDownRight.x, Cube.bDownRight.y, Cube.bDownLeft.x, Cube.bDownLeft.y);
     Line(Cube.bUpLeft.x, Cube.bUpLeft.y, Cube.bDownLeft.x, Cube.bDownLeft.y);

     Line(Cube.bUpLeft.x, Cube.bUpLeft.y, Cube.fUpLeft.x, Cube.fUpLeft.y);
     Line(Cube.bUpRight.x, Cube.bUpRight.y, Cube.fUpRight.x, Cube.fUpRight.y);

     Line(Cube.bDownRight.x, Cube.bDownRight.y, Cube.fDownRight.x, Cube.fDownRight.y);
     Line(Cube.bDownLeft.x, Cube.bDownLeft.y, Cube.fDownLeft.x, Cube.fDownLeft.y);

end;

function ScreenToCartesian(x , y : Integer) : Real;
begin

end;


begin
     Gm := Detect;
     InitGraph(Gm, Gd, ' ');
     OutTextXY(500, 30, 'OK');

     SetColor(2);
     xHoz := SCREEN_WIDTH div 2;
     yHoz := SCREEN_HEIGHT div 2;
     xVan := xHoz;
     yVan := yHoz;

     setCube(250 , 50, 150, 150, Cube);
     Cube.CubeDepth := 60;
     setEQ(xVan, yVan, Cube.fUpLeft.x, Cube.fUpLeft.y, RetaUpLeft);
     setEQ(xVan, yVan, Cube.fUpRight.x, Cube.fUpRight.y, RetaUpRight);
     setEQ(xVan, yVan, Cube.fDownLeft.x, Cube.fDownLeft.y, RetaDownLeft);
     setEQ(xVan, yVan, Cube.fDownRight.x, Cube.fDownRight.y, RetaDownRight);

     setCubeBack;

     Str(RetaUpLeft.a:4:4, S);
     OutTextXY(500, 60, 'a: '+S);
     setLineStyle(0,0,3);
     Rectangle(Cube.fUpLeft.x, Cube.fUpLeft.y, Cube.fDownRight.x, Cube.fDownRight.y);
     Line(0, yHoz, SCREEN_WIDTH, yHoz);
     PutPixel(xHoz, yHoz, 10);

     Readkey;
end.

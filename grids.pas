Program Grids;

{---- draws a grid using 2 points perspective ----}

uses Crt, Graph;

const
     SCREEN_WIDTH = 640;
     SCREEN_HEIGHT = 480;
     COLS = 20;

type
    tReta = record
    a, b : Real;
    end;

    tInter = record
    x, y : Integer;
    end;

var
   C : Char;
   I, J, CenterVar : Integer;
   xVanL, xVanR, yVan: Integer;
   xSubHozL, xSubHozR, ySubHoz, xSubHozLSize, xSubHozRSize, xSubHozLStep, xSubHozRStep: Integer;
   xVert, yVertLow, yVertHi: Integer;
   RetaVanLeftFront, RetaVanLeftBack, RetaVanRightFront, RetaVanRightBack, tmpReta : tReta;
   InterLeft, InterRight, InterFront, InterTmpBack, InterTmpFront: tInter;

{----------------------------------------------}

Procedure StartGraph;
var
   Gd, Gm: Integer;
begin
     Gd := Detect;
     InitGraph(Gd, Gm, ' ');
     OutTextXY(100,100,'OK');
end;

{----------------------------------------------}

Procedure setRetaAB(x1, y1, x2, y2: Integer; var Reta : tReta);
var
   a, b : Real;
begin
     a := (y2 - y1) / (x2 - x1);
     b := y1 - a*x1;
     Reta.a := a;
     Reta.b := b;
end;

{----------------------------------------------}

Function getRetaX(y: Integer; Reta: tReta) : Integer;
var
   x : Real;
begin
     x := (y - Reta.b) / Reta.a;
     getRetaX := Round(x);
end;

{----------------------------------------------}

Function getRetaY(x: Integer; Reta: tReta) : Integer;
var
   y : Real;
begin
     y := (Reta.a*x) + Reta.b;
     getRetaY := Round(y);
end;

{----------------------------------------------}

Procedure setInter(Reta1, Reta2: tReta; var Inter: tInter);
var
   x, y : Real;
begin
     x := (Reta1.b - Reta2.b) / (Reta2.a - Reta1.a);
     y := (Reta1.a*x) + Reta1.b;
     Inter.x := Round(x);
     Inter.y := Round(y);
end;

{----------------------------------------------}

Procedure DrawFloor;
var
   J : Integer;
begin

     { Draw outside lines }

     setRetaAB(xVanL, yVan, xSubHozL, ySubHoz, RetaVanLeftFront);
     setRetaAB(xVanL, yVan, CenterVar, yVertLow, RetaVanLeftBack);
     setRetaAB(xVanR, yVan, xSubHozR, ySubHoz, RetaVanRightFront);
     setRetaAB(xVanR, yVan, CenterVar, yVertLow, RetaVanRightBack);
     setInter(RetaVanLeftFront, RetaVanRightBack, InterLeft);
     setInter(RetaVanLeftFront, RetaVanRightFront, InterFront);
     setInter(RetaVanLeftBack, RetaVanRightFront, InterRight);
     Line(InterLeft.x, InterLeft.y, xVert, yVertLow);
     Line(InterLeft.x, InterLeft.y, InterFront.x, InterFront.y);
     Line(InterRight.x, InterRight.y, xVert, yVertLow);
     Line(InterRight.x, InterRight.y, InterFront.x, InterFront.y);

     { Draw inside lines }

     for J := 1 to COLS do
     begin
          setRetaAB(xVanR, yVan, xSubHozR - (xSubHozRStep*J), ySubHoz, tmpReta);
          setInter(tmpReta, RetaVanLeftBack, InterTmpBack);
          setInter(tmpReta, RetaVanLeftFront, InterTmpFront);
          Line(InterTmpBack.x, InterTmpBack.y, InterTmpFront.x, InterTmpFront.y);
     end;
     for J := 1 to COLS do
     begin
          setRetaAB(xVanL, yVan, xSubHozL + (xSubHozLStep*J), ySubHoz, tmpReta);
          setInter(tmpReta, RetaVanRightBack, InterTmpBack);
          setInter(tmpReta, RetaVanRightFront, InterTmpFront);
          Line(InterTmpBack.x, InterTmpBack.y, InterTmpFront.x, InterTmpFront.y);
     end;
end;

{---------------------------------------------}

Procedure ConfigAll;
begin

     if CenterVar = 0 then CenterVar := SCREEN_WIDTH div 2;
     xVanL := -20;
     xVanR := SCREEN_WIDTH + 20;
     yVan := 90;
     xSubHozL := 40;
     xSubHozR := SCREEN_WIDTH - 40;
     ySubHoz := 150;
     xSubHozLSize := CenterVar - xSubHozL;
     xSubHozRSize := xSubHozR - CenterVar;
     xSubHozLStep := xSubHozLSize div COLS;
     xSubHozRStep := xSubHozRSize div COLS;
     xVert := CenterVar;
     yVertLow := ySubHoz;
     yVertHi := 50;

end;

{--------------------MAIN----------------------}

Begin
     StartGraph;
     ConfigAll;
     DrawFloor;

     setColor(2);
     PutPixel(xVanL, yVan, 2);
     PutPixel(xVanR, yVan, 2);
     PutPixel(xSubHozL, ySubHoz, 2);
     PutPixel(xSubHozR, ySubHoz, 2);
     PutPixel(xVert, yVertLow, 2);
     PutPixel(xVert, yVertHi, 2);
     J := 1;

     repeat
     for I := 1 to 10 do
     begin
          J := J +5;
          ClearDevice;

          CenterVar := CenterVar -2;
          xVanL := xVanL + 3;
          xVanR := SCREEN_WIDTH + 20 ;
          yVan := 90;
          xSubHozL := 40 + J;
          xSubHozR := SCREEN_WIDTH - 40 -J;
          ySubHoz := 150;
          xSubHozLSize := CenterVar - xSubHozL;
          xSubHozRSize := xSubHozR - CenterVar;
          xSubHozLStep := xSubHozLSize div COLS;
          xSubHozRStep := xSubHozRSize div COLS;
          xVert := CenterVar;
          yVertLow := ySubHoz;
          yVertHi := 50;
          DrawFloor;
          delay(100);
     end;
     until Readkey = 'q';


     CloseGraph;
End.
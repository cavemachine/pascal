Program Grid;

{----- draws a grid using 1 point perspective -----}

uses Crt, Graph;

const
     CENTER_X = 320;
     COLS = 10;
type
    tReta = record
    a, b : Real; { a b from y = ax + b }
    end;
var
   C: Char;
   Gm, Gd, J, K, L, Gap, Col_Space : Integer;
   yHoz, xHozLeft, xHozRight, yBottom, xBottomLeft, xBottomRight : Integer;
   xVan, yVan, xTmp, yTmp, xTmpHozLeft, xTmpHozRight, xTrans, yTrans : Real;
   Eq_RetaLeft, Eq_RetaRight, Eq_RetaTrans, tmpEq : tReta;
   a_S, b_S : String;

{-------------------------------------------}

Procedure getReta(x1, y1, x2, y2: Integer; var Eq: tReta);
var
   a, b : Real;
Begin
   if (x2 - x1) = 0 then x2 := x2+1;
   a := (y2 - y1) / (x2 - x1);
   b := y1 - a*x1;
   Eq.a := a;
   Eq.b := b;
End;

{---------------------------------------------}

Procedure DrawVert(yHoz_, yBottom_: Integer);
Begin
     yHoz := yHoz_;
     xHozLeft := CENTER_X - 60;
     xHozRight := CENTER_x + 60;
     yBottom := yBottom_;
     xBottomLeft := CENTER_X - 250;
     xBottomRight := CENTER_X + 250;

     {---Draw outlines grid ---}

     {SetColor(1);
     SetLineStyle(0,0,0);}
     Line(xHozLeft, yHoz, xBottomLeft, yBottom);
     Line(xHozRight, yHoz, xBottomRight, yBottom);
     Line(xBottomLeft, yBottom, xBottomRight, yBottom);
     Line(xHozLeft, yHoz, xHozRight, yHoz);

     {--- Find vanishing point (equal both equations to get intersect point) ---}

     getReta(xHozLeft, yHoz, xBottomLeft, yBottom, Eq_RetaLeft);
     getReta(xHozRight, yHoz, xBottomRight, yBottom, Eq_RetaRight);
     xVan := (Eq_RetaRight.b - Eq_RetaLeft.b) / (Eq_RetaLeft.a - Eq_RetaRight.a);
     yVan := Eq_RetaLeft.a*xVan + Eq_RetaLeft.b;
     Str(xVan:4:3, a_S);
     OutTextXY(490,40, 'xVan '+a_S);
     Str(yVan:4:3, b_S);
     OutTextXY(490,50, 'yVan '+b_S);

     {--- Draw vertical and horizontal lines inside grid ---}

     getReta(xHozLeft, yHoz, xBottomRight, yBottom, Eq_RetaTrans);
     for J := 1 to COLS do
     Begin
          Gap := ((xBottomRight - xBottomLeft) div COLS) * J;
          getReta(round(xVan), round(yVan), xBottomLeft+Gap, yBottom, tmpEq);
          xTrans := (Eq_RetaTrans.b - tmpEq.b) / (tmpEq.a - Eq_RetaTrans.a);
          yTrans := tmpEq.a*xTrans + tmpEq.b;
          xTmpHozLeft := (yTrans - Eq_RetaLeft.b) / Eq_RetaLeft.a ;
          xTmpHozRight := (yTrans - Eq_RetaRight.b) / Eq_RetaRight.a;

          Line(Round(xTmpHozLeft), round(yTrans), round(xTmpHozRight), round(yTrans));
          xTmp := (yHoz - tmpEq.b) / tmpEq.a; { x = (y-b)/a }
          Line(xBottomLeft+Gap, yBottom, round(xTmp), yHoz);
     End;

     {--- Draw bottom and horizon lines ---}


End;

{---------------------------------------------}
Begin
     Gd := Detect;
     InitGraph(Gd, Gm, ' ');
     OutTextXY(500,100, 'OK');
     Readkey;

     Repeat
     L := 10;
     for K := 1 to 30 do
         Begin
         ClearDevice;
         DrawVert(250-L,150+L);
         L := L + 6;
         { Delay(2);}
         End;
     C := Readkey;
     Until C = 'q';
     CloseGraph;
End.
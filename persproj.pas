Program persproj;

uses Graph, Crt;

Const
     CAM_TO_SCREEN = 1;
     SCREEN_TO_FAR = 2;
     SCREEN_WIDTH = 640;
     SCREEN_HEIGHT = 480;
type
    tPoint = record
    x , y : Integer;
    end;
var
   c : Char;
   I, xpos, ypos, rDepth : Real;
   Gm, Gd, J : Integer;
   S : String;
   UpL, UpR, DownL, DownR : tPoint;
   UpL_, UpR_, DownL_, DownR_ : tPoint;

{---------------------------------------}

function xCartToScreen(x : Real) : Integer;
var
   resul : Real;
begin
   x := x + 1;
   resul := (x/2)*SCREEN_WIDTH;
   xCartToScreen := Round(resul);
end;

function yCartToScreen(y : Real) : Integer;
var
   resul : Real;
begin
   y := y + 1;
   resul := (y/2)*SCREEN_HEIGHT;
   resul := SCREEN_HEIGHT - resul;
   yCartToScreen := Round(resul);
end;

function xScreenToCart(x : Integer) : Real;
var
   x_real, resul : Real;
begin
     x_real := x;
     resul := (x_real / SCREEN_WIDTH)*2;
     resul := resul - 1;
     xScreenToCart := resul;
end;

function yScreenToCart(y : Integer) : Real;
var
   y_real, resul : Real;
begin
     y_real := y;
     resul := (y_real / SCREEN_HEIGHT)*2;
     resul := resul - 1;
     resul := resul * -1;
     yScreenToCart := resul;
end;

function Projection(v, depth : Real) : Real;
var
   resul : Real;
begin
     resul := (CAM_TO_SCREEN*v)/(CAM_TO_SCREEN + depth);
     Projection := resul;
end;

procedure DrawBox(xUpL, xsize, yUpL, ysize, depth: Real);
begin
     UpL.x := xCartToScreen(xUpL);
     UpL.y := yCartToScreen(yUpL);
     UpR.x := xCartToScreen(xUpL+xsize);
     UpR.y := yCartToScreen(yUpL);
     DownL.x := xCartToScreen(xUpL);
     DownL.y := yCartToScreen(yUpL-ysize);
     DownR.x := xCartToScreen(xUpL+xsize);
     DownR.y := yCartToScreen(yUpL-ysize);

     UpL_.x := xCartToScreen (Projection(xScreenToCart(UpL.x), depth));
     UpL_.y := yCartToScreen (Projection(yScreenToCart(UpL.y), depth));
     UpR_.x := xCartToScreen (Projection(xScreenToCart(UpR.x), depth));
     UpR_.y := yCartToScreen (Projection(yScreenToCart(UpR.y), depth));
     DownL_.x := xCartToScreen (Projection(xScreenToCart(DownL.x), depth));
     DownL_.y := yCartToScreen (Projection(yScreenToCart(DownL.y), depth));
     DownR_.x := xCartToScreen (Projection(xScreenToCart(DownR.x), depth));
     DownR_.y := yCartToScreen (Projection(yScreenToCart(DownR.y), depth));

     setLineStyle(1,0,0);

     Rectangle(UpL_.x, UpL_.y, DownR_.x, DownR_.y);

     setFillStyle(9,10);

     Line(UpL.x, UpL.y, UpL_.x, UpL_.y);
     Line(UpR.x, UpR.y, UpR_.x, UpR_.y);
     Line(DownL.x, DownL.y, DownL_.x, DownL_.y);
     Line(DownR.x, DownR.y, DownR_.x, DownR_.y);
     setLineStyle(0,0,0);
     Rectangle(UpL.x, UpL.y, DownR.x, DownR.y);


end;

{------------------------------------------}

begin
     Gd := Detect;
     InitGraph(Gd, Gm, ' ');
     OutTextXY(500,100,'OK');
     setColor(2);

     PutPixel(320, 240, 2);

     Readkey;
     I := 0.1;
     xpos := -0.8;
     ypos := 0.5;
     rDepth := 0.2;

     repeat
     c := ReadKey;
     if c = 'd' then
        begin
             ClearDevice;
             xpos := xpos +I;
             DrawBox(xpos, 0.3, ypos, 0.3, rDepth);
        end;
     if c = 'a' then
        begin
             ClearDevice;
             xpos := xpos -I;
             DrawBox(xpos, 0.3, ypos, 0.3, rDepth);
        end;
     if c = 'w' then
        begin
             ClearDevice;
             ypos := ypos +I;
             DrawBox(xpos, 0.3, ypos, 0.3, rDepth);
        end;
     if c = 's' then
        begin
             ClearDevice;
             ypos := ypos -I;
             DrawBox(xpos, 0.3, ypos, 0.3, rDepth);
        end;
     if c = 'z' then
        begin
             ClearDevice;
             rDepth := rDepth - 0.1;
             DrawBox(xpos, 0.3, ypos, 0.3, rDepth);
        end;
     if c = 'x' then
        begin
             ClearDevice;
             rDepth := rDepth + 0.1;
             DrawBox(xpos, 0.3, ypos, 0.3, rDepth);
        end;
    until c = 'q';

end.
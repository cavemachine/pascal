program nmuncher;

{---- work in progress; number munchers like game ----}
uses Crt, Graph;

const
     J: Integer = 5;

type
    Tplayer = record
        X : Integer;
        Y : Integer;
        X_val : Integer;
        Y_val : Integer;
    end;

var
   Gd, Gm, H, D, i, k: Integer;
   player : Tplayer;
   C : Char;
   S : string;
   Nums : array[1..6,1..5] of Integer;

procedure DrawBoard;
begin
     SetLineStyle(0,0,ThickWidth);
     SetColor(3);
     SetLineStyle(0,0,0);
     D := 50;
     H := 90 + D;
     SetColor(1);
     Rectangle(0,0, 639, 479);
     SetColor(3);
     Rectangle(D, D, 640 - D, 480 - D);

     repeat
          Line(H, D, H, GetMaxY - D);
          H := H + 90;
     until H > 620;

     H := 76 + D;
     repeat
          Line(D, H, GetMaxX - D, H);
          H := H + 76;
     until H > 460;



     {repeat
          Rectangle(H + J, H + J, (GetMaxX - H) - J, (GetMaxY - H) - J);
          H := H + J;
     until H > 230;}

     player.X_val := (90 * player.X) - (90 div 2);
     player.Y_val := (76 * player.Y) - (76 div 2);
     SetColor(6);
     Circle(player.X_val + 50, player.Y_val + 50, 30 );

     {SetFillStyle(1, 6);
     FloodFill(player.X_val + 5, player.Y_val + 5, 6);
     }

end;

begin
     player.X := 6;
     player.Y := 1;

     Gd := Detect;
     InitGraph(Gd, Gm, ' ');
     if GraphResult <> grOk then
     begin
        writeln('Error: ');
        writeln(Grapherrormsg(Gd));
        Halt(1);
     end;

     DrawBoard;

     Randomize;
     SetTextStyle(0,0,2);
     for i := 1 to 6 do
       for k := 1 to 5 do
       begin
         nums[i,k] := random(49) + 1;
         {writeln('numero: [',i,',',k,']: ', nums[i,k]);}
         Str(nums[i,k],S);
         OutTextXY(40 + (i * 90) - (90 div 2), 40 + (k * 76) - (76 div 2), S);
       end;

     repeat
       C := ReadKey;
       Writeln('oi');
       case C of
         'p' :
         begin
              ClearDevice;
              player.X := 2;
              DrawBoard;
              OutTextXY(100,100,'olaaa COMO vai?');
         end;
       end;
     until C = 'w';

     CloseGraph;

end.
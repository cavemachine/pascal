Program Hello;

uses crt, graph;

var
   C : Char;
   nums: array[1..6,1..5] of Integer;
   i, j: integer;
   Gd, Gm: Integer;

procedure tests;
begin
	Writeln('oi');
    Randomize;

    for i := 1 to 6 do
      for j := 1 to 5 do
      begin
        nums[i,j] := random(50);
        writeln('numero: [',i,',',j,']: ', nums[i,j]);
      end;


	repeat
		C := ReadKey;
    case C of
	    'r': Writeln('digitou r');
 	    'e': Writeln('digitou letra e');
      #0 : begin
					   C := Readkey;
             case C of
      			   #75: Writeln('esquerda');
               #77: Writeln('direita');
             end;
           end;
    else
    	Writeln('outra letra ascii:', Ord(C));
  	end;
	until C = 'w';


end;

procedure animate;
var
   backbuf     : pointer;
   backsize, i : word;
begin
   {setfillstyle(6,6);
   bar(0,0,600,30); }
   backsize:=imagesize(0,0,20,20);
   getmem(backbuf,backsize);
   setfillstyle(1,14);
   setcolor(14);
   for i:=1 to 500 do
   begin
      getimage(0+i,0,20+i,20,backbuf^);
      sector(10+i,10,30-(i mod 30),330+(i mod 30),10,10);
      delay(5);
      putimage(0+i,0,backbuf^,0);
   end;
   freemem(backbuf,backsize);
end;



begin
     Gd := Detect;
     InitGraph(Gd, Gm, ' ');
     if GraphResult <> grOk then
     begin
        writeln('Error: ');
        writeln(Grapherrormsg(Gd));
        Halt(1);
     end;
     Readln;
     animate;

end.

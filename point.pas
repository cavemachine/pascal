Program Point;

{------ cube rotating -------}

uses Crt, Graph;
type
    tVertice = record
    x, y, sin, cos: Real;
    hide: Boolean;
    end;
var
   a_b, b_b, c_b, d_b, a_t, b_t, c_t, d_t : tVertice;
   Gm,Gd, J,I: Integer;
   S: String;

Function ToRad(d: Real): Real;
var
   r: Real;
Begin
     r := d*(Pi/180);
     ToRad := r;
End;

Begin
     Gd := Detect;
     InitGraph(Gd,Gm, ' ');
     OutTextXY(100,100,'OK');

     SetColor(2);
     I := 1;


     for J := 1 to 110 do
     begin
       {   setViewPort(100, 100, 350, 350, False);}
          ClearDevice;

          {Rectangle(0,0,250,250);}
          a_b.sin := sin(ToRad(0 + I));
          b_b.sin := sin(ToRad(90 + I));
          c_b.sin := sin(ToRad(180 + I));
          d_b.sin := sin(ToRad(270 + I));
          a_t.sin := a_b.sin;
          b_t.sin := b_b.sin;
          c_t.sin := c_b.sin;
          d_t.sin := d_b.sin;
          a_b.cos := cos(ToRad(0 + I));
          b_b.cos := cos(ToRad(90 + I));
          c_b.cos := cos(ToRad(180 + I));
          d_b.cos := cos(ToRad(270 + I));
          a_t.cos := a_b.cos;
          b_t.cos := b_b.cos;
          c_t.cos := c_b.cos;
          d_t.cos := d_b.cos;

          a_b.x := 300 + (100 * a_b.cos);
          a_b.y := 300 - (30 * a_b.sin);
          a_b.x := a_b.x * (1 - a_b.x / 4000);
          a_b.y := a_b.y * (1 - a_b.y / 4000);
          b_b.x := 300 + (100 * b_b.cos);
          b_b.y := 300 - (30 * b_b.sin);
          b_b.x := b_b.x * (1 - b_b.x / 4000);
          b_b.y := b_b.y * (1 - b_b.y / 4000);

          c_b.x := 300 + (100 * c_b.cos);
          c_b.y := 300 - (30 * c_b.sin);
          c_b.x := c_b.x * (1 - c_b.x / 4000);
          c_b.y := c_b.y * (1 - c_b.y / 4000);

          d_b.x := 300 + (100 * d_b.cos);
          d_b.y := 300 - (30 * d_b.sin);
          d_b.x := d_b.x * (1 - d_b.x / 4000);
          d_b.y := d_b.y * (1 - d_b.y / 4000);

          a_t.x := 300 + 100 * a_b.cos;
          a_t.y := 200 - 30 * a_b.sin;
          a_t.x := a_t.x * (1 - a_t.x / 4000);
          a_t.y := a_t.y * (1 - a_t.y / 4000);

          b_t.x := 300 + 100 * b_b.cos;
          b_t.y := 200 - 30 * b_b.sin;
          b_t.x := b_t.x * (1 - b_t.x / 4000);
          b_t.y := b_t.y * (1 - b_t.y / 4000);

          c_t.x := 300 + 100 * c_b.cos;
          c_t.y := 200 - 30 * c_b.sin;
          c_t.x := c_t.x * (1 - c_t.x / 4000);
          c_t.y := c_t.y * (1 - c_t.y / 4000);

          d_t.x := 300 + 100 * d_b.cos;
          d_t.y := 200 - 30 * d_b.sin;
          d_t.x := d_t.x * (1 - d_t.x / 4000);
          d_t.y := d_t.y * (1 - d_t.y / 4000);


          if a_b.sin > 0.701 then a_b.hide := True else a_b.hide := False;
          if b_b.sin > 0.701 then b_b.hide := True else b_b.hide := False;
          if c_b.sin > 0.701 then c_b.hide := True else c_b.hide := False;
          if d_b.sin > 0.701 then d_b.hide := True else d_b.hide := False;

          if (a_b.hide = False) AND (b_b.hide = False) then
             setLineStyle(0,0,3)
             else
             setLineStyle(1,0,0);
          Line(Round(a_b.x), Round(a_b.y), Round(b_b.x), Round(b_b.y));

          if (b_b.hide = False) AND (c_b.hide = False) then
             setLineStyle(0,0,3)
             else
             setLineStyle(1,0,0);
          Line(Round(b_b.x), Round(b_b.y), Round(c_b.x), Round(c_b.y));
          if (c_b.hide = False) AND (d_b.hide = False) then
             setLineStyle(0,0,3)
             else
             setLineStyle(1,0,0);
          Line(Round(c_b.x), Round(c_b.y), Round(d_b.x), Round(d_b.y));
          if (d_b.hide = False) AND (a_b.hide = False) then
             setLineStyle(0,0,3)
             else
             setLineStyle(1,0,0);
          Line(Round(d_b.x), Round(d_b.y), Round(a_b.x), Round(a_b.y));
          setLineStyle(0,0,3);
          Line(Round(a_t.x), Round(a_t.y), Round(b_t.x), Round(b_t.y));
          Line(Round(b_t.x), Round(b_t.y), Round(c_t.x), Round(c_t.y));
          Line(Round(c_t.x), Round(c_t.y), Round(d_t.x), Round(d_t.y));
          Line(Round(d_t.x), Round(d_t.y), Round(a_t.x), Round(a_t.y));

          if (a_b.hide = False) then
             setLineStyle(0,0,3)
             else
             setLineStyle(1,0,0);
          Line(Round(a_b.x), Round(a_b.y), Round(a_t.x), Round(a_t.y));
          if (b_b.hide = False) then
             setLineStyle(0,0,3)
             else
             setLineStyle(1,0,0);
          Line(Round(b_b.x), Round(b_b.y), Round(b_t.x), Round(b_t.y));
          if (c_b.hide = False) then
             setLineStyle(0,0,3)
             else
             setLineStyle(1,0,0);
          Line(Round(c_b.x), Round(c_b.y), Round(c_t.x), Round(c_t.y));
          if (d_b.hide = False) then
             setLineStyle(0,0,3)
             else
             setLineStyle(1,0,0);
          Line(Round(d_b.x), Round(d_b.y), Round(d_t.x), Round(d_t.y));

          Str(a_b.sin:4:4,S);
          OutTextXY(50,140,'a: '+S);
          Str(b_b.sin:4:4,S);
          OutTextXY(50,150,'b: '+S);
          Str(c_b.sin:4:4,S);
          OutTextXY(50,160,'c: '+S);
          Str(d_b.sin:4:4,S);
          OutTextXY(50,170,'d: '+S);

          I := I + 5;
          delay(10);


     end;
     Readkey;
End.
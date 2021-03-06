picture "my-PSBeispiel"

var x : Num;
var y : Num;
var z : Num;
var p : Path;
var black : Term;
start               % Beginner mit Zeichenansweisungen

x := 3;
y <- x;     % variable y besitzt späte Bindung!
z := x;
x:= 5;

black <- {setcolor(0,0,0);};
setfont("Times", 20);      %Schriftart Times, 20pt

setcolor(1,0,0);  
translate(150, 400,scale(10,10,rotate(45,draw(string2path( ( 0 , 0 ) ,"Myps")))));
black; % Setze die farbe auf schwarz
write((100,680),"Spaete bindung: y=");
write(num2string(y)); %y hat den Wert 5
write((100,680));
write( num2string ( z ) ) ; %z hat den Wert 3

%Zeichne einige Kreisbogen in unterschiedlichen Farben
for i:= 0 to 340 step 20 do
  for r:= 20 to 100 step 5 do
    p:=arc((300,300),r*i*0.01,i+5,360);
    setcolor (i/340,r/100,1);
    draw(p);
  done;
done;

setlinewidth(10) ;
black;

p:=plot(0,0,200,0,3*360, ( t , sin( t )));  %TODO: MANY STUFF MISSING
translate(100,100, { draw ( scalebox( 400,200,p));});

end

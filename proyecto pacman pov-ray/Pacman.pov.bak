   //Proyecto Graficos por computador II PArcial 
   //Animacion por Pov-Ray
   //Integrantes: 
   //Adriano Pinargote
   //Sianna Puente
   //Julio LArrea
   
   
    #include "colors.inc"

    camera
    {
    location <clock+6, 3, -15>
    look_at <clock, 0, 0>
    }
    
    plane
    {
    <0, 1, 0>, -2
    pigment {checker color Blue, color SkyBlue scale 5 }
    }
    
#declare pacman = difference
{
 sphere
 {
  <0,0,0>,2
  #if(clock<80 | clock>100 ) texture { pigment { color rgb<1, 1, 0> }}
  #else texture { pigment { color rgbt<1, 0, 0, (clock-80)/20> }}
  #end
  finish{ reflection { 0.1, metallic }}
 }
 
prism
{
0.00, 4.00, // (Altura) , el principio y el final en la dirección y
4 // número de puntos que componen la forma
   // Puntos que definen el objeto < x , z > ( gran³pu base) :
   < 0.00 , 0.00 > // primer punto debe ser el último 
   < 2.00, sin(clock/4)>,
   < 2.00, -sin(clock/4)>,
   < 0.00, 0.00>
  texture { pigment { color rgb<1, 1, 0> }}
  
  rotate <90,0,0>
  translate<0,0,-2>
}
}


object { pacman translate <clock, 0, 0>}


box { <0,0,0> <2,2,2>
      #if(clock<20)
      texture { pigment { color rgb<0, 1, 0> }}
      #else texture { pigment { color rgbt<1, 1, 1, 1> }}
      #end
      translate <20,-1,0>
     }
     
box { <0,0,0> <2,2,2>
      #if(clock<25)
      texture { pigment { color rgb<0, 1, 0> }}
      #else texture { pigment { color rgbt<1, 1, 1, 1> }}
      #end
      translate <24,-1,0>
     }
     
cone{<0,0,0>,1.0,<0,2,0>,0.5
      #if(clock<40)
      texture { pigment { color rgb<0, 1, 0> }}
      #else texture { pigment { color rgbt<1, 1, 1, 1> }}
      #end
      translate <40,-1,0>
     }
     
cylinder{
      <0,0,0><0,2,0>1
      #if(clock<58)
      texture { pigment { color rgb<0, 1, 0> }}
      #else texture { pigment { color rgbt<1, 1, 1, 1> }}
      #end
      translate <58,-1,0>
      }
      
box { <0,0,0> <2,2,2>
      #if(clock<80)
      texture { pigment { color rgb<1, 0, 0> }}
      #else texture { pigment { color rgbt<1, 1, 1, 1> }}
      #end
      translate <80,-1,0>
     }
     
box { <0,0,0> <2,2,2>
      #if(clock<100)
      texture { pigment { color rgb<0, 1, 0> }}
      #else texture { pigment { color rgbt<1, 1, 1, 1> }}
      #end
      translate <100,-1,0>
     }
     
    light_source { <20, 20, 0> color White} // Los soportes de luz
    light_source { <clock+10, 30, -18> color White}  // La luz se mueve a través de kramer
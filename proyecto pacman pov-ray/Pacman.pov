   //Proyecto Graficos por computador II PArcial 
   //Animacion por Pov-Ray
   //Integrantes: 
   //Adriano Pinargote
   //Sianna Puente
   //Julio LArrea
   
   
#include "colors.inc"
#include "textures.inc"

camera
{

    
    #if (clock<17 | (clock >27 & clock<=35) | (clock >38 & clock<=52) | (clock >59 & clock<=75) | (clock >83 & clock<=95) |(clock >101 & clock<=117)) 
        
        location <clock-6, 3,-5>
        look_at <clock+20, 0, 0> 
    #else
        location <clock+6, 3, -15>
        look_at <clock, 0, 0>
    #end      
    //#else 
   // rotate   <0,-angulo,0>
    
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
   < 2.00, sin(clock/2)>,
   < 2.00, -sin(clock/2)>,
   < 0.00, 0.00>
  #if(clock<80 | clock>100 )
  texture { pigment { color rgb<1, 1, 0> }}
  #else texture { pigment { color rgbt<1, 0,0, (clock-80)/20> }}
  #end
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
      //rotate <0,180*(clock/12),0>
      translate <20,-1,0>
      
      
     } 
     
     
box { <0,0,0> <2,2,2>
      #if(clock<25)
      texture { pigment { color rgb<0, 1, 0> }}
      #else texture { pigment { color rgbt<1, 1, 1, 1> }}
      #end
      //rotate <0,360*(clock+0.1),0>
      translate <24,-1,0>
     }
     
cone{<0,0,0>,1.0,<0,2,0>,0.5
      #if(clock<40)
      texture { pigment { color rgb<0, 1, 0> }}
      #else texture { pigment { color rgbt<1, 1, 1, 1> }}
      #end
      //rotate <0,45*(clock+0.1),0>
      translate <40,-1,0>       
     }
     
cylinder{
      <0,0,0><0,2,0>1
      #if(clock<58)
      texture { pigment { color rgb<0, 1, 0> }}
      #else texture { pigment { color rgbt<1, 1, 1, 1> }}
      #end
      //rotate <0,360*(clock+0.1),0>
      translate <58,-1,0>
      }
      
box { <0,0,0> <2,2,2>
      #if(clock<80)
      texture { pigment { color rgb<1, 0, 0> }}
      #else texture { pigment { color rgbt<1, 1, 1, 1> }}
      #end
      //rotate <0,360*(clock-0.1),0>
      translate <80,-1,0>
     }
     
box { <0,0,0> <2,2,2>
      #if(clock<100)
      texture { pigment { color rgb<0, 1, 0> }}
      #else texture { pigment { color rgbt<1, 1, 1, 1> }}
      #end
      //rotate <0,360*(clock-0.1),0>
      translate <100,-1,0>
     }

// DISEÑO DE ESTRELLA ////
// REFERENCIA: http://www.f-lohmueller.de/pov_tut/x_sam/sam_400e.htm

#declare Ray_Profile = 
box { <-1,-1,-1>,< 1,1,1> 
       scale <1,1,1>*sqrt(2) 
      #if(clock<120)
      texture { pigment{ color rgb<0.5,1.0,0.0>*1.0}  
                finish { phong 1}
              } // end of texture 
      #else
      texture { pigment{ color rgbt<1,1,1>}  
                finish { phong 1}
              } // end of texture
      #end
       rotate<0,0,45>
       scale <1,0.36,1> 
       rotate< 45,0,0>
    } // end of box ---------------------------------------
 
 
#declare Ray =
intersection{
object{ Ray_Profile }  
object{ Ray_Profile scale<1,1,-1>}  
box{ <-2,-1,-1>,<0,1,1> 
     texture { pigment{ color rgb<1,0.0,0.3>}  
               finish { phong  1}
             } // end of texture
    inverse   
   }// end of box
scale<1,0.5,0.5>
}


union{
 #local Nr = 0;     // start
 #local EndNr = 5;  // end
 #while (Nr < EndNr)
 object{Ray rotate<0,Nr*360/EndNr,0>}
 #local Nr = Nr + 1;// next Nr
 #end // ------------- end of loop
rotate<0,0,90>
translate<120,0,0>
} // end of union
     
    light_source { <20, 20, 0> color White} // Los soportes de luz
    light_source { <clock+10, 30, -18> color White}  // La luz se mueve a través de kramer
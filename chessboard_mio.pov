#version 3.7;
global_settings { assumed_gamma 1.2 } 

#include "colors.inc"
#include "textures.inc"
#include "shapes.inc"
#include "metals.inc"
#include "glass.inc"

#include "woods.inc" 


camera {
   location <10,15,10>//location <-5, 10, -15>
   angle 45 // direction <0, 0,  1.7>
   right x*image_width/image_height
   look_at <0,0,0>
}

// Uncomment the area lights only if you've got lots of time.
#declare Dist=160.0;
light_source {< -50, 25, -50> color White
     fade_distance Dist fade_power 2
//   area_light <-40, 0, -40>, <40, 0, 40>, 3, 3
//   adaptive 1
//   jitter
}
light_source {< 50, 10,  -4> color Gray30
     fade_distance Dist fade_power 2
//   area_light <-20, 0, -20>, <20, 0, 20>, 3, 3
//   adaptive 1
//   jitter
}
light_source {< 0, 100,  0> color Gray30
     fade_distance Dist fade_power 2
//   area_light <-30, 0, -30>, <30, 0, 30>, 3, 3
//   adaptive 1
//   jitter
}

plane { <0,1,0> // normal vector
      , 0 // distance from origin
  pigment {
    checker color White, color Blue
  }
}

// DEFINIMOS LA ESFERA
sphere {<-5,1,-4>, 1 texture{pigment{color Black transmit .5 }finish{phong .8}} interior {ior 1.0}}              

box {< 1,1,1>, <2,2,2> texture{pigment{color Gray transmit .5 }finish{phong .2}} interior {ior 5.0}}

//DEFINIMOS LA CAJA
box {
<0,0,0>,
<2,2,2>

translate<2,2,4>
texture{pigment{color Red filter 1 }finish{phong .8}} interior {ior 1.0}
//rotate <0,20,0> //Rotar 20 grados respecto a eje Y
//El sentido de los giros se hacen usando la regla de la mano izquierda
rotate y*-5 //-15 grados en y
rotate z*30 //30 grados en z
}                       


//DEFINIMOS EL TOROIDE

torus { 1, 0.6 // radio externo y grosor del toro
translate 1*y //Trasladar 2 unidades en eje Y
texture{pigment{color Blue transmit .5 }finish{phong .8}} interior {ior 1.0}
translate <clock, 0, -5>
}                                          

